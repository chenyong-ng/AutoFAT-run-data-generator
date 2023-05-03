$US_serverdir = "$US_path-$SerialNumber"
$serverdir = "$path-$SerialNumber"
$LocalFolder = "$result"
$storyboard = Get-ChildItem "$serverdir", "$US_serverdir", "$localFolder" -I storyboard*.* -R -ErrorAction SilentlyContinue
if ([bool]$storyboard -ne "True") {
    Write-Error -Message "Storyboard logfile does not exist (yet)" -ErrorAction Stop}
"[Looking] : for MachineName"
$MachineName = ($storyboard | Select-String "MachineName" | Select-Object -First 1).Line.Split(":").TrimStart() | Select-Object -Last 1
"[Found  ] : $MachineName"

"[Looking] : for MachineConfig.xml"
$MachineConfigXML = Get-ChildItem  "$serverdir", "$US_serverdir", "$rhid"  -I MachineConfig.xml -R -ErrorAction SilentlyContinue
"[Found  ] : $MachineConfigXML"
"[Looking] : for TC_Calibration.xml"
$TC_CalibrationXML = Get-Childitem  "$serverdir", "$US_serverdir", "$rhid"  -I TC_Calibration.xml -R -ErrorAction SilentlyContinue
"[Found  ] : $TC_CalibrationXML"
"[Looking] : for SampleQuality.txt"
$SampleQuality = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I SampleQuality.txt -R -ErrorAction SilentlyContinue
"[Found  ] :"; $SampleQuality.directory.name[0-10]
"[Looking] : for DannoGUIState.xml"
$DannoGUIStateXML = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I DannoGUIState.xml -R -ErrorAction SilentlyContinue
"[Found  ] :"; $DannoGUIStateXML.directory.name[0-10]
"[Looking] : for execution.log"
$ExecutionLOG = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I execution.log -R -ErrorAction SilentlyContinue
"[Found  ] :"; $ExecutionLOG.directory.name[0-10]
"[Looking] : for BEC Insertin Storyboard.txt" 
$CoverOn_BEC_Reinsert = Get-ChildItem "$serverdir\*BEC Insertion BEC_*" , "$US_serverdir\*BEC Insertion BEC_*" -I storyboard*.* -R -ErrorAction SilentlyContinue
"[Found  ] : $CoverOn_BEC_Reinsert"
"[Looking] : for GM_Analysis_PeakTable.txt" 
$GM_Analysis_PeakTable = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I GM_Analysis_PeakTable.txt -R -ErrorAction SilentlyContinue
"[Found  ] :"; $GM_Analysis_PeakTable.directory.name[0-10]
"[Loading] : more textual filtering commandss "

. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\TC_VerificationTXT.ps1
. $PSScriptRoot\RHID_Hardware.ps1
. $PSScriptRoot\RHID_DryTest.ps1
. $PSScriptRoot\RHID_WetTest.ps1
. $PSScriptRoot\RHID_CoverOnTest.ps1
. $PSScriptRoot\RHID_ShipPrep.ps1

IF ($VerboseMode -eq "False") {clear-host}
Write-Host "[ RapidHIT ID] : Running query on Instrument $MachineName on $Drive drive run data for consolidated test result..." -ForegroundColor Cyan

#Instrument hardwar check
if ($SerialRegMatch -eq "True") {
RHID_USB_Devices
RHID_Patch
}
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