
$File_Script_automation = "$PSScriptRoot\..\Script_automation.bat"
$File_CheckSum          = "$PSScriptRoot\CheckSum.ps1"
$File_AdapterTypes      = "$PSScriptRoot\AdapterTypes.ps1"
$File_Branch            = "$PSScriptRoot\Branch.ps1"
$File_Info_Screens      = "$PSScriptRoot\Info_Screens.ps1"
$File_Report_Automation = "$PSScriptRoot\Report_Automation.ps1"
$File_RHID_CoverOnTest  = "$PSScriptRoot\RHID_CoverOnTest.ps1"
$File_RHID_Descriptions = "$PSScriptRoot\RHID_Descriptions.ps1"
$File_RHID_DryTest      = "$PSScriptRoot\RHID_DryTest.ps1"
$File_RHID_DryTestHeader = "$PSScriptRoot\RHID_DryTestHeader.ps1"
$File_RHID_Hardware     = "$PSScriptRoot\RHID_Hardware.ps1"
$File_RHID_MainFunction = "$PSScriptRoot\RHID_MainFunction.ps1"
$File_RHID_Report       = "$PSScriptRoot\RHID_Report.ps1"
$File_RHID_ShipPrep     = "$PSScriptRoot\RHID_ShipPrep.ps1"
$File_RHID_Str          = "$PSScriptRoot\RHID_Str.ps1"
$File_RHID_WetTest      = "$PSScriptRoot\RHID_WetTest.ps1"
$File_RHID_XmlWriter    = "$PSScriptRoot\RHID_XmlWriter.ps1"
$File_RunSummaryCSV     = "$PSScriptRoot\RunSummaryCSV.ps1"
$File_SetScreenResolutionEx = "$PSScriptRoot\Set-ScreenResolutionEx.ps1"
$File_setvolume         = "$PSScriptRoot\set-volume.ps1"
$File_SetWindowStyle    = "$PSScriptRoot\Set-WindowStyle.ps1"
$File_TC_VerificationTXT= "$PSScriptRoot\TC_VerificationTXT.ps1"
$File_VerboseMode       = "$PSScriptRoot\VerboseMode.ps1"
$File_XML_and_Config    = "$PSScriptRoot\XML_and_Config.ps1"

$ScriptPreCheck = Test-Path -Path $File_Script_automation ,
$File_CheckSum          ,
$File_AdapterTypes      ,
$File_Branch            ,
$File_Info_Screens      ,
$File_Report_Automation ,
$File_RHID_CoverOnTest  ,
$File_RHID_Descriptions ,
$File_RHID_DryTest      ,
$File_RHID_DryTestHeader,
$File_RHID_Hardware     ,
$File_RHID_MainFunction ,
$File_RHID_Report       ,
$File_RHID_ShipPrep     ,
$File_RHID_Str          ,
$File_RHID_WetTest      ,
$File_RHID_XmlWriter    ,
$File_RunSummaryCSV     ,
$File_SetScreenResolutionEx,
$File_setvolume         ,
$File_SetWindowStyle    ,
$File_TC_VerificationTXT,
$File_VerboseMode       ,
$File_XML_and_Config -PathType Leaf

$ScriptMetadata = (Get-FileHash $File_Script_automation ,
$File_CheckSum          ,
$File_AdapterTypes      ,
$File_Branch            ,
$File_Info_Screens      ,
$File_Report_Automation ,
$File_RHID_CoverOnTest  ,
$File_RHID_Descriptions ,
$File_RHID_DryTest      ,
$File_RHID_DryTestHeader,
$File_RHID_Hardware     ,
$File_RHID_MainFunction ,
$File_RHID_Report       ,
$File_RHID_ShipPrep     ,
$File_RHID_Str          ,
$File_RHID_WetTest      ,
$File_RHID_XmlWriter    ,
$File_RunSummaryCSV     ,
$File_SetScreenResolutionEx,
$File_setvolume         ,
$File_SetWindowStyle    ,
$File_TC_VerificationTXT,
$File_VerboseMode       ,
$File_XML_and_Config -Algorithm SHA256).hash

(Get-Content $PSScriptRoot\..\Config\Script_Metadata.txt)[-1]

if ((Test-Path -PathType Leaf -Path "$PSScriptRoot\..\Config\Script_Metadata.TXT") -ne "True") {
$ScriptMetadata | Out-File "$PSScriptRoot\..\Config\Script_Metadata.TXT"}

# Get-FileHash is bugged in Powershell 5.1, only hashing and compare hastable in Powershell 7
# export git info " git log -1 --format=%cd --date=local" "git rev-parse --short HEAD"
$ScriptPreCheckCounter = ($ScriptPreCheck | select-string "true").count

if ($ScriptPreCheckCounter -eq 24) {
    "[ Info       ] : $ScriptPreCheckCounter Scripts pre-run check passed"
    start-sleep 1
} elseif ($ScriptPreCheckCounter -lt 24) {
    "[ Error      ] : Scripts count $ScriptPreCheckCounter checksum failed, Script execution may not produce correct results"
}
"[ ScriptInfo ] : Git Commit ID & Date : " +$GitCommitHash + " : " + $GitCommitDate