
"Loading Q-mini textual filtering commands"

$RHID_QMini_SN          = ($storyboard | Select-String "Q-mini serial number" | Select-object -last 1)
$RHID_QMini_Coeff       = ($storyboard | Select-String "Coefficients" | Select-object -last 1)
$RHID_QMini_Infl        = ($storyboard | Select-String "Inflection Point" | Select-object -last 1)
<#
IF ($VerboseMode -eq "True") { $RHID_QMini_SN , $RHID_QMini_Coeff, $RHID_QMini_Infl }
IF ($HistoryMode -eq "True") { $storyboard | Select-String "Q-mini serial number" , $RHID_QMini_Coeff, $RHID_QMini_Infl }
#>

"Loading Main board and Mezz PCB textual filtering commands"
$RHID_Mainboard_FW_Ver  = ($storyboard | Select-String "Main board firmware version" | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_Mezzbaord_FW_Ver  = ($storyboard | Select-String "Mezz board firmware version" | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_ExecutionLOG      = $ExecutionLOG | Select-String 'Your trial has | License is Valid' | Select-object -last 1
# $RHID_ExecutionLOG_Valid= $ExecutionLOG | Select-String "License is Valid" | Select-object -last 1
$RHID_GM_Analysis_PeakTable = $GM_Analysis_PeakTable | Select-String "Date/Time:" | Select-object -last 1
#If ($VerboseMode -eq "True") { $RHID_Mainboard_FW_Ver , $RHID_Mezzbaord_FW_Ver , $RHID_ExecutionLOG , $RHID_GM_Analysis_PeakTable }

"Looking for TC_CalibrationXML"
$RHID_TC_Calibration    = $TC_CalibrationXML | Select-Xml -XPath "//Offsets" | ForEach-Object { $_.node.InnerXML }
"Looping through MachineConfigXML "
$RHID_MachineConfig_SN     = $MachineConfigXML  | Select-Xml -XPath "//MachineName" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HWVer = $MachineConfigXML  | Select-Xml -XPath "//HWVersion" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HWID    = $MachineConfigXML  | Select-Xml -XPath "//MachineConfiguration" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_ServerPath = $MachineConfigXML  | Select-Xml -XPath "//DataServerUploadPath" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Syringe = $MachineConfigXML  | Select-Xml -XPath "//SyringePumpResetCalibration_ms | //SyringePumpStallCurrent" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Blue   = $MachineConfigXML  | Select-Xml -XPath "//Signature" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_SCI    = $MachineConfigXML  | Select-Xml -XPath "//FluidicHomeOffset_mm | //PreMixHomeOffset_mm | //DiluentHomeOffset_mm"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_BEC    = $MachineConfigXML  | Select-Xml -XPath "//IsBECInsertion | //LastGelPurgeOK | //RunsSinceLastGelFill" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_PrimeWater  = $MachineConfigXML  | Select-Xml -XPath "//Water"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_PrimeLysisBuffer = $MachineConfigXML  | Select-Xml -XPath "//LysisBuffer" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Laser  = $MachineConfigXML  | Select-Xml -XPath "//LaserHours" | ForEach-Object { $_.node.InnerXML }

function RHID_Optics {
IF ([Bool]$RHID_QMini_SN -eq "True") {
    $RHID_QMini_SN_Filter = $RHID_QMini_SN.line.split(":").TrimStart() | Select-object -last 1
    Write-Host "$Optics : $RHID_QMini_str : $RHID_QMini_SN_Filter" -ForegroundColor Green}
    Else { Write-Host "$Optics : $RHID_QMini_str : Not Available" -ForegroundColor Yellow}

IF ([Bool]$RHID_QMini_Coeff -eq "True") {
    $RHID_QMini_Coeff_Filter = $RHID_QMini_Coeff.line.split(":").TrimStart() | Select-object -last 1
    Write-Host "$Optics : $RHID_Coeff_Str : $RHID_QMini_Coeff_Filter" -ForegroundColor Green}
    Else{ Write-Host "$Optics : $RHID_Coeff_Str : Not Available" -ForegroundColor Yellow}

IF ([Bool]$RHID_QMini_Infl -eq "True") {
    $RHID_QMini_Infl_Filter = $RHID_QMini_Infl.line.split(":").TrimStart() | Select-object -last 1
    Write-Host "$Optics : $RHID_Infl_Str : $RHID_QMini_Infl_Filter" -ForegroundColor Green }
    Else{ Write-Host "$Optics : $RHID_Infl_Str : Not Available" -ForegroundColor Yellow}
}

function RHID_TC {
If ([Bool]($RHID_TC_Calibration | Select-String "NaN") -eq "True") {
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Uncalibrated" -ForegroundColor Yellow
    Write-Host "$TC_Cal :      $Warning : Unpopulated TC_Calibration.XML Found" -ForegroundColor RED
} elseif ($RHID_TC_Calibration.count -eq "0") {
    Write-Host "$TC_Cal :               $Warning : TC_Calibration.XML Not Found" -ForegroundColor RED
} else { 
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Calibrated" -ForegroundColor Green }
}

function RHID_MachineConfig_check {
if ($RHID_MachineConfig_SN.count -eq "0") {
    Write-Host "$MachineConf : $Warning : MachineConfig.XML Not Found" -ForegroundColor RED
}
Write-Host "$MachineConf : $Instrument_Serial : $RHID_MachineConfig_SN" -ForegroundColor Green
Write-Host "$MachineConf : $Hardware_Version : $RHID_MachineConfig_HWVer" -ForegroundColor Green
Write-Host "$MachineConf : $SCI_Configuration : $RHID_MachineConfig_HWID" -ForegroundColor Green
Write-Host "$MachineConf : $Data_Upload_Path : $RHID_MachineConfig_ServerPath" -ForegroundColor Green
Write-Host "$MachineConf : $Syringe_Pump_Calibration : $RHID_MachineConfig_Syringe" -ForegroundColor Green
Write-Host "$MachineConf : $PrimeWater_Status : $RHID_MachineConfig_PrimeWater" -ForegroundColor Green
Write-Host "$MachineConf : $PrimeLysisBuffer : $RHID_MachineConfig_PrimeLysisBuffer" -ForegroundColor Green

If ([Bool]$RHID_MachineConfig_Blue -eq "True") {
    Write-Host "$Raman_Bkg : $Blue_Background_Str : Stashed" -ForegroundColor Green
} else {
    Write-Host "$Raman_Bkg : $Blue_Background_Str : N/A" -ForegroundColor Yellow }

If ([Bool]$RHID_MachineConfig_SCI -eq "True") {
    Write-Host "$SCI_Cal : $SCI_Calibration : $RHID_MachineConfig_SCI mm" -ForegroundColor Green }
    Else {Write-Host $SCI_Cal : $SCI_Calibration : Uncalibrated -ForegroundColor Red}

If ([Bool]$RHID_MachineConfig_BEC -eq "True") {
Write-Host "$BEC_Status : $Bec_Status_Str : $RHID_MachineConfig_BEC" -ForegroundColor Green }

If ([Bool]$RHID_MachineConfig_Prime -eq "True") {
Write-Host "$Prime : $Prime_Status : $RHID_MachineConfig_Prime" -ForegroundColor Green }

Write-Host "$Laser : $Laser_Hour : $RHID_MachineConfig_Laser" -ForegroundColor Green
}

function RHID_Firmware_Check {
if ("$RHID_Mainboard_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mainboard_str : $RHID_Mainboard_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "$PCBA : $Error_msg $RHID_Mainboard_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red }
if ("$RHID_Mezzbaord_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mezzbaord_str : $RHID_Mezzbaord_FW_Ver" -ForegroundColor Green }
else {   
    Write-Host "$PCBA : $Error_msg $RHID_Mezzbaord_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red } 
}

function RHID_HIDAutolite_Check {
IF ([Bool]$RHID_ExecutionLOG -eq "True") {
    $RHID_GM_Analysis_PeakTable_Filter = $RHID_GM_Analysis_PeakTable.line
    $RHID_ExecutionLOG_Filter = $RHID_ExecutionLOG.Line.Split("-").TrimStart() | Select-Object -Last 1
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : $RHID_ExecutionLOG_Filter"
    Write-Host "$HIDAutolite : $HIDAutolite_Execution_Str $RHID_GM_Analysis_PeakTable_Filter "
} Else {
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : Undetected or Expired" -ForegroundColor Red }
}
