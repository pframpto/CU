#Viewing all the access details

Get-Acl .\Directory | Format-List

#Getting the owner of a directory

(Get-Acl .\Directory\).Owner

#Access Right Details

(Get-Acl .\Directory\).Access

#Modifying ACL

$acl = Get-Acl .\Directory\   #this gets the current acl object for the directory.

$acl = New-Object System.Security.AccessControl.DirectorySecurity #this is an alternate way of creating a blank acl object.

#Setting Ownership

$owner = New-Object System.Security.Principal.NTAccount("BUILTIN\Administrators")
$acl.SetOwner($owner)

#Creating A New FileSystem Access Rule

$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("DOMAIN\larntz","Write","ContainerInherit,ObjectInherit","None","Allow")

#After creating the rule we can apply it to our $acl object using the SetAccessRule() method.

$acl.SetAccessRule($rule)


#region Removing an access rule
$acl = New-Object System.Security.AccessControl.DirectorySecurity
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("DOMAIN\larntz","Read,CreateFiles","ContainerInherit,ObjectInherit","None","Allow")
$acl.SetAccessRule($rule)
$acl.Access

    <#
        FileSystemRights  : CreateFiles, Read, Synchronize
        AccessControlType : Allow
        IdentityReference : DOMAIN\larntz
        IsInherited       : False
        InheritanceFlags  : ContainerInherit, ObjectInherit
        PropagationFlags  : None
    #>

$acl.RemoveAccessRule($rule)
#True
$acl.Access
#PS C:\>

#endregion

#Saving the ACL Changes

(Get-Item .\Directory\ChildDirectory\).SetAccessControl($acl)












