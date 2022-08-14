#region identify who has access

$adams = (get-acl -Path C:\home\adam.smith31).Access

foreach($adam in $adams){
    if($adam.IdentityReference -like "company\*" -and $adam.FileSystemRights -contains "FullControl"){
        Write-Host $adam.IdentityReference -ForegroundColor Cyan
        Write-Host $adam.FileSystemRights -ForegroundColor Cyan
        Write-Host $adam.IsInherited -ForegroundColor Cyan
        Write-Host $adam.InheritanceFlags -ForegroundColor Cyan
        Write-Host $adam.PropagationFlags -ForegroundColor Cyan

    }elseif($adam.IdentityReference -like "company\*" -and $adam.FileSystemRights -like "ReadAndExecute*"){
        Write-Host $adam.IdentityReference -ForegroundColor Green
    }
}

#endregion


#region create a blanked out ACL

 $blank = get-acl C:\temp\test4   #c:\temp\test has had all of it inheritance and security permission removed

 set-acl -Path C:\home\Adam.Smith31 -AclObject $blank

 #endregion

 
 #region add the permissions back

$folderPath = "C:\home\Adam.Smith31"  #this one has been blanked.
$user = "company\Adam.Smith31"
$acl = Get-Acl -Path $folderPath 
$allowOrDeny = "Allow"
$accessType =  "FullControl"# "ReadAndExecute" "Write" "read""read", "Write", "Synchronize"
#New-Object System.Security.AccessControl.FileSystemAccessRule(IdentityReference,FileSystemRights,InheritanceFlags,PropagationFlags,AccessControlType)
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user,$accessType,"ContainerInherit,ObjectInherit","None",$allowOrDeny)



$acl.SetAccessRule($accessRule)

$acl | Set-acl $folderPath

 #endregion

