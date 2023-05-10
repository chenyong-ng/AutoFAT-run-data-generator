
"$Loading : Heaters textual filtering commands "
$RHID_Lysis_Heater_FAT  = $storyboard | Select-String "Lysis Heater FAT"
$RHID_DN_Heater_FAT     = $storyboard | Select-String "DN FAT"
$RHID_PCR_Heater_FAT    = $storyboard | Select-String "PCR FAT"
$RHID_Optics_Heater_FAT = $storyboard | Select-String "Optics Heater FAT"

$RHID_Gel_Cooler_FAT    = $storyboard | Select-String "Gel Cooling FAT"
$RHID_Ambient_FAT       = $storyboard | Select-String "Ambient FAT"

"$Loading : SCI textual filtering commands "
$RHID_CAM_FAT = ($storyboard | Select-String "CAM FAT" | Select-Object -Last 1)
$RHID_SCI_Insertion_FAT = ($storyboard | Select-String "SCI Insertion FAT" | Select-Object -Last 1)
$RHID_FRONT_END_FAT = ($storyboard | Select-String "FRONT END FAT" | Select-Object -Last 1)
$RHID_FE_Motor_Calibration = ($storyboard | Select-String "Bring Up: FE Motor Calibration" | Select-Object -Last 1)
$RHID_FE_Motor_Test = ($storyboard | Select-String "Bring Up: FE Motor Test" | Select-Object -Last 1)
$RHID_Homing_Error_Test = ($storyboard | Select-String "Bring Up: Homing Error Test" | Select-Object -Last 1)
$RHID_FL_Homing_Error_wCAM_Test = ($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | Select-Object -Last 1)

$RHID_SCI_Antenna_Test = ($storyboard | Select-String "Bring Up: SCI Antenna Test" | Select-Object -Last 1)
$RHID_Mezz_test = $storyboard | Select-String "MEZZ test" | Select-Object -Last 1

"$Loading : MEZZ textual filtering commands "
$RHID_HP_FAT = $storyboard | Select-String "HP FAT"    | Select-Object -Last 1
$RHID_LP_FAT = $storyboard | Select-String "LP FAT"    | Select-Object -Last 1
$RHID_Anode_Motor_FAT = $storyboard | Select-String "Anode Motor FAT" | Select-Object -Last 1

"$Loading : BEC textual filtering commands "
$RHID_BEC_Interlock_FAT = ($storyboard | Select-String "BEC Interlock FAT" | Select-Object -Last 1)
$RHID_Gel_Antenna_LOW = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "Low" | Select-Object -Last 1)
$RHID_Gel_Antenna_HIGH = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "High"  | Select-Object -Last 1)
$RHID_Syringe_Stallout_FAT = ($storyboard | Select-String "Syringe Stallout FAT" | Select-Object -Last 1)
$RHID_Mezzboard_FAT = ($storyboard | Select-String "Mezzboard FAT" |  Select-Object -Last 1)

"$Loading : BEC Insertion textual filtering commands "
$RHID_BEC_Reinsert_First = ($storyboard | Select-String "BEC Reinsert completed" | Select-Object -First 1) 
$RHID_BEC_insert_ID = ($storyboard | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Select-String "BEC Insertion BEC_") | Select-Object -First 1
$RHID_Piezo_FAT = ($storyboard | Select-String "Piezo FAT" | Select-Object -Last 1)
$RHID_HV_FAT = ($storyboard | Select-String "HV FAT" | Select-Object -Last 1)
$RHID_Laser_FAT = ($storyboard | Select-String "Laser FAT" | Select-Object -Last 1)

