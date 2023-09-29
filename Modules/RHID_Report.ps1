
$Storyboard_Folder      =   "$Path-$IndexedSerialNumber\Internal\RapidHIT ID\",
                            "$US_Path-$IndexedSerialNumber\Internal\RapidHIT ID\",
                            "$Inst_rhid_Folder"
$MachineConfig_Folder   =   "$Path-$IndexedSerialNumber\Internal\RapidHIT ID\MachineConfig.xml",
                            "$US_Path-$IndexedSerialNumber\Internal\RapidHIT ID\MachineConfig.xml",
                            "$Inst_rhid_Folder\MachineConfig.xml"
$TC_Calibration_Folder  =   "$Path-$IndexedSerialNumber\Internal\RapidHIT ID\TC_Calibration.xml",
                            "$US_Path-$IndexedSerialNumber\Internal\RapidHIT ID\TC_Calibration.xml", 
                            "$Inst_rhid_Folder\TC_Calibration.xml"
$CvrON_BEC_Inserr_Folder =  "$Path-$IndexedSerialNumber\*BEC Insertion BEC_*",
                            "$US_Path-$IndexedSerialNumber\*BEC Insertion BEC_*"
$CvOff_BEC_Insert_Folder =  "$Path-$IndexedSerialNumber\*BEC Insertion",
                            "$US_Path-$IndexedSerialNumber\*BEC Insertion"
# for execution.log and GM_Analysis_PeakTable.txt
$FullRun_Folder         =   "$Path-$IndexedSerialNumber\*GFE-300uL*",
                            "$Path-$IndexedSerialNumber\*GFE-BV*",
                            "$Path-$IndexedSerialNumber\*GFE_007*",
                            "$Path-$IndexedSerialNumber\*NMG_007*",
                            "$Path-$IndexedSerialNumber\*BLANK*",
                            "$US_Path-$IndexedSerialNumber\*GFE-300uL*",
                            "$US_Path-$IndexedSerialNumber\*GFE-BV*",
                            "$US_Path-$IndexedSerialNumber\*GFE_007",
                            "$US_Path-$IndexedSerialNumber\*NGM_007",
                            "$US_Path-$IndexedSerialNumber\*BLANK*",
                            "$Inst_rhid_Result"
$Bolus_Folder           =   "$Path-$IndexedSerialNumber\*Bolus Delivery Test*",
                            "$US_Path-$IndexedSerialNumber\*Bolus Delivery Test*"
# $Internal_FolderList = "${Path-$IndexedSerialNumber}\Internal\RapidHIT ID\Results\Data $MachineName"
# $dataColl = @()
# Get-ChildItem -force $Internal_FolderList -ErrorAction SilentlyContinue | Where-Object { $_ -is [io.directoryinfo] } | where-object {$_.Length -gt 100Mb } | Sort-Object LastWriteTime | ForEach-Object {
#     $len = 0
#     Get-ChildItem -recurse -force $_.fullname -ErrorAction SilentlyContinue | ForEach-Object { $len += $_.length }
#     $foldername = $_.fullname
#     $foldersize = '{0:N3}' -f ($len / 1Mb)
#     $dataObject = New-Object PSObject
#     Add-Member -inputObject $dataObject -memberType NoteProperty -name “foldername” -value $foldername
#     Add-Member -inputObject $dataObject -memberType NoteProperty -name “foldersize” -value $foldersize
#     $dataColl += $dataObject
# }
# $dataColl.foldersize
# 
# Function Get-FolderSize {
#     [CmdletBinding()]
#     Param (
#         [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
#         $Path
#     )
#     if ( (Test-Path $Path) -and (Get-Item $Path).PSIsContainer ) {
#         $Measure = Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
#         $Sum = '{0:N2}' -f ($Measure.Sum / 1Gb)
#         [PSCustomObject]@{
#             "Path"      = $Path
#             "Size($Gb)" = $Sum
#         }
#     }
# }
# # Gather folders size. and filter out small folder
# 
# $TotalMemory          = "{0:N0} MB" -f ((get-childitem "U:\RHID-0855\Internal\RapidHIT ID\Results\Data RHID-0855\" -R -Force -ErrorAction SilentlyContinue | Measure-Object Length -sum -ErrorAction SilentlyContinue ).sum / 1Mb)
$fullname = $Storyboard.FullName
$i = $Storyboard.count
$i = 0
foreach ($Storyboard in $fullname) {
    if ( $Storyboard.count -gt 0) {
        $Filesize = Get-Item $fullname[$i] | ForEach-Object { [math]::ceiling($_.length / 1KB) }
        $Filesize
    $i = $i + 1
    }
} 

$Storyboard         = Get-ChildItem $Storyboard_Folder -I storyboard*.txt -R -ErrorAction SilentlyContinue | Sort-Object LastWriteTime
if ($Storyboard.count -eq 0) {
    Write-Host "$Info : Storyboard logfile does not exist, Select the correct Serial Number to proceed" -ForegroundColor red
    break
} Else {
    "$Searching : Storyboard*.txt"
    "$Found : " + $Storyboard.count + " , " + $Storyboard[0]
}

"$Searching : MachineConfig.xml"
$MachineConfigXML = Get-ChildItem $MachineConfig_Folder -ErrorAction SilentlyContinue
"$Found : " + $MachineConfigXML.count + " , " + $(if ($MachineConfigXML.count -gt 0) { $MachineConfigXML[0] ; $MachineNameXML = ([XML](Get-Content $MachineConfigXML -Encoding UTF8)).InstrumentSettings })

