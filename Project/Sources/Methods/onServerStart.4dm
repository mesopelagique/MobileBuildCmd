//%attributes = {}
var $dev : Boolean
$dev:=Structure file:C489(*)=Structure file:C489

If (Not:C34($dev))
	ON ERR CALL:C155("onError")  // ignore all, do not want to block CI
End if 

var $r : Real
var $startupParam : Text
$r:=Get database parameter:C643(User param value:K37:94; $startupParam)
If (Length:C16($startupParam)=0)
	print("::error ::No parameters passed to database")
	QUIT 4D:C291
	return 
End if 

var $config; $project; $param; $result : Object

// MARK:- read parameters
print("...parsing parameters")

$config:=JSON Parse:C1218($startupParam)
// defaults values
If ($config.create=Null:C1517)
	$config.create:=True:C214
End if 

// check parameters
If (Length:C16(String:C10($config.path))=0)
	print("::error ::correct project file path")
	QUIT 4D:C291
	return 
End if 

If (Folder:C1567($config.path).exists)
	$config.path:=Folder:C1567($config.path).file("project.4dmobileapp").path  // if folder, get the default file name
End if 

If (Not:C34(File:C1566($config.path).exists))
	print("::error ::project file "+$config.path+" do not exists")
	QUIT 4D:C291
	return 
End if 

$config.file:=File:C1566($config.path)
$config.workingDirectory:=Folder:C1567($config.workingDirectory; fk posix path:K87:1)
If ($config.name=Null:C1517)
	$config.name:=$config.file.parent.name
End if 

If ($config.output=Null:C1517)
	$config.output:=$config.workingDirectory.folder("Output")
	
Else 
	$config.output:=Folder:C1567($config.output; fk posix path:K87:1)
End if 

// MARK:- generate the mobile app
$project:=JSON Parse:C1218($config.file.getText())
$project.$project:=New object:C1471("product"; $config.name)
$project._folder:=$config.file.parent
$project.project:=New object:C1471("name"; "XcodeProject")

$param:=New object:C1471(\
"project"; $project; \
"create"; $config.create; \
"build"; $config.build; \
"noData"; True:C214; \
"run"; $config.run; \
"archive"; $config.archive; \
"template"; "list"; \
"path"; $config.output.platformPath; \
"testing"; True:C214)
$result:=mobileUnit("project"; $param)

LOG EVENT:C667(Into system standard outputs:K38:9; JSON Stringify:C1217($result))
ASSERT:C1129($result.success; "Failed to generate the project"+$config.name+". "+JSON Stringify:C1217($result))

// TODO: output to a log , maybe path from config

// MARK:- end
If ($dev)
	SHOW ON DISK:C922($config.output.platformPath)
Else 
	QUIT 4D:C291
End if 
