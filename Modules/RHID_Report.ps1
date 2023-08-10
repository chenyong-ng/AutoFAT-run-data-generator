
$US_serverdir       = "$US_path-$IndexedSerialNumber"
$serverdir          = "$path-$IndexedSerialNumber"
$LocalFolder        = "$Inst_rhid_Result"
$storyboard         = Get-ChildItem "$serverdir", "$US_serverdir", "$localFolder" -I storyboard*.txt -R -ErrorAction SilentlyContinue
if ($storyboard.count -eq 0) {
    Write-Host "$Info : Storyboard logfile does not exist, Select the correct Serial Number to proceed" -ForegroundColor red
    break
} else {
    "$Searching : Storyboard.txt"
    "$Found : " + $storyboard[0] + ", Counter : " + $storyboard.count
}
"$Searching : MachineName"
$MachineName        = (($storyboard | Select-String "MachineName")[0].Line.Split(":").TrimStart())[-1]
"$Found : " + ($storyboard | Select-String "MachineName")[0].line + ", Counter : " + ($storyboard | Select-String "MachineName").count
"$Searching : MachineConfig.xml"
$MachineConfigXML   = Get-ChildItem  "$serverdir", "$US_serverdir", "$Inst_rhid_Folder"  -I MachineConfig.xml -R -ErrorAction SilentlyContinue
"$Found : " + $MachineConfigXML[0] + ", Counter : " + $MachineConfigXML.count
"$Searching : TC_Calibration.xml"
$TC_CalibrationXML  = Get-Childitem  "$serverdir", "$US_serverdir", "$Inst_rhid_Folder"  -I TC_Calibration.xml -R -ErrorAction SilentlyContinue
"$Found : " + $TC_CalibrationXML[0] + ", Counter : " + $TC_CalibrationXML.count
"$Searching : SampleQuality.txt"
$SampleQuality      = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"       -I SampleQuality.txt -R -ErrorAction SilentlyContinue
"$Found : " + $SampleQuality[0] + ", Counter : " + $SampleQuality.count

$BufferPrimeScreenShot = Get-ChildItem  "$serverdir", "$US_serverdir", "$Inst_rhid_Folder"  -I BufferPrime*.png -R -ErrorAction SilentlyContinue
#add option to disable image display
"$Found : " + $BufferPrimeScreenShot[0] + ", Counter : " + $BufferPrimeScreenShot.count

$Nonlinearity_File          = "Non-linearity Calibration $MachineName.PNG"
$Waves_File                 = "Waves $MachineName.PNG"
$Nonlinearity_Leaf_Server   = Test-Path -PathType Leaf -Path "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Nonlinearity_File"
$Waves_Leaf_Server          = Test-Path -PathType Leaf -Path "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Waves_File"
"$Found : $Nonlinearity_Leaf_Server ? " + $Nonlinearity_File + ", Counter : " + $Nonlinearity_File.count
"$Found : $Waves_Leaf_Server ? " + $Waves_File + ", Counter : " + $Waves_File.count

IF ($NoIMGPopUp -ne "True") {       
    If ($Waves_Leaf_Server -eq "True" ){
        Start-Process -WindowStyle Minimized "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Nonlinearity_File"
    }
    If ($Nonlinearity_Leaf_Server -eq "True" ) {
        Start-Process -WindowStyle Minimized "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Waves_File"
    }
    If ($BufferPrimeScreenShot.count -gt 0 ) {
        Start-Process -WindowStyle Minimized $BufferPrimeScreenShot[-1]
    }
}
"$Searching : DannoGUIState.xml"
$DannoGUIStateXML   = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I DannoGUIState.xml -R -ErrorAction SilentlyContinue
"$Found : " + $DannoGUIStateXML[0] + ", Counter : " + $DannoGUIStateXML.count
"$Searching : execution.log"
$ExecutionLOG       = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I execution.log -R -ErrorAction SilentlyContinue
"$Found : " + $ExecutionLOG[0] + ", Counter : " + $ExecutionLOG.count
"$Searching : BEC Insertion Storyboard.txt" 
$CoverOn_BEC_Reinsert = Get-ChildItem "$serverdir\*BEC Insertion BEC_*" , "$US_serverdir\*BEC Insertion BEC_*" -I storyboard*.* -R -ErrorAction SilentlyContinue | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'ABORTED' }
"$Found : " + $CoverOn_BEC_Reinsert[0] + ", Counter : " + $CoverOn_BEC_Reinsert.count
"$Searching : GM_Analysis_PeakTable.txt" 
$GM_Analysis_PeakTable = Get-ChildItem  "$serverdir", "$US_serverdir", "$localFolder"  -I GM_Analysis_PeakTable.txt -R -ErrorAction SilentlyContinue
"$Found : " + $GM_Analysis_PeakTable[0] + ", Counter : " + $GM_Analysis_PeakTable.count

"$Loading : more textual filtering commands "
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

$LogTimerStart
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
$LogTimerEnd
}

IF ($QuiteMode -ne "True") {
    RHID_ReportGen
}

IF ($NoReport -ne "True") {
    RHID_ReportGen *> $TempLogFile
$TestResultLOG_File
Copy-Item -Force $TempLogFile -Destination $TestResultLOG_File
Start-Process -WindowStyle Minimized -FilePath [String]$ScriptConfig.Apps.Notepad "$TestResultLOG_File"
}

IF ($NoXML -ne "True") {
$TestResultXML_File
Copy-Item -Force $TempXMLFile -Destination $TestResultXML_File
Start-Process -WindowStyle Minimized -FilePath [String]$ScriptConfig.Apps.Notepad "$TestResultXML_File"
}
"$info : Clearing up temp files " + $TempLogFile.name +' '+ $TempXMLFile.name
"$info : Script ended with exit code of $LASTEXITCODE"
Remove-item $TempLogFile, $TempXMLFile