
$Storyboard         = Get-ChildItem "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Result" -I storyboard*.txt -R -ErrorAction SilentlyContinue | Sort-Object LastWriteTime
if ($Storyboard.count -eq 0) {
    Write-Host "$Info : Storyboard logfile does not exist, Select the correct Serial Number to proceed" -ForegroundColor red
    break
} Else {
    "$Searching : Storyboard*.txt"
    "$Found : " + $Storyboard.count + " , " + $Storyboard[0]
}

"$Searching : MachineConfig.xml"
$MachineConfigXML = Get-ChildItem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Folder" -I MachineConfig.xml -R -ErrorAction SilentlyContinue
"$Found : " + $MachineConfigXML.count + " , " + $(if ($MachineConfigXML.count -gt 0) { $MachineConfigXML[0] ; $MachineNameXML = ([XML](Get-Content $MachineConfigXML -Encoding UTF8)).InstrumentSettings })

#$MachineNameXML = ([XML](Get-Content $MachineConfigXML -Encoding UTF8)).InstrumentSettings
$MachineNameXML_SN = [String]$MachineNameXML.MachineName
"[MachineNameXML_SN] : " + $MachineNameXML_SN

"$Searching : MachineName"
#get fom machineconfigXML if it exists
$MachineName        = (($Storyboard | Select-String "MachineName")[0].Line.Split(":").TrimStart())[-1]
"$Found : " + ($Storyboard | Select-String "MachineName").count + " , " + ($Storyboard | Select-String "MachineName")[0].line
#$HostName and SerialRegMatch? : $SerialRegMatch " + $(if ($MachineName -eq $HostName) { "Yes" } else { "No" } )


"$Searching : TC_Calibration.xml"
$TC_CalibrationXML  = Get-Childitem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Folder" -I TC_Calibration.xml -R -ErrorAction SilentlyContinue
#"$Found : " + $TC_CalibrationXML[0] + ", Number of Instances Found : " + $TC_CalibrationXML.count
"$Found : " + $TC_CalibrationXML.count + " , " + $(if ($TC_CalibrationXML.count -gt 0) { $TC_CalibrationXML[0] })
"$Searching : SampleQuality.txt"
$SampleQuality      = Get-ChildItem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Result" -I SampleQuality.txt -R -ErrorAction SilentlyContinue
#"$Found : " + $SampleQuality[0] + ", Number of Instances Found : " + $SampleQuality.count
"$Found : " + $SampleQuality.count + " , " + $(if ($SampleQuality.count -gt 0) { $SampleQuality[0] })

"$Searching : BufferPrime.png"
$BufferPrimeScreenShot = Get-ChildItem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Folder"  -I BufferPrime*.png -R -ErrorAction SilentlyContinue

#"$Found : " + $BufferPrimeScreenShot[0] + ", Number of Instances Found : " + $BufferPrimeScreenShot.count
"$Found : " + $BufferPrimeScreenShot.count + " , " + $(if ($BufferPrimeScreenShot.count -gt 0) { $BufferPrimeScreenShot[0] })

$Nonlinearity_File          = "Non-linearity Calibration $MachineName.PNG"
$Waves_File                 = "Waves $MachineName.PNG"
$Nonlinearity_FullPath      = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Nonlinearity_File"
$Waves_FullPath             = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Waves_File"
$Nonlinearity_Leaf_Server   = Test-Path -PathType Leaf -Path $Nonlinearity_FullPath
$Waves_Leaf_Server          = Test-Path -PathType Leaf -Path $Waves_FullPath
$Nonlinearity_Server   = Get-ChildItem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Folder" -I $Nonlinearity_File  -R -ErrorAction SilentlyContinue
$Waves_Server          = Get-ChildItem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Folder" -I $Waves_File -R -ErrorAction SilentlyContinue

"$Searching : $Nonlinearity_File"
#"$Found : $Nonlinearity_Leaf_Server ? " + $Nonlinearity_File + ", Number of Instances Found : " + $Nonlinearity_Server.count
"$Found : " + $Nonlinearity_Server.count + " , " + $(if ($Nonlinearity_Server.count -gt 0) { $Nonlinearity_Server[0] })
"$Searching : $Waves_File"
#"$Found : $Waves_Leaf_Server ? " + $Waves_File + ", Number of Instances Found : " + $Waves_Server.count
"$Found : " + $Waves_Server.count + " , " + $(if ($Waves_Server.count -gt 0) { $Waves_Server[0] })

