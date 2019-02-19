#
##########################################    CreateResourceGroup.ps1
#

Connect-AzureRmAccount
New-AzureRmResourceGroup -Name RsgEastUS -Location 'East US'