function Get-CUDirectoryOwner {
    [cmdletBinding()]
    param(
        $path
    )

    (get-acl -Path $path).Owner
}

#Get-CUDirectoryOwner -path "C:\home\adam.odempsey"

Function Set-CUDirectoryOwner {
    [cmdletBinding()]
        param(
            $path,
            $owner
        )
        $acl = Get-Acl $path
        $NewOwner = New-Object System.Security.Principal.NTAccount($owner)
        $acl.SetOwner($NewOwner)
        set-acl -AclObject $acl -Path $path
}

Set-CUDirectoryOwner -path "C:\home\adam.odempsey" -owner "company\adam.odempsey"