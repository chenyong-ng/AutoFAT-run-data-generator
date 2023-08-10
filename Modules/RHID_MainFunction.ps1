function RHID_MainFunctions {
. $PSScriptRoot\Set-WindowStyle.ps1
. $PSScriptRoot\set-volume.ps1
. $PSScriptRoot\Set-ScreenResolutionEx.ps1
. $PSScriptRoot\AdapterTypes.ps1
set-variable -name "serverdir" -value "E:\RapidHIT ID"
Write-Host "$info : Reading from local machine $env:COMPUTERNAME folder"
. $PSScriptRoot\RHID_MiniFunctions.ps1
}
 # Main function to check whether if it's RHID instrument or Workstation