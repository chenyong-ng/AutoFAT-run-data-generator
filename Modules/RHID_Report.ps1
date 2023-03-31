
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

. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\TC_VerificationTXT.ps1
. $PSScriptRoot\RHID_Hardware.ps1
. $PSScriptRoot\RHID_DryTest.ps1
. $PSScriptRoot\RHID_WetTest.ps1
. $PSScriptRoot\RHID_CoverOnTest.ps1
. $PSScriptRoot\RHID_ShipPrep.ps1

clear-host
Write-Host "[ RapidHIT ID] : Running query on Instrument $MachineName on $Drive drive run data for consolidated test result..." -ForegroundColor Cyan

#Instrument hardwar check
RHID_Optics
RHID_TC
RHID_TC_Verification
RHID_MachineConfig_check
RHID_Firmware_Check
RHID_HIDAutolite_Check
$Section_Separator 
#Beginning of CoverOff test
RHID_Heater_Test
RHID_GelCooler
RHID_Ambient_Sensor
RHID_SCI_Tests
$Section_Separator 
RHID_MezzFuctionTest
RHID_SyringePump
RHID_MezzBEC_Test
$Section_Separator 
RHID_WetTest
RHID_CoverOff_FullRun
$Section_Separator 

#CoverOn test
RHID_CoverOn_FullRun
$Section_Separator 

#Check for PDFs exports and GM_Analysis.sgf
RHID_PDF_Check
$Section_Separator 
RHID_GM_Analysis_Check
$Section_Separator 
RHID_TempHumi_Check
$Section_Separator 
RHID_ShipPrep_Check