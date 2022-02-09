//%attributes = {}
$dev:=True:C214  // Shift down or Structure file(*)=Structure file ?

If (Not:C34($dev))
	ON ERR CALL:C155("onError")  // ignore all, do not want to block CI
End if 

var $r : Real
var $startupParam : Text
$r:=Get database parameter:C643(User param value:K37:94; $startupParam)
$startupParam:="{}"  //TODO: to remove
If (Length:C16($startupParam)=0)
	print("::error ::No parameters passed to database")
	return 
End if 

// MARK:- read parameters
print("...parsing parameters")
var $config : Object
$config:=JSON Parse:C1218($startupParam)
// defaults
If ($config.create=Null:C1517)
	$config.create:=True:C214
End if 
If ($config.name=Null:C1517)
	$config.name:="MobileProject"
End if 

If ($config.output=Null:C1517)
	// TODO: maybe in temp directory but must be cleaned...
	
	$Dir_root:=mobileUnit("pathname"; New object:C1471("target"; "projects"))
	$outputFolder:=Folder:C1567($Dir_root.value+$config.name+Folder separator:K24:12; fk platform path:K87:2)
	
Else 
	$outputFolder:=Folder:C1567($config.output; fk posix path:K87:1)
End if 


If ($config.project=Null:C1517)
	If ($dev)
		$projectFile:=Folder:C1567(fk resources folder:K87:11).file("project.4dmobileapp")
		
/*copyContentTo(Folder(mobileUnit("pathname"; New object("target"; "project")).value; fk platform path); $projectFile.parent)\
*/
		
		
	Else 
		print("::error ::No project file")
		return 
	End if 
Else 
	// TODO: if a folder Folder($config.project).file("project.4dmobileapp")
	// TODO: if an archive, maybe unarchive, 
	$projectFile:=File:C1566($config.project; fk posix path:K87:1)
End if 

If (Not:C34($projectFile.exists))
	print("::error ::Project file not exists at path "+$projectFile.path)
	return 
End if 

$project:=JSON Parse:C1218($projectFile.getText())
$project.$project:=New object:C1471("product"; $config.name)
$project._folder:=$projectFile.parent  // not very clean, except if we move input file into this folder

$param:=New object:C1471(\
"project"; $project; \
"create"; $config.create; \
"build"; $config.build; \
"run"; $config.run; \
"archive"; $config.archive; \
"template"; "list"; \
"path"; $outputFolder.platformPath; \
"testing"; True:C214)
$result:=mobileUnit("project"; $param)

ASSERT:C1129($result.success; "Failed to generate the project"+$Txt_projectName+". "+JSON Stringify:C1217($Obj_result))

// TODO: output to a log , maybe path from config

If ($dev)
	SHOW ON DISK:C922($outputFolder.platformPath)
Else 
	QUIT 4D:C291
End if 
