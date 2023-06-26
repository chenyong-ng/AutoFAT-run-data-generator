
$TestPath_CheckSum          = Test-Path -Path $PSScriptRoot\CheckSum.ps1 -PathType Leaf
$TestPath_AdapterTypes      = Test-Path -Path $PSScriptRoot\AdapterTypes.ps1 -PathType Leaf
$TestPath_Branch            = Test-Path -Path $PSScriptRoot\Branch.ps1 -PathType Leaf
$TestPath_Info_Screens      = Test-Path -Path $PSScriptRoot\Info_Screens.ps1 -PathType Leaf
$TestPath_Report_Automation = Test-Path -Path $PSScriptRoot\Report_Automation.ps1 -PathType Leaf
$TestPath_RHID_CoverOnTest  = Test-Path -Path $PSScriptRoot\RHID_CoverOnTest.ps1 -PathType Leaf
$TestPath_RHID_Descriptions = Test-Path -Path $PSScriptRoot\RHID_Descriptions.ps1 -PathType Leaf
$TestPath_RHID_DryTest      = Test-Path -Path $PSScriptRoot\RHID_DryTest.ps1 -PathType Leaf
$TestPath_RHID_DryTestHeader= Test-Path -Path $PSScriptRoot\RHID_DryTestHeader.ps1 -PathType Leaf
$TestPath_RHID_Hardware     = Test-Path -Path $PSScriptRoot\RHID_Hardware.ps1 -PathType Leaf
$TestPath_RHID_MainFunction = Test-Path -Path $PSScriptRoot\RHID_MainFunction.ps1 -PathType Leaf
$TestPath_RHID_Report       = Test-Path -Path $PSScriptRoot\RHID_Report.ps1 -PathType Leaf
$TestPath_RHID_ShipPrep     = Test-Path -Path $PSScriptRoot\RHID_ShipPrep.ps1 -PathType Leaf
$TestPath_RHID_Str          = Test-Path -Path $PSScriptRoot\RHID_Str.ps1 -PathType Leaf
$TestPath_RHID_WetTest      = Test-Path -Path $PSScriptRoot\RHID_WetTest.ps1 -PathType Leaf
$TestPath_RHID_XmlWriter    = Test-Path -Path $PSScriptRoot\RHID_XmlWriter.ps1 -PathType Leaf
$TestPath_RunSummaryCSV     = Test-Path -Path $PSScriptRoot\RunSummaryCSV.ps1 -PathType Leaf
$TestPath_SetScreenResolutionEx = Test-Path -Path $PSScriptRoot\Set-ScreenResolutionEx.ps1 -PathType Leaf
$TestPath_setvolume         = Test-Path -Path $PSScriptRoot\set-volume.ps1 -PathType Leaf
$TestPath_SetWindowStyle    = Test-Path -Path $PSScriptRoot\Set-WindowStyle.ps1 -PathType Leaf
$TestPath_TC_VerificationTXT = Test-Path -Path $PSScriptRoot\TC_VerificationTXT.ps1 -PathType Leaf
$TestPath_VerboseMode       = Test-Path -Path $PSScriptRoot\VerboseMode.ps1 -PathType Leaf
$TestPath_XML_and_Config    = Test-Path -Path $PSScriptRoot\XML_and_Config.ps1 -PathType Leaf

$ScriptPreCheck =
$TestPath_CheckSum,
$TestPath_AdapterTypes,
$TestPath_Branch,
$TestPath_Info_Screens,
$TestPath_Report_Automation,
$TestPath_RHID_CoverOnTest,
$TestPath_RHID_Descriptions,
$TestPath_RHID_DryTest,
$TestPath_RHID_DryTestHeader,
$TestPath_RHID_Hardware,
$TestPath_RHID_MainFunction,
$TestPath_RHID_Report,
$TestPath_RHID_ShipPrep,
$TestPath_RHID_Str,
$TestPath_RHID_WetTest,
$TestPath_RHID_XmlWriter,
$TestPath_RunSummaryCSV,
$TestPath_SetScreenResolutionEx,
$TestPath_setvolume,
$TestPath_SetWindowStyle,
$TestPath_TC_VerificationTXT,
$TestPath_VerboseMode,
$TestPath_XML_and_Config

$ScriptPreCheckCounter = ($ScriptPreCheck | select-string "true").count

if ($ScriptPreCheckCounter -eq 23) {
    "[ Info       ] : $ScriptPreCheckCounter Scripts pre-run check passed"
    start-sleep 1
} elseif ($ScriptPreCheckCounter -lt 23) {
    "[ Error      ] : Scripts count $ScriptPreCheckCounter checksum failed, Script execution may not produce correct results"
}