function RHID_Heater_Test {
$RHID_Lysis_Heater_FAT_PASS = ($RHID_Lysis_Heater_FAT | Select-String "PASS" )
$RHID_Lysis_Heater_FAT_FAIL = ($RHID_Lysis_Heater_FAT | Select-String "FAIL" )
if ($RHID_Lysis_Heater_FAT.count -eq "0") {
    $Lysis_Heater_Test_Result = $Test_NA
    $LHColor = "Yellow"
}
elseif ($RHID_Lysis_Heater_FAT_PASS.Line.split(":").TrimStart()[-1] -eq "PASS") {
    $Lysis_Heater_Test_Result = $Test_Passed
    $LHColor = "Green"
}
elseif ($RHID_Lysis_Heater_FAT_FAIL.Line.split(":").TrimStart()[-1] -eq "FAIL") {
    $Lysis_Heater_Test_Result = $Test_Failed
    $LHColor = "Red"
}
Write-Host "$Heater : $RHID_Lysis_Heater_str $Lysis_Heater_Test_Result" -ForegroundColor $LHColor

$RHID_DN_Heater_FAT_PASS = ($RHID_DN_Heater_FAT | Select-String "PASS" )
$RHID_DN_Heater_FAT_FAIL = ($RHID_DN_Heater_FAT | Select-String "FAIL" )
if (($RHID_DN_Heater_FAT).count -eq "0") {
    $DN_Heater_Test_Result = $Test_NA
    $DNHColor = "Yellow"
}
elseif ($RHID_DN_Heater_FAT_PASS.Line.split(":").TrimStart()[-1] -eq "PASS") {
    $DN_Heater_Test_Result = $Test_Passed
    $DNHColor = "Green"
}
elseif ($RHID_DN_Heater_FAT_FAIL.Line.split(":").TrimStart()[-1] -eq "FAIL") {
    $DN_Heater_Test_Result = $Test_Failed
    $DNHColor = "Red" 
}
Write-Host "$Heater : $RHID_DN_Heater_str $DN_Heater_Test_Result" -ForegroundColor $DNHColor

$RHID_PCR_Heater_FAT_PASS = ($RHID_PCR_Heater_FAT | Select-String "PASS" )
$RHID_PCR_Heater_FAT_FAIL = ($RHID_PCR_Heater_FAT | Select-String "FAIL" )
if (($RHID_PCR_Heater_FAT).count -eq "0") {
    $PCR_Heater_Test_Result = $Test_NA
    $PCRColor = "Yellow"
}
elseif ($RHID_PCR_Heater_FAT_PASS.Line.split(":").TrimStart()[-1] -eq "PASS") {
    $PCR_Heater_Test_Result = $Test_Passed
    $PCRColor = "Green"
}
elseif ($RHID_PCR_Heater_FAT_FAIL.Line.split(":").TrimStart()[-1] -eq "FAIL") {
    $PCR_Heater_Test_Result = $Test_Failed
    $PCRColor = "Red" 
}
Write-Host "$Heater : $RHID_PCR_Heater_str $PCR_Heater_Test_Result -ForegroundColor $PCRColor

$RHID_Optics_Heater_FAT_PASS = ($RHID_Optics_Heater_FAT | Select-String "PASS" )
$RHID_Optics_Heater_FAT_FAIL = ($RHID_Optics_Heater_FAT | Select-String "FAIL" )
if (($RHID_Optics_Heater_FAT).count -eq "0") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_NA" -ForegroundColor Yellow 
}
elseif ($RHID_Optics_Heater_FAT_PASS.Line.split(":").TrimStart()[-1] -eq "PASS") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_Passed" -ForegroundColor Green 
}
elseif ($RHID_Optics_Heater_FAT_FAIL.Line.split(":").TrimStart()[-1] -eq "FAIL") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_Failed" -ForegroundColor Red    
}
If ($VerboseMode -eq "True") {
    RHID_Heater_Verbose
}
}

$RHID_Gel_Cooler_FAT_PASS = ($RHID_Gel_Cooler_FAT | Select-String "PASS" )
$RHID_Gel_Cooler_FAT_FAIL = ($RHID_Gel_Cooler_FAT | Select-String "FAIL" )
function RHID_GelCooler {
if (($RHID_Gel_Cooler_FAT).count -eq "0") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ($RHID_Gel_Cooler_FAT_PASS.Line.split(":").TrimStart()[-1] -eq "PASS") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_Passed" -ForegroundColor Green 
}
elseif ($RHID_Gel_Cooler_FAT_FAIL.Line.split(":").TrimStart()[-1] -eq "FAIL") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_Failed" -ForegroundColor Red    
}
}

$RHID_Ambient_FAT_PASS = ($RHID_Ambient_FAT | Select-String "PASS" )
$RHID_Ambient_FAT_FAIL = ($RHID_Ambient_FAT | Select-String "FAIL" )
function RHID_Ambient_Sensor {
if (($RHID_Ambient_FAT).count -eq "") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_NA"    -ForegroundColor Yellow 
}
elseif ($RHID_Ambient_FAT_PASS.Line.split(":").TrimStart()[-1] -eq "PASS") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_Passed" -ForegroundColor Green 
}
elseif ($RHID_Ambient_FAT_FAIL.Line.split(":").TrimStart()[-1] -eq "FAIL") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_Failed" -ForegroundColor Red    
}
}

function RHID_SCI_Tests {
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
}
function RHID_MezzFuctionTest {
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
}

function RHID_SyringePump {
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
}

function RHID_MezzBEC_Test {
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
}
