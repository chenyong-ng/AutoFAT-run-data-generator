
$US_serverdir = "$US_path-$SerialNumber"
$serverdir = "$path-$SerialNumber"
$LocalFolder = "$Inst_rhid_Result"
$storyboard = Get-ChildItem "$serverdir", "$US_serverdir", "$localFolder" -I storyboard*.* -R -ErrorAction SilentlyContinue
if ([bool]$storyboard -ne "True") {
    Write-Error -Message "Storyboard logfile does not exist (yet)" -ErrorAction Stop}
"$Searching : MachineName"
$MachineName = ($storyboard | Select-String "MachineName" | Select-Object -First 1).Line.Split(":").TrimStart() | Select-Object -Last 1
"$Found : $MachineName"

"$Searching : MachineConfig.xml"
$MachineConfigXML = Get-ChildItem  "$serverdir", "$US_serverdir", "$Inst_rhid_Folder"  -I MachineConfig.xml -R -ErrorAction SilentlyContinue
"$Searching : TC_Calibration.xml"
$TC_CalibrationXML = Get-Childitem  "$serverdir", "$US_serverdir", "$Inst_rhid_Folder"  -I TC_Calibration.xml -R -ErrorAction SilentlyContinue
"$Searching : SampleQuality.txt"
$SampleQuality = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I SampleQuality.txt -R -ErrorAction SilentlyContinue
"$Searching : DannoGUIState.xml"
$DannoGUIStateXML = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I DannoGUIState.xml -R -ErrorAction SilentlyContinue
"$Searching : execution.log"
$ExecutionLOG = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I execution.log -R -ErrorAction SilentlyContinue
"$Searching : BEC Insertion Storyboard.txt" 
$CoverOn_BEC_Reinsert = Get-ChildItem "$serverdir\*BEC Insertion BEC_*" , "$US_serverdir\*BEC Insertion BEC_*" -I storyboard*.* -R -ErrorAction SilentlyContinue
"$Searching : GM_Analysis_PeakTable.txt" 
$GM_Analysis_PeakTable = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I GM_Analysis_PeakTable.txt -R -ErrorAction SilentlyContinue
"$Found  :"; $GM_Analysis_PeakTable.directory.name
"$Loading : more textual filtering commandss "

    . $PSScriptRoot\TC_VerificationTXT.ps1
    . $PSScriptRoot\RHID_Hardware.ps1
    . $PSScriptRoot\RHID_DryTest.ps1
    . $PSScriptRoot\RHID_WetTest.ps1
    . $PSScriptRoot\RHID_CoverOnTest.ps1
    . $PSScriptRoot\RHID_ShipPrep.ps1

IF ($VerboseMode -eq "False") {
    clear-host
    } else {
    "$info : VerboseMode Enabled"}

function RHID_ReportGen {
$Section_Separator 
Write-Host "[ RapidHIT ID] : Running query on Instrument $MachineName on $Drive drive run data for consolidated test result..." -ForegroundColor Cyan
#Instrument hardware check
if ($SerialRegMatch -eq "True") {
$MasterCopy = "[MasterCopy]"
. $PSScriptRoot\RHID_MainFunction.ps1
RHID_USBDevices_Check
ABRHID_Patch
RHID_MainFunctions
} else {
Write-Host "[ RapidHIT ID] : Result generated on $HostName Might not be up to date until Instrument folder fully backed up" -ForegroundColor Yellow}
"$LogTimer : Logging started at $(Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms")"  
RHID_Optics
RHID_TC
RHID_TC_Verification
$Section_Separator
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
"$LogTimer : Logging Ended at $(Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms")" 
} 

# add option to generate report later on instruments
RHID_ReportGen

$ReportGen_Option = read-host "$Info : Press anykey to generate a report"
if ($ReportGen_Option -eq '') {
RHID_ReportGen *> $TempFile
$TestResultLOG_File = "$Drive\$MachineName\Internal\RapidHIT ID\Results\TestResult $MachineName$MasterCopy.LOG"
Copy-Item $TempFile -Destination $TestResultLOG_File
get-content $TestResultLOG_File
notepad $TestResultLOG_File
}
<#

RHID_ReportGen *> $TempFile
get-content $TempFile
#>
