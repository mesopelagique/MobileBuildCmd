#!/bin/bash
workingDir=$(mktemp -d -t ci-XXXXXXXXXX)
          
echo "📦 Download MobileBuildCmd app"
workingDir="$workingDir/MobileBuildCmd.4dbase"
git clone --branch v1 https://github.com/mesopelagique/MobileBuildCmd.git $workingDir 

echo "🟦 Download 4D app"
curl $1 -o 4DServer.zip
unzip -qq 4DServer.zip -d $workingDir
rm -f 4DServer.zip

echo "🧸 Launch entrypoint"
chmod +x $workingDir/entrypoint.sh
$workingDir/entrypoint.sh "$2" "$3"