# put them into html
# look for internal and server folder as well
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
$DannoGUIStateXML   = Get-ChildItem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Result"  -I DannoGUIState.xml -R -ErrorAction SilentlyContinue
#"$Found : " + $DannoGUIStateXML[0] + ", Number of Instances Found : " + $DannoGUIStateXML.count
"$Found : " + $DannoGUIStateXML.count + " , " + $(if ($DannoGUIStateXML.count -gt 0) { $DannoGUIStateXML[0] })
"$Searching : execution.log"
$ExecutionLOG       = Get-ChildItem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Result"  -I execution.log -R -ErrorAction SilentlyContinue
#"$Found : " + $ExecutionLOG[0] + ", Number of Instances Found : " + $ExecutionLOG.count
"$Found : " + $ExecutionLOG.count + " , " + $(if ($ExecutionLOG.count -gt 0) { $ExecutionLOG[0] })
"$Searching : BEC Insertion Storyboard.txt" 
$CoverOn_BEC_Reinsert = Get-ChildItem "$Path-$IndexedSerialNumber\*BEC Insertion BEC_*" , "$US_Path-$IndexedSerialNumber\*BEC Insertion BEC_*" -I storyboard*.* -R -ErrorAction SilentlyContinue | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'ABORTED' }
#"$Found : " + $CoverOn_BEC_Reinsert[0] + ", Number of Instances Found : " + $CoverOn_BEC_Reinsert.count
"$Found : " + $CoverOn_BEC_Reinsert.count + " , " + $(if ($CoverOn_BEC_Reinsert.count -gt 0) { $CoverOn_BEC_Reinsert[0] })
"$Searching : GM_Analysis_PeakTable.txt" 
$GM_Analysis_PeakTable = Get-ChildItem  "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Result"  -I GM_Analysis_PeakTable.txt -R -ErrorAction SilentlyContinue
#"$Found : " + $GM_Analysis_PeakTable[0] + ", Number of Instances Found : " + $GM_Analysis_PeakTable.count
"$Found : " + $GM_Analysis_PeakTable.count + " , " + $(if ($GM_Analysis_PeakTable.count -gt 0) { $GM_Analysis_PeakTable[0] })
# look out for SRI4

"$Loading : more textual filtering commands "
    . $PSScriptRoot\RHID_MainFunction.ps1
    . $PSScriptRoot\TC_VerificationTXT.ps1
    . $PSScriptRoot\RHID_Hardware.ps1
    . $PSScriptRoot\RHID_DryTest.ps1
    . $PSScriptRoot\RHID_WetTest.ps1
    . $PSScriptRoot\RHID_CoverOnTest.ps1
    . $PSScriptRoot\RHID_ShipPrep.ps1
    . $PSScriptRoot\ServerSide_FileCheck.ps1

"$Searching : TC_verification $MachineName.TXT"
$TC_verificationTXT = Get-ChildItem "$Path-$IndexedSerialNumber", "$US_Path-$IndexedSerialNumber", "$Inst_rhid_Result" -I "TC_verification $MachineName.TXT" -R -ErrorAction SilentlyContinue
"$Found : " + $TC_verificationTXT.count + " , " + $(if ($TC_verificationTXT.count -gt 0) { $TC_verificationTXT[0] })

if ($EnableDescriptions -eq "True") {
    . $PSScriptRoot\RHID_Descriptions.ps1
}

IF ($VerboseMode -ne "True") {
    clear-host
    } else {
        "$info : VerboseMode Enabled, Debug output will not be cleared"
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

"$LogTimer : $LogTimerStart"
RHID_Optics
RHID_TC
RHID_TC_Verification
Server-side_Waves_Screenshot_Check
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
"$LogTimer : $LogTimerEnd"
    IF ($NoXML -ne "True") {
        . $PSScriptRoot\RHID_XmlFragments.ps1
        $TestResultXML_FullPath = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$TestResultXML_File"
        Copy-Item -Force $TempXMLFile -Destination $TestResultXML_FullPath
        Start-Process -WindowStyle Minimized $NotepadAPP "$TestResultXML_FullPath"
    }

}

IF ($QuiteMode -ne "True") {
    RHID_ReportGen
}

# add option to open the textfile if detected
IF ($NoReport -ne "True") {
    RHID_ReportGen *> $TempLogFile
    $TestResultLOG_FullPath = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$TestResultLOG_File"
    Copy-Item -Force $TempLogFile -Destination $TestResultLOG_FullPath
    Start-Process -WindowStyle Minimized $NotepadAPP "$TestResultLOG_FullPath"
}


IF ($NoHTML -ne "True") {
    . $PSScriptRoot\RHID_HTML.ps1
    $TestResultHTML_FullPath = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$TestResultHTML_File"
    $html | Out-File -FilePath $TestResultHTML_FullPath -Force
    # Copy-Item -Force $TempXMLFile -Destination $TestResultXML_FullPath
    Start-Process -WindowStyle Minimized "$TestResultHTML_FullPath"
}

"$info : Clearing up temp files " + $TempLogFile.name +' '+ $TempXMLFile.name
"$info : Script ended with exit code of $LASTEXITCODE"
Remove-item $TempLogFile, $TempXMLFile