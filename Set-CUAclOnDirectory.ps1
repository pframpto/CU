
function Set-CUAclOnDirectory {
    [cmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        $Directory,
        [Parameter(Mandatory=$true)]
        $IdentityReference,
        [Parameter(Mandatory=$true)]
        [ValidateSet("FullControl", "ReadAndExecute", "Write", "Modify", "Read" , "Write, ReadAndExecute, Synchronize", "Read, Synchronize")]
        $FileSystemRights,
        $InheritanceFlags="ContainerInherit,ObjectInherit",
        $PropagationFlags="None",
        $AccessControlType="Allow"
    )
    
    #create blank ACL
    
    $acl = New-Object System.Security.AccessControl.DirectorySecurity
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference,$FileSystemRights,$InheritanceFlags,$PropagationFlags,$AccessControlType)
    $acl.SetAccessRule($rule)
    Write-Verbose $Directory
    (Get-Item $Directory).SetAccessControl($acl)
}

function Remove-CUAclOnDirectory {
    [cmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        $Directory,
        [Parameter(Mandatory=$true)]
        $IdentityReference,
        [Parameter(Mandatory=$true)]
        [ValidateSet("FullControl", "ReadAndExecute", "Write", "Modify", "Read", "Write, ReadAndExecute, Synchronize", "Read, Synchronize")]
        $FileSystemRights,
        $InheritanceFlags="ContainerInherit,ObjectInherit",
        $PropagationFlags="None",
        $AccessControlType="Allow"
    )
    
    #create blank ACL
    
    $acl = New-Object System.Security.AccessControl.DirectorySecurity
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference,$FileSystemRights,$InheritanceFlags,$PropagationFlags,$AccessControlType)
    $acl.RemoveAccessRule($rule)
    Write-Verbose $Directory
    (Get-Item $Directory).SetAccessControl($acl)
}

#Set-CUAclOnDirectory -Directory C:\home\adam.odempsey -IdentityReference "company\SydneyUsers" -FileSystemRights Modify
#Remove-CUAclOnDirectory -Directory C:\home\allan.ferguson1 -IdentityReference "company\adam.odempsey" -FileSystemRights FullControl
#Set-CUAclOnDirectory -Directory C:\home\adam.odempsey -IdentityReference "company\adam.smith31" -FileSystemRights "Write, ReadAndExecute, Synchronize"