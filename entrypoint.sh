#!/bin/bash

workingDirectory=$(pwd)

# parameters
projectFile=$1
options=$2

if [ -z "$options" ]; then
  options="{}"
fi

if [ -z "$projectFile" ]; then
  projectFile=`find $workingDirectory -name "*.4dmobileapp" -not -path "./Components/*" | head -n 1`
  projectFile="$projectFile" # get parent?
else
  projectFile=$(pwd)/$projectFile
fi

echo "👷 Generate mobile project $projectFile"

# get current dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# launch compiler
if [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
  compilerOptions="--dataless --headless"
  compiler="$DIR/4D.app/Contents/MacOS/4D"
  if [ ! -f "$compiler" ]; then
    compiler="$DIR/tool4d.app/Contents/MacOS/4D"
  fi
  if [ ! -f "$compiler" ]; then
    compiler="$DIR/4D Server.app/Contents/MacOS/4D Server"
    compilerOptions="--dataless"
  fi
else # linux based
  compilerOptions="--dataless"
  compiler=$DIR/bin/4d-server 
fi

builder="$DIR/Project/MobileBuildCmd.4DProject"

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
output="$tmp_dir/build.log" # redirect because 4D do not use stderr and return a correct status code according to build result

echo "⚙️ Launching builder database"

# echo "▪️ $compiler $options -p $builder --user-param {\"path\":\"$projectFile\",\"options\":{}}"
"$compiler" $compilerOptions -p "$builder" --user-param "{\"path\":\"$projectFile\", \"workingDirectory\":\"$workingDirectory\" ,\"options\":$options}" > $output 2>&1
statusCode=$?

echo "" >> $output # ensure a blanc final line

# manage output to exit with a correct status
while IFS= read -r line
do
  if [[ $line == *"::error"* ]]; then
    >&2 echo "$line"
    statusCode=1
  else
    echo "$line"
  fi
done < "$output"

rm -f $output

exit $statusCode
