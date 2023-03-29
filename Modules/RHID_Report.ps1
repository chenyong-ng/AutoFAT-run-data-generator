
$storyboard = Get-ChildItem "$serverdir" -I storyboard*.* -R
if ([bool]$storyboard -ne "True") {
    Write-Error -Message "Storyboard logfile does not exist (yet)" -ErrorAction Stop}
"Looking for MachineName"
$MachineName = ($storyboard | Select-String "MachineName" | Select-Object -First 1).Line.Split(":").TrimStart() | Select-Object -Last 1

"Looking for MachineConfig.xml"
$MachineConfigXML = Get-ChildItem "$serverdir" -I MachineConfig.xml -R
"Looking for TC_Calibration.xml"
$TC_CalibrationXML = Get-Childitem "$serverdir" -I TC_Calibration.xml -R
"Looking for SampleQuality.txt"
$SampleQuality = Get-ChildItem "$serverdir" -I SampleQuality.txt -R
"Looking for DannoGUIState.xml"
$DannoGUIStateXML = Get-ChildItem "$serverdir" -I DannoGUIState.xml -R
"Looking for execution.log"
$ExecutionLOG = Get-ChildItem "$serverdir" -I execution.log -R
"Looking for BEC Insertin Storyboard.txt" 
$CoverOn_BEC_Reinsert = Get-ChildItem "$serverdir\*BEC Insertion BEC_*" -I storyboard*.* -R
"Looking for GM_Analysis_PeakTable.txt" 
$GM_Analysis_PeakTable = Get-ChildItem "$serverdir" -I GM_Analysis_PeakTable.txt -R
"Loading more textual filtering commandss "

"Loading RHID_Str.ps1.. ,
 RHID_Str_Filters.ps1..,
 RHID_Report.ps1..,
 RunSummaryCSV.ps1.."
clear-host
Write-Host "[ RapidHIT ID] : Running query on Instrument $MachineName on $Drive drive run data for consolidated test result..." -ForegroundColor Cyan

. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\RHID_Str_Filters.ps1
. $PSScriptRoot\RHID_Hardware.ps1
. $PSScriptRoot\RHID_DryTest.ps1
. $PSScriptRoot\RHID_WetTest.ps1
. $PSScriptRoot\RHID_CoverOnTest.ps1
. $PSScriptRoot\RHID_ShipPrep.ps1

$Section_Separator

$Section_Separator

$Section_Separator
