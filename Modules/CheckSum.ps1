
$ScriptPreCheck =
Test-Path -Path $PSScriptRoot\CheckSum.ps1 ,
$PSScriptRoot\AdapterTypes.ps1 ,
$PSScriptRoot\Branch.ps1 ,
$PSScriptRoot\Info_Screens.ps1 ,
$PSScriptRoot\Report_Automation.ps1 ,
$PSScriptRoot\RHID_CoverOnTest.ps1 ,
$PSScriptRoot\RHID_Descriptions.ps1 ,
$PSScriptRoot\RHID_DryTest.ps1 ,
$PSScriptRoot\RHID_DryTestHeader.ps1 ,
$PSScriptRoot\RHID_Hardware.ps1 ,
$PSScriptRoot\RHID_MainFunction.ps1 ,
$PSScriptRoot\RHID_Report.ps1 ,
$PSScriptRoot\RHID_ShipPrep.ps1 ,
$PSScriptRoot\RHID_Str.ps1 ,
$PSScriptRoot\RHID_WetTest.ps1 ,
$PSScriptRoot\RHID_XmlWriter.ps1 ,
$PSScriptRoot\RunSummaryCSV.ps1 ,
$PSScriptRoot\Set-ScreenResolutionEx.ps1 ,
$PSScriptRoot\set-volume.ps1 ,
$PSScriptRoot\Set-WindowStyle.ps1 ,
$PSScriptRoot\TC_VerificationTXT.ps1 ,
$PSScriptRoot\VerboseMode.ps1 ,
$PSScriptRoot\XML_and_Config.ps1 -PathType Leaf


(Get-FileHash $PSScriptRoot\..\Script_automation.bat ,
$PSScriptRoot\AdapterTypes.ps1 ,
$PSScriptRoot\Branch.ps1 ,
$PSScriptRoot\CheckSum.ps1 ,
$PSScriptRoot\Info_Screens.ps1 ,
$PSScriptRoot\Report_Automation.ps1 ,
$PSScriptRoot\RHID_CoverOnTest.ps1 ,
$PSScriptRoot\RHID_Descriptions.ps1 ,
$PSScriptRoot\RHID_DryTest.ps1 ,
$PSScriptRoot\RHID_DryTestHeader.ps1 ,
$PSScriptRoot\RHID_Hardware.ps1 ,
$PSScriptRoot\RHID_MainFunction.ps1 ,
$PSScriptRoot\RHID_Report.ps1 ,
$PSScriptRoot\RHID_ShipPrep.ps1 ,
$PSScriptRoot\RHID_Str.ps1 ,
$PSScriptRoot\RHID_WetTest.ps1 ,
$PSScriptRoot\RHID_XmlWriter.ps1 ,
$PSScriptRoot\RunSummaryCSV.ps1 ,
$PSScriptRoot\Set-ScreenResolutionEx.ps1 ,
$PSScriptRoot\set-volume.ps1 ,
$PSScriptRoot\Set-WindowStyle.ps1 ,
$PSScriptRoot\TC_VerificationTXT.ps1 ,
$PSScriptRoot\XML_and_Config.ps1 -Algorithm SHA256).hash
# Get-FileHash is bugged in Powershell 5.1, only hashing and compare hastable in Powershell 7

$ScriptPreCheckCounter = ($ScriptPreCheck | select-string "true").count

if ($ScriptPreCheckCounter -eq 23) {
    "[ Info       ] : $ScriptPreCheckCounter Scripts pre-run check passed"
    start-sleep 1
} elseif ($ScriptPreCheckCounter -lt 23) {
    "[ Error      ] : Scripts count $ScriptPreCheckCounter checksum failed, Script execution may not produce correct results"
}