#
# User Creation Script in AAD.ps1
#
# Connect-AzureRmAccount
# Select-AzureRmSubscription "Visual Studio Enterprise" -TenantId 9422eda6-5780-44fb-af2d-f3f330018410

#Install-Module -Name AzureAD -Verbose -Force
#Get-InstalledModule -Name AzureAD -AllVersions

###############        Crete User section ###########################################################################
###############        https://docs.microsoft.com/en-us/powershell/module/azuread/new-azureaduser?view=azureadps-2.0

# USER could be  part of a GROUP and ROLE applied to that group will automatically inherited by the user
# ROLE could also be directly applied to the USER as well

#ROLE is a collection of PERMISSION
#GROUP is a collection of USER

Connect-AzureAD -TenantId 9422eda6-5780-44fb-af2d-f3f330018410 -Confirm

#User creation Section
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "Password1$" 

$Name = "AADUserAppAdmin"
$DisplayName = "UserWithApplicationAdminRole"
$MailNickName = "AADUserAppAdmin"
### UserPrincipalName (Convention is MailNickName@domain , and the domain name AzureAAD domain name)
$UPN = "AADUserAppAdmin@AvanadeSubsAAD.onmicrosoft.com"

New-AzureADUser -AccountEnabled $True -DisplayName $DisplayName -PasswordProfile $PasswordProfile -MailNickName $MailNickName -UserPrincipalName $UPN

##################################################################### Diretory Role Assignment Creation Section
# Fetch user to assign to role
$roleMember = Get-AzureADUser -ObjectId "AADUserAppAdmin@AvanadeSubsAAD.onmicrosoft.com"

# Fetch User Account Administrator role instance
$role = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq 'Application Administrator'}

# If role instance does not exist, instantiate it based on the role template
if ($role -eq $null) {
    # Instantiate an instance of the role template
    $roleTemplate = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.displayName -eq 'Application Administrator'}
    Enable-AzureADDirectoryRole -RoleTemplateId $roleTemplate.ObjectId

    # Fetch User Account Administrator role instance again
    $role = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq 'Application Administrator'}
}

# Add user to role
Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId $roleMember.ObjectId

# Fetch role membership for role to confirm
Get-AzureADDirectoryRoleMember -ObjectId $role.ObjectId | Get-AzureADUser

##################################################################### Assign Subscription Grant Access through RBAC to the newly created user
#Get Subscription id 
Get-AzureRmSubscription
#Grant Access
##################################################################### Diretory Role Assignment Creation Section
New-AzureRmRoleAssignment -SignInName "AADUserAppAdmin@AvanadeSubsAAD.onmicrosoft.com" -RoleDefinitionName "Contributor" -Scope /subscriptions/<<subscription id from Get_AzureRmSubscription>>


