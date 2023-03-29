
$RHID_Lysis_Heater_FAT = $storyboard | Select-String "Lysis Heater FAT"
$RHID_Lysis_Heater_FAT_PASS = ($RHID_Lysis_Heater_FAT | select-string "pass" )
$RHID_Lysis_Heater_FAT_FAIL = ($RHID_Lysis_Heater_FAT | select-string "fail" )
if ($RHID_Lysis_Heater_FAT.count -eq "0") {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_NA" -ForegroundColor Yellow 
}
elseif ([bool]($RHID_Lysis_Heater_FAT_PASS.Line.split(":").TrimStart()[-1] -eq "PASS")) {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Passed" -ForegroundColor Green
    If ($DebugMode -eq "True") {
        Write-Host "Lysis Heater Pass Count" $RHID_Lysis_Heater_FAT_PASS.count
            ($RHID_Lysis_Heater_FAT | select-string "pass" )
    }
}
elseif ([bool]($RHID_Lysis_Heater_FAT_FAIL.Line.split(":").TrimStart()[-1] -eq "fail")) {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Failed" -ForegroundColor Red
    If (DebugMode = "True") { $RHID_Lysis_Heater_FAT | select-string "fail" }
}


if (($RHID_DN_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_DN_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_Failed"  -ForegroundColor Red    
}

if (($RHID_PCR_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_PCR_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_Passed" -ForegroundColor Green  
}
else {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Optics_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Optics_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_Failed" -ForegroundColor Red    
}

IF ($HistoryMode -eq "True") { $RHID_Lysis_Heater_FAT , $RHID_DN_Heater_FAT, $RHID_PCR_Heater_FAT , $RHID_Optics_Heater_FAT }

$Section_Separator

if (($RHID_Gel_Cooler_FAT).count -eq "") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Gel_Cooler_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_Failed" -ForegroundColor Red    
}
if (($RHID_Ambient_FAT).count -eq "") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Ambient_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_Failed" -ForegroundColor Red    
}

$Section_Separator
if (($RHID_CAM_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_CAM_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_SCI_Insertion_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_SCI_Insertion_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_FRONT_END_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_FRONT_END_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_FE_Motor_Calibration).count -eq "") {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_FE_Motor_Calibration | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_FE_Motor_Test).count -eq "") {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_FE_Motor_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Homing_Error_Test).count -eq "") {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Homing_Error_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_FL_Homing_Error_wCAM_Test).count -eq "") {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_FL_Homing_Error_wCAM_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_SCI_Antenna_Test).count -eq "") {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_SCI_Antenna_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_Failed" -ForegroundColor Red    
}

$Section_Separator

if (($RHID_Mezz_test).count -eq "") {
    Write-Host "$MezzActuator : $RHID_Mezz_Test_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Mezz_test | Select-String "Pass") -eq "True") {
    Write-Host "$MezzActuator : $RHID_Mezz_Test_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$MezzActuator : $RHID_Mezz_Test_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_HP_FAT).count -eq "") {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_HP_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_LP_FAT).count -eq "") {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_LP_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Anode_Motor_FAT).count -eq "") {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Anode_Motor_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_BEC_Interlock_FAT).count -eq "") {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_BEC_Interlock_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Gel_Antenna_HIGH).count -eq "") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Gel_Antenna_HIGH | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Gel_Antenna_LOW).count -eq "") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Gel_Antenna_LOW | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Syringe_Stallout_FAT).count -eq "") {
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Syringe_Stallout_FAT | Select-String "Pass") -eq "True") {
    $RHID_Syringe_MIN_CURRENT = ($storyboard | Select-String "Min Current" | Select-Object -Last 1).line.split(",").TrimStart() | Select-Object -Last 1
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_Passed " -ForegroundColor Green
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Cal : $RHID_Syringe_MIN_CURRENT" -ForegroundColor Cyan 
}
else {
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_Failed : $RHID_Syringe_MIN_CURRENT" -ForegroundColor Red    
}

if (($RHID_Mezzboard_FAT).count -eq "") {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Mezzboard_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_Failed" -ForegroundColor Red    
}

If ([Bool]$RHID_BEC_Reinsert_First -eq "True") {
    $RHID_Gel_Void_First = ($storyboard | Select-String "Estimated gel void volume" | Select-Object -First 1).line.split("=").TrimStart() | Select-Object -Last 1
    $RHID_BEC_ID_First = $RHID_BEC_insert_ID.line.split(" ").TrimStart() | Select-Object -Last 1
    Write-host "$BEC_Insertion : $RHID_CoverOff_BEC_Reinsert : Completed ; BEC_ID : $RHID_BEC_ID_First"
    Write-host "$BEC_Insertion : $RHID_First_Gel_Void : $RHID_Gel_Void_First" -ForegroundColor Cyan 
}
Else {
    Write-host "$BEC_Insertion : $RHID_CoverOff_BEC_Reinsert : N/A" -ForegroundColor Yellow 
}

if (($RHID_Piezo_FAT).count -eq "") {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Piezo_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_HV_FAT).count -eq "") {
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_HV_FAT | Select-String "Pass") -eq "True") {
    $RHID_HV_FAT_Voltage = ($storyboard | Select-String "Voltage =" | Select-String "(8650/9300V)" | Select-Object -Last 1).line.split(",").TrimStart() | Select-Object -Last 1
    $RHID_HV_FAT_Current = ($storyboard | Select-String "Current =" | Select-String "(> 5uA)" | Select-Object -Last 1).line.split(",").TrimStart() | Select-Object -Last 1
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$HV : $RHID_HV_FAT_Voltage , $RHID_HV_FAT_Current" -ForegroundColor Green
}
else {
    # Display err when failed "Current Under Limit. Check BEC."
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_Failed $RHID_HV_FAT_Voltage $RHID_HV_FAT_Current" -ForegroundColor Red    
}

if (($RHID_Laser_FAT).count -eq "") {
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Laser_FAT | Select-String "Pass") -eq "True") {
    $RHID_Raman_Signal = ($storyboard | Select-String "Raman =").Line.Split("=").TrimStart() | Select-Object -Last 1
    $RHID_Raman_Bin = ($storyboard | Select-String "Bin =").Line.Split("=").TrimStart() | Select-Object -Last 1
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$Laser : $RHID_Laser_Raman = $RHID_Raman_Signal ; Bin = $RHID_Raman_Bin" -ForegroundColor Green
}
else {
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_Failed" -ForegroundColor Red    }
    