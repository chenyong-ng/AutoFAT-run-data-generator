
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

If ([Bool]($RHID_TC_Calibration | Select-String "NaN") -eq "True") {
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Uncalibrated" -ForegroundColor Yellow
    Write-Host "$TC_Cal :      $Warning : Unpopulated TC_Calibration.XML Found" -ForegroundColor RED
} elseif ($RHID_TC_Calibration.count -eq "0") {
    Write-Host "$TC_Cal :               $Warning : TC_Calibration.XML Not Found" -ForegroundColor RED
} else { 
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Calibrated" -ForegroundColor Green }

. $PSScriptRoot\TC_VerificationTXT.ps1

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
if ("$RHID_Mainboard_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mainboard_str : $RHID_Mainboard_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "$PCBA : $Error_msg $RHID_Mainboard_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red }
if ("$RHID_Mezzbaord_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mezzbaord_str : $RHID_Mezzbaord_FW_Ver" -ForegroundColor Green }
else {   
    Write-Host "$PCBA : $Error_msg $RHID_Mezzbaord_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red } 

IF ([Bool]$RHID_ExecutionLOG -eq "True") {
    $RHID_GM_Analysis_PeakTable_Filter = $RHID_GM_Analysis_PeakTable.line
    $RHID_ExecutionLOG_Filter = $RHID_ExecutionLOG.Line.Split("-").TrimStart() | Select-Object -Last 1
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : $RHID_ExecutionLOG_Filter"
    Write-Host "$HIDAutolite : $HIDAutolite_Execution_Str $RHID_GM_Analysis_PeakTable_Filter "
} Else {
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : Undetected or Expired" -ForegroundColor Red }
