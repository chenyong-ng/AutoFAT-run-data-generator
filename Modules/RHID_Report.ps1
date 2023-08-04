
$US_serverdir = "$US_path-$IndexedSerialNumber"
$serverdir = "$path-$IndexedSerialNumber"
$LocalFolder = "$Inst_rhid_Result"
$storyboard = Get-ChildItem "$serverdir", "$US_serverdir", "$localFolder" -I storyboard*.* -R -ErrorAction SilentlyContinue
if ($storyboard.count -eq 0) {
    Write-Host "$Info : Storyboard logfile does not exist, Select the correct Serial Number to proceed" -ForegroundColor red
    break
}
"$Searching : MachineName"
$MachineName = (($storyboard | Select-String "MachineName" | Select-Object -First 1).Line.Split(":").TrimStart())[-1]
"$Found : $MachineName"

"$Searching : MachineConfig.xml"
$MachineConfigXML = Get-ChildItem  "$serverdir", "$US_serverdir", "$Inst_rhid_Folder"  -I MachineConfig.xml -R -ErrorAction SilentlyContinue
"$Searching : TC_Calibration.xml"
$TC_CalibrationXML = Get-Childitem  "$serverdir", "$US_serverdir", "$Inst_rhid_Folder"  -I TC_Calibration.xml -R -ErrorAction SilentlyContinue
"$Searching : SampleQuality.txt"
$SampleQuality = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I SampleQuality.txt -R -ErrorAction SilentlyContinue
"$Searching : DannoGUIState.xml"
$BufferPrimeScreenShot = Get-ChildItem  "$serverdir", "$US_serverdir", "$Inst_rhid_Folder"  -I BufferPrime*.* -R -ErrorAction SilentlyContinue
"$Searching : BufferPrime Result Screenshot Counter : " + $BufferPrimeScreenShot.count
#add option to disable image display
"$Found : $BufferPrimeScreenShot"
IF ($NoIMGPopUp -ne "True") {
Start-Process $BufferPrimeScreenShot[-1]
}

$DannoGUIStateXML = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I DannoGUIState.xml -R -ErrorAction SilentlyContinue
"$Searching : execution.log"
$ExecutionLOG = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I execution.log -R -ErrorAction SilentlyContinue
"$Searching : BEC Insertion Storyboard.txt" 
$CoverOn_BEC_Reinsert = Get-ChildItem "$serverdir\*BEC Insertion BEC_*" , "$US_serverdir\*BEC Insertion BEC_*" -I storyboard*.* -R -ErrorAction SilentlyContinue
"$Searching : GM_Analysis_PeakTable.txt" 
$GM_Analysis_PeakTable = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I GM_Analysis_PeakTable.txt -R -ErrorAction SilentlyContinue
"$Found  :"; $GM_Analysis_PeakTable.directory.name
"$Loading : more textual filtering commandss "
    . $PSScriptRoot\RHID_MainFunction.ps1
    . $PSScriptRoot\TC_VerificationTXT.ps1
    . $PSScriptRoot\RHID_Hardware.ps1
    . $PSScriptRoot\RHID_DryTest.ps1
    . $PSScriptRoot\RHID_WetTest.ps1
    . $PSScriptRoot\RHID_CoverOnTest.ps1
    . $PSScriptRoot\RHID_ShipPrep.ps1

IF ($VerboseMode -ne "True") {
    clear-host
    } else {
        "$info : VerboseMode Enabled"
    }

Function RHID_ReportGen {
$Section_Separator 
Write-Host "[ RapidHIT ID] : Running query on Instrument $MachineName on $Drive for test result..." -ForegroundColor Cyan
#Instrument hardware check
if ($SerialRegMatch -eq "True") {
    RHID_USBDevices_Check
    ABRHID_Patch
    RHID_MainFunctions
    } else {
    Write-Host "[ RapidHIT ID] : Result generated on $HostName Might not be up to date" -ForegroundColor Yellow
}

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

IF ($QuiteMode -ne "True") {
    RHID_ReportGen
}

IF ($NoReport -ne "True") {
    RHID_ReportGen *> $TempLogFile
$TestResultLOG_File = "$Drive\$MachineName\Internal\RapidHIT ID\Results\TestResult $MachineName[$HostName].LOG"
Copy-Item -Force $TempLogFile -Destination $TestResultLOG_File
notepad $TestResultLOG_File
}

IF ($NoXML -ne "True") {
$TestResultXML_File = "$Drive\$MachineName\Internal\RapidHIT ID\Results\TestResult $MachineName[$HostName].XML"
Copy-Item -Force $TempXMLFile -Destination $TestResultXML_File
notepad $TestResultXML_File
}
"$info : Clearing up temp files " + $TempLogFile.name +' '+ $TempXMLFile.name
"$info : Script ended with exit code of $LASTEXITCODE"
Remove-item $TempLogFile, $TempXMLFile