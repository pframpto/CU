$folderPath ='c:\home\doc'

$user = ""

$acl = Get-Acl $folderPath

$allowOrDeny = "Allow"

$accessType = "FullControl"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user,$accesstype,$allowOrDeny)

$acl.SetAccessRule($AccessRule)

$acl | Set-acl $folderPath