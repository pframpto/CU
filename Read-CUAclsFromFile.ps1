#getting the acls of a file and writing it to a file c:\temp\perms.txt

$fileAcls = (get-acl -Path C:\home\adam.odempsey).Access

foreach($fileAcl in $fileAcls){
    if($fileAcl.IdentityReference -like "company\*"){
        Write-Verbose $fileAcl.IdentityReference -Verbose
        Write-Verbose $fileAcl.FileSystemRights -Verbose
    }
}