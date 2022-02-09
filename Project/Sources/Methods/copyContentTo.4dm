//%attributes = {}
#DECLARE($folder : Object; $destination : 4D:C1709.Folder)  // fk overwrite ?

var $children : Object

If (Not:C34($destination.exists))
	$destination.create()
End if 

For each ($children; $folder.folders())
	$children.copyTo($destination; fk overwrite:K87:5)
End for each 
For each ($children; $folder.files())
	$children.copyTo($destination; fk overwrite:K87:5)
End for each 