#$MachineNameXML = ([XML](Get-Content $MachineConfigXML -Encoding UTF8)).InstrumentSettings
$MachineNameXML_SN = [String]$MachineNameXML.MachineName
"[MachineNameXML_SN] : " + $MachineNameXML_SN

"$Searching : MachineName"
#get fom machineconfigXML if it exists
$MachineName        = ((Get-ChildItem $CvOff_BEC_Insert_Folder  -I storyboard*.txt -R -ErrorAction SilentlyContinue | Select-String "MachineName")[0].Line.Split(":").TrimStart())[-1]
"$Found : " + $MachineName.count + " , " + $MachineName
#$HostName and SerialRegMatch? : $SerialRegMatch " + $(if ($MachineName -eq $HostName) { "Yes" } else { "No" } )

$Internal_Folder        =   "$Path-$IndexedSerialNumber\Internal\RapidHIT ID\Results\Data $MachineName",
                            "$US_Path-$IndexedSerialNumber\Internal\RapidHIT ID\Results\Data $MachineName",
                            "$Inst_rhid_Result\RapidHIT ID\Results\Data $MachineName"

"$Searching : TC_Calibration.xml"
$TC_CalibrationXML = Get-Childitem  $TC_Calibration_Folder -ErrorAction SilentlyContinue
#"$Found : " + $TC_CalibrationXML[0] + ", Number of Instances Found : " + $TC_CalibrationXML.count
"$Found : " + $TC_CalibrationXML.count + " , " + $(if ($TC_CalibrationXML.count -gt 0) { $TC_CalibrationXML[0] })
"$Searching : SampleQuality.txt"
$SampleQuality      = Get-ChildItem $FullRun_Folder -I SampleQuality.txt -R -ErrorAction SilentlyContinue | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' }
#"$Found : " + $SampleQuality[0] + ", Number of Instances Found : " + $SampleQuality.count
"$Found : " + $SampleQuality.count + " , " + $(if ($SampleQuality.count -gt 0) { $SampleQuality[0] })

"$Searching : BufferPrime.png"
$BufferPrimeScreenShot = Get-ChildItem $Internal_Folder -I BufferPrime*.png -R -ErrorAction SilentlyContinue 

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
$DannoGUIStateXML   = Get-ChildItem $Internal_Folder -I DannoGUIState.xml -R -ErrorAction SilentlyContinue
#"$Found : " + $DannoGUIStateXML[0] + ", Number of Instances Found : " + $DannoGUIStateXML.count
"$Found : " + $DannoGUIStateXML.count + " , " + $(if ($DannoGUIStateXML.count -gt 0) { $DannoGUIStateXML[0] })
"$Searching : execution.log"
$ExecutionLOG       = Get-ChildItem  $FullRun_Folder  -I execution.log -R -ErrorAction SilentlyContinue | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' }
#"$Found : " + $ExecutionLOG[0] + ", Number of Instances Found : " + $ExecutionLOG.count
"$Found : " + $ExecutionLOG.count + " , " + $(if ($ExecutionLOG.count -gt 0) { $ExecutionLOG[0] })
"$Searching : BEC Insertion Storyboard.txt" 
$CoverOn_BEC_Reinsert = Get-ChildItem $CvrON_BEC_Inserr_Folder -I storyboard*.* -R -ErrorAction SilentlyContinue | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'ABORTED' }
#"$Found : " + $CoverOn_BEC_Reinsert[0] + ", Number of Instances Found : " + $CoverOn_BEC_Reinsert.count
"$Found : " + $CoverOn_BEC_Reinsert.count + " , " + $(if ($CoverOn_BEC_Reinsert.count -gt 0) { $CoverOn_BEC_Reinsert[0] })
"$Searching : GM_Analysis_PeakTable.txt" 
$GM_Analysis_PeakTable = Get-ChildItem $FullRun_Folder -I GM_Analysis_PeakTable.txt -R -ErrorAction SilentlyContinue | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' }
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

$TC_verification_File   =   "TC_verification $MachineName.TXT"
$TC_verification_Folder =   "$Path-$IndexedSerialNumber\Internal\RapidHIT ID\Results\$TC_verification_File",
                            "$US_Path-$IndexedSerialNumber\Internal\RapidHIT ID\Results\$TC_verification_File", 
                            "$Inst_rhid_Folder\Results\$TC_verification_File"

"$Searching : $TC_verification_File"
$TC_verificationTXT = Get-ChildItem $TC_verification_Folder -ErrorAction SilentlyContinue
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
# IF ($NoReport -ne "True") {
#     RHID_ReportGen *> $TempLogFile
#     $TestResultLOG_FullPath = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$TestResultLOG_File"
#     Copy-Item -Force $TempLogFile -Destination $TestResultLOG_FullPath
#     Start-Process -WindowStyle Minimized $NotepadAPP "$TestResultLOG_FullPath"
# }


IF ($NoHTML -ne "True") {
    . $PSScriptRoot\RHID_HTML.ps1
    $TestResultHTML_FullPath = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$TestResultHTML_File"
    $html | Out-File -FilePath $TestResultHTML_FullPath -Force
    # Copy-Item -Force $TempXMLFile -Destination $TestResultXML_FullPath
    Start-Process -WindowStyle Minimized "$TestResultHTML_FullPath"
}

"$info : Clearing up temp files " + ' '+ $TempXMLFile.name +' '+ $TempTranscriptFile.name
"$info : Script ended with exit code of $LASTEXITCODE"
If ($NoTranscription -ne "True") {
    $Transcript_FullPath = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$MachineName-Transcript.txt"
    Copy-Item -Force $TempTranscriptFile -Destination $Transcript_FullPath
}
Remove-item $TempXMLFile, $TempTranscriptFile -ErrorAction SilentlyContinue