$storyboard = Get-ChildItem "$serverdir" -I storyboard*.* -R 

# add check machine name first, last from log and compare with $env:computername

$MTSS_QMini_str     = "Q-mini serial number"
$MTSS_Mainboard_str = "Main board firmware version"
$MTSS_Mezzbaord_str = "Mezz board firmware version"
$Firmware79           = "1001.4.79"
$MTSS_QMini_SN      = ($storyboard | Select-String $MTSS_QMini_str     | Select-object -last 1).line.split(":").TrimStart()  | Select-object -last 1
$MTSS_QMini_Coeff       = ($storyboard | Select-String "Coefficients"     | Select-object -last 1).line.split(":").TrimStart()   | Select-object -last 1
$MTSS_QMini_Infl        = ($storyboard | Select-String "Inflection Point" | Select-object -last 1).line.split(":").TrimStart()   | Select-object -last 1
$MTSS_Mainboard_FW_Ver  = ($storyboard | Select-String $MTSS_Mainboard_str | Select-object -last 1).line.split(":").TrimStart()  | Select-object -last 1
$MTSS_Mezzbaord_FW_Ver  = ($storyboard | Select-String $MTSS_Mezzbaord_str | Select-object -last 1).line.split(":").TrimStart()  | Select-object -last 1
Write-Host "[Optics] $MTSS_QMini_str : $MTSS_QMini_SN" -ForegroundColor Green
Write-Host "[Optics] Coefficients : $MTSS_QMini_Coeff" -ForegroundColor Green
Write-Host "[Optics] Inflection Point : $MTSS_QMini_Infl" -ForegroundColor Green
if ("$MTSS_Mainboard_FW_Ver" -eq $Firmware79) {
    Write-Host "[PCBA] $MTSS_Mainboard_str : $MTSS_Mainboard_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "[ERROR!] [PCBA] $MTSS_Mainboard_str not updated, $MTSS_Mezzbaord_FW_Ver detected" -ForegroundColor Red }
if ("$MTSS_Mezzbaord_FW_Ver" -eq $Firmware79) {
    Write-Host "[PCBA] $MTSS_Mezzbaord_str : $MTSS_Mezzbaord_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "[ERROR!] [PCBA] $MTSS_Mezzbaord_str not updated, $MTSS_Mezzbaord_FW_Ver detected" -ForegroundColor Red }

$MTSS_Lysis_Heater_str  = "Lysis Heater FAT"
$MTSS_DN_Heater_str     = "DN FAT"
$MTSS_PCR_Heater_str    = "PCR FAT"
$MTSS_Optics_Heater_str = "Optics Heater FAT"
$MTSS_Lysis_Heater_FAT  = $storyboard | Select-String $MTSS_Lysis_Heater_str  | Select-Object -Last 1
$MTSS_DN_Heater_FAT     = $storyboard | Select-String $MTSS_DN_Heater_str     | Select-Object -Last 1
$MTSS_PCR_Heater_FAT    = $storyboard | Select-String $MTSS_PCR_Heater_str    | Select-Object -Last 1
$MTSS_Optics_Heater_FAT = $storyboard | Select-String $MTSS_Optics_Heater_str | Select-Object -Last 1

if (($MTSS_Lysis_Heater_FAT).count -eq "") {
    Write-Host "$MTSS_Lysis_Heater_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($MTSS_Lysis_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Heater] $MTSS_Lysis_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "$MTSS_Lysis_Heater_str test: FAILED" -ForegroundColor Red    }

if (($MTSS_DN_Heater_FAT).count -eq "") {
    Write-Host "$MTSS_DN_Heater_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($MTSS_DN_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Heater] $MTSS_DN_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[Heater] $MTSS_DN_Heater_str test: FAILED"  -ForegroundColor Red    }

if (($MTSS_PCR_Heater_FAT).count -eq "") {
    Write-Host "$MTSS_PCR_Heater_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($MTSS_PCR_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Heater] $MTSS_PCR_Heater_str test: PASSED" -ForegroundColor Green  }
else {
    Write-Host "$MTSS_PCR_Heater_str test: FAILED" -ForegroundColor Red    }

if (($MTSS_Optics_Heater_FAT).count -eq "") {
    Write-Host "$MTSS_Optics_Heater_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($MTSS_Optics_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Heater] $MTSS_Optics_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[Heater] $MTSS_Optics_Heater_str test: FAILED" -ForegroundColor Red    }

# Mainboard tests
$MTSS_Gel_Cooler_str = "Gel Cooling FAT"
$MTSS_Ambient_str    = "Ambient FAT"  
$MTSS_Gel_Cooler_FAT = $storyboard | Select-String $MTSS_Gel_Cooler_str | Select-Object -Last 1
$MTSS_Ambient_FAT    = $storyboard | Select-String $MTSS_Ambient_str    | Select-Object -Last 1

if (($MTSS_Gel_Cooler_FAT).count -eq "") {
    Write-Host "$MTSS_Gel_Cooler_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($MTSS_Gel_Cooler_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Coolant Pump] $MTSS_Gel_Cooler_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[Coolant Pump] $MTSS_Gel_Cooler_str test: FAILED" -ForegroundColor Red    }
if (($MTSS_Ambient_FAT).count -eq "") {
    Write-Host "$MTSS_Ambient_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($MTSS_Ambient_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Sensor] $MTSS_Ambient_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "$MTSS_Ambient_str test: FAILED" -ForegroundColor Red    }

# SCI tests
$MTSS_CAM_FAT_str = "CAM FAT"
$MTSS_CAM_FAT     = ($storyboard | Select-String $MTSS_CAM_FAT_str | select-string "PASS" | Select-Object -Last 1)

if (($MTSS_CAM_FAT).count -eq "") {
    Write-Host "$MTSS_CAM_FAT_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($MTSS_CAM_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[SCI] $MTSS_CAM_FAT_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[SCI] $MTSS_CAM_FAT_str test: FAILED" -ForegroundColor Red    }

    # .line.split(",") | Select-Object -Last 1
#$Pass_Filter = select-string "PASS" | Select-Object -Last 1
$MTSS_SCI_Insertion_FAT     = ($storyboard | Select-String "SCI Insertion FAT" | select-string "PASS" | Select-Object -Last 1)
$MTSS_FRONT_END_FAT         = ($storyboard | Select-String "FRONT END FAT"                  | select-string "PASS" | Select-Object -Last 1)
$MTSS_FE_Motor_Calibration  = ($storyboard | Select-String "Bring Up: FE Motor Calibration" | select-string "PASS" | Select-Object -Last 1)
$MTSS_FE_Motor_Test             = ($storyboard | Select-String "Bring Up: FE Motor Test"        | select-string "PASS" | Select-Object -Last 1)
$MTSS_Homing_Error_Test         = ($storyboard | Select-String "Bring Up: Homing Error Test"    | select-string "PASS" | Select-Object -Last 1)
$MTSS_FL_Homing_Error_wCAM_Test = ($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | select-string "PASS" | Select-Object -Last 1)
$MTSS_SCI_Antenna_Test          = ($storyboard | Select-String "SCI Antenna Test"               | select-string "PASS" | Select-Object -Last 1)

$MTSS_SCI_Insertion_FAT
$MTSS_FRONT_END_FAT
$MTSS_FE_Motor_Calibration
$MTSS_FE_Motor_Test
$MTSS_Homing_Error_Test
$MTSS_FL_Homing_Error_wCAM_Test
$MTSS_SCI_Antenna_Test 

# Mezzboard PCB .line.split(",")| Select-Object -Last 1
$MTSS_Mezz_test = ($storyboard | Select-String "MEZZ test" | select-string "PASS" | Select-Object -Last 1)
$MTSS_HP_FAT    = ($storyboard | Select-String "HP FAT"    | select-string "PASS" | Select-Object -Last 1)
$MTSS_LP_FAT    = ($storyboard | Select-String "LP FAT"    | select-string "PASS" | Select-Object -Last 1)
IF (($storyboard | Select-String "Anode Motor FAT").count -eq ("0")) {
    Write-Host "[Mezzplate] Anode Motor FAT test: N/A"    -ForegroundColor Yellow }
elseif ([bool]($storyboard | Select-String "Anode Motor FAT") -eq ("True")) {
    $MTSS_Anode_Motor_FAT = ($storyboard | Select-String "Anode Motor FAT" | Select-Object -Last 1).line.split(",") | Select-Object -Last 1
    Write-Host "[Mezzplate] Anode Motor FAT test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[Mezzplate] Anode Motor FAT test: FAILED" -ForegroundColor Red   }

    #.line.split(",")| Select-Object -Last 1
$MTSS_BEC_Interlock_FAT = ($storyboard | Select-String "BEC Interlock FAT"     | select-string "PASS"| Select-Object -Last 1)
$MTSS_Gel_Antenna_LOW   = ($storyboard | Select-String "Bring Up: Gel Antenna" | select-string "PASS"| Select-String "high" | Select-Object -Last 1)
$MTSS_Gel_Antenna_HIGH  = ($storyboard | Select-String "Bring Up: Gel Antenna" | select-string "PASS"| Select-String "low"  | Select-Object -Last 1)
$MTSS_Syringe_Stallout_FAT  = ($storyboard | Select-String "Syringe Stallout FAT"  | select-string "PASS" | Select-Object -Last 1)
$MTSS_Syringe_MIN_CURRENT   = ($storyboard | Select-String "Min Current"       | Select-Object -Last 1).line.split(",").TrimStart()| Select-Object -Last 1
$MTSS_Mezzboard_FAT         = ($storyboard | Select-String "Mezzboard FAT"     | select-string "PASS"| Select-Object -Last 1)
$MTSS_BEC_Reinsert_First    = ($storyboard | Select-String "BEC Reinsert completed" | Select-Object -First 1).line.split(",")| Select-Object -Last 1 #First BEC Insertion
$MTSS_Gel_Void_First = ($storyboard | Select-String "Estimated gel void volume" | Select-Object -First 1).line.split(",").TrimStart()| Select-Object -Last 1
$MTSS_BEC_Reinsert   = ($storyboard | Select-String "BEC Reinsert completed"    | Select-Object -Last 1).line.split(",")| Select-Object -Last 1 #Cover-on BEC Insertion
$MTSS_Gel_Void       = ($storyboard | Select-String "Estimated gel void volume" | Select-object -last 1).line.split(",").TrimStart()| Select-Object -Last 1

# .line.split(",")| Select-Object -Last 1
$MTSS_Piezo_FAT = ($storyboard | Select-String "Piezo FAT" | select-string "PASS" | Select-Object -Last 1)
$MTSS_HV_FAT    = ($storyboard | Select-String "HV FAT"    | select-string "PASS" | Select-Object -Last 1)
$MTSS_Laser_FAT = ($storyboard | Select-String "Laser FAT" | select-string "PASS" | Select-Object -Last 1)

$MTSS_Water_Prime      = ($storyboard | Select-String "Bring Up: Water Prime" | select-string "PASS"| Select-Object -Last 1)
$MTSS_Water_Prime_Plug = ($storyboard | Select-String "Plug detected"         | Select-Object -Last 1).line.split(",").TrimStart()| Select-Object -Last 2 | Select-Object -SkipLast 1
$MTSS_Water_Prime
$MTSS_Water_Prime_Plug
# .line.split(",")| Select-Object -Last 1
$MTSS_Lysis_Prime    = ($storyboard | Select-String "Bring Up: Lysis Prime"         | select-string "PASS"| Select-Object -Last 1)
$MTSS_Buffer_Prime   = ($storyboard | Select-String "Bring Up: Buffer Prime"        | select-string "PASS"| Select-Object -Last 1)
$MTSS_Lysis_Dispense = ($storyboard | Select-String "Bring Up: Lysis Dispense Test" | select-string "PASS"| Select-Object -Last 1)

$MTSS_Lysate_Pull = ($storyboard | Select-String "Bring Up: Lysate Pull" | select-string "PASS"| Select-Object -Last 1)

$MTSS_Capillary_Gel_Prime = ($storyboard | Select-String "Bring Up: Capillary Gel Prime" | select-string "Completed" | Select-Object -Last 1)
$MTSS_Raman               = ($storyboard | Select-String "Bring Up: Verify Raman" | select-string "PASS" | Select-Object -Last 1)

$MTSS_Bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Bolus Devliery Test" 
# $MTSS_Bolus[2,3,4,5,6,7,8,9,0,1] (Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R |  select-string "Timing" | Select-Object -Last 1) ForEach-Object -MemberName Split -ArgumentList "." -ExpandProperty Line
Write-host Passed Bolus test count: ($MTSS_Bolus | select-string "PASS").count
#  $bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Timing" |  Select-Object -ExpandProperty Line  | ForEach-Object -MemberName Split -ArgumentList "="