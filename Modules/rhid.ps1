$storyboard = Get-ChildItem "$serverdir" -I storyboard*.* -R 
$MachineName = ($storyboard | Select-String "MachineName" | Select-Object -Last 1).Line.Split(":").TrimStart() | Select-Object -Last 1
Write-Host "[RapidHIT ID] Gathering Instrument $MachineName run data for result..." -ForegroundColor Magenta
# add check machine name first, last from log and compare with $env:computername

$RHID_QMini_str     = "Q-mini serial number"
$RHID_Mainboard_str = "Main board firmware version"
$RHID_Mezzbaord_str = "Mezz board firmware version"
$Firmware79           = "1001.4.79"
$RHID_QMini_SN      = ($storyboard | Select-String $RHID_QMini_str     | Select-object -last 1).line.split(":").TrimStart()  | Select-object -last 1
$RHID_QMini_Coeff       = ($storyboard | Select-String "Coefficients"     | Select-object -last 1).line.split(":").TrimStart()   | Select-object -last 1
$RHID_QMini_Infl        = ($storyboard | Select-String "Inflection Point" | Select-object -last 1).line.split(":").TrimStart()   | Select-object -last 1
$RHID_Mainboard_FW_Ver  = ($storyboard | Select-String $RHID_Mainboard_str | Select-object -last 1).line.split(":").TrimStart()  | Select-object -last 1
$RHID_Mezzbaord_FW_Ver  = ($storyboard | Select-String $RHID_Mezzbaord_str | Select-object -last 1).line.split(":").TrimStart()  | Select-object -last 1
Write-Host "[Optics] $RHID_QMini_str : $RHID_QMini_SN" -ForegroundColor Green
Write-Host "[Optics] Coefficients : $RHID_QMini_Coeff" -ForegroundColor Green
Write-Host "[Optics] Inflection Point : $RHID_QMini_Infl" -ForegroundColor Green
if ("$RHID_Mainboard_FW_Ver" -eq $Firmware79) {
    Write-Host "[PCBA] $RHID_Mainboard_str : $RHID_Mainboard_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "[ERROR!] [PCBA] $RHID_Mainboard_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red }
if ("$RHID_Mezzbaord_FW_Ver" -eq $Firmware79) {
    Write-Host "[PCBA] $RHID_Mezzbaord_str : $RHID_Mezzbaord_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "[ERROR!] [PCBA] $RHID_Mezzbaord_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red }

$RHID_Lysis_Heater_str  = "Lysis Heater FAT"
$RHID_DN_Heater_str     = "DN FAT"
$RHID_PCR_Heater_str    = "PCR FAT"
$RHID_Optics_Heater_str = "Optics Heater FAT"
$RHID_Lysis_Heater_FAT  = $storyboard | Select-String $RHID_Lysis_Heater_str  | Select-Object -Last 1
$RHID_DN_Heater_FAT     = $storyboard | Select-String $RHID_DN_Heater_str     | Select-Object -Last 1
$RHID_PCR_Heater_FAT    = $storyboard | Select-String $RHID_PCR_Heater_str    | Select-Object -Last 1
$RHID_Optics_Heater_FAT = $storyboard | Select-String $RHID_Optics_Heater_str | Select-Object -Last 1

if (($RHID_Lysis_Heater_FAT).count -eq "") {
    Write-Host "$RHID_Lysis_Heater_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysis_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Heater] $RHID_Lysis_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "$RHID_Lysis_Heater_str test: FAILED" -ForegroundColor Red    }

if (($RHID_DN_Heater_FAT).count -eq "") {
    Write-Host "$RHID_DN_Heater_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_DN_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Heater] $RHID_DN_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[Heater] $RHID_DN_Heater_str test: FAILED"  -ForegroundColor Red    }

if (($RHID_PCR_Heater_FAT).count -eq "") {
    Write-Host "$RHID_PCR_Heater_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_PCR_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Heater] $RHID_PCR_Heater_str test: PASSED" -ForegroundColor Green  }
else {
    Write-Host "$RHID_PCR_Heater_str test: FAILED" -ForegroundColor Red    }

if (($RHID_Optics_Heater_FAT).count -eq "") {
    Write-Host "$RHID_Optics_Heater_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Optics_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Heater] $RHID_Optics_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[Heater] $RHID_Optics_Heater_str test: FAILED" -ForegroundColor Red    }

# Mainboard tests
$RHID_Gel_Cooler_str = "Gel Cooling FAT"
$RHID_Ambient_str    = "Ambient FAT"  
$RHID_Gel_Cooler_FAT = $storyboard | Select-String $RHID_Gel_Cooler_str | Select-Object -Last 1
$RHID_Ambient_FAT    = $storyboard | Select-String $RHID_Ambient_str    | Select-Object -Last 1

if (($RHID_Gel_Cooler_FAT).count -eq "") {
    Write-Host "$RHID_Gel_Cooler_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Gel_Cooler_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Coolant Pump] $RHID_Gel_Cooler_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[Coolant Pump] $RHID_Gel_Cooler_str test: FAILED" -ForegroundColor Red    }
if (($RHID_Ambient_FAT).count -eq "") {
    Write-Host "$RHID_Ambient_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Ambient_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[Sensor] $RHID_Ambient_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "$RHID_Ambient_str test: FAILED" -ForegroundColor Red    }

# SCI tests
$RHID_CAM_FAT_str = "CAM FAT"
$RHID_CAM_FAT     = ($storyboard | Select-String $RHID_CAM_FAT_str | select-string "PASS" | Select-Object -Last 1)

if (($RHID_CAM_FAT).count -eq "") {
    Write-Host "$RHID_CAM_FAT_str test: N/A"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_CAM_FAT | Select-String "Pass") -eq "True") {
    Write-Host "[SCI] $RHID_CAM_FAT_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[SCI] $RHID_CAM_FAT_str test: FAILED" -ForegroundColor Red    }

    # .line.split(",") | Select-Object -Last 1
#$Pass_Filter = select-string "PASS" | Select-Object -Last 1
$RHID_SCI_Insertion_FAT     = ($storyboard | Select-String "SCI Insertion FAT" | select-string "PASS" | Select-Object -Last 1)
$RHID_FRONT_END_FAT         = ($storyboard | Select-String "FRONT END FAT"                  | select-string "PASS" | Select-Object -Last 1)
$RHID_FE_Motor_Calibration  = ($storyboard | Select-String "Bring Up: FE Motor Calibration" | select-string "PASS" | Select-Object -Last 1)
$RHID_FE_Motor_Test             = ($storyboard | Select-String "Bring Up: FE Motor Test"        | select-string "PASS" | Select-Object -Last 1)
$RHID_Homing_Error_Test         = ($storyboard | Select-String "Bring Up: Homing Error Test"    | select-string "PASS" | Select-Object -Last 1)
$RHID_FL_Homing_Error_wCAM_Test = ($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | select-string "PASS" | Select-Object -Last 1)
$RHID_SCI_Antenna_Test          = ($storyboard | Select-String "SCI Antenna Test"               | select-string "PASS" | Select-Object -Last 1)

$RHID_SCI_Insertion_FAT
$RHID_FRONT_END_FAT
$RHID_FE_Motor_Calibration
$RHID_FE_Motor_Test
$RHID_Homing_Error_Test
$RHID_FL_Homing_Error_wCAM_Test
$RHID_SCI_Antenna_Test 

# Mezzboard PCB .line.split(",")| Select-Object -Last 1
$RHID_Mezz_test = ($storyboard | Select-String "MEZZ test" | select-string "PASS" | Select-Object -Last 1)
$RHID_HP_FAT    = ($storyboard | Select-String "HP FAT"    | select-string "PASS" | Select-Object -Last 1)
$RHID_LP_FAT    = ($storyboard | Select-String "LP FAT"    | select-string "PASS" | Select-Object -Last 1)
IF (($storyboard | Select-String "Anode Motor FAT").count -eq ("0")) {
    Write-Host "[Mezzplate] Anode Motor FAT test: N/A"    -ForegroundColor Yellow }
elseif ([bool]($storyboard | Select-String "Anode Motor FAT") -eq ("True")) {
    $RHID_Anode_Motor_FAT = ($storyboard | Select-String "Anode Motor FAT" | Select-Object -Last 1).line.split(",") | Select-Object -Last 1
    Write-Host "[Mezzplate] Anode Motor FAT test: PASSED" -ForegroundColor Green }
else {
    Write-Host "[Mezzplate] Anode Motor FAT test: FAILED" -ForegroundColor Red   }

    #.line.split(",")| Select-Object -Last 1
$RHID_BEC_Interlock_FAT = ($storyboard | Select-String "BEC Interlock FAT"     | select-string "PASS"| Select-Object -Last 1)
$RHID_Gel_Antenna_LOW   = ($storyboard | Select-String "Bring Up: Gel Antenna" | select-string "PASS"| Select-String "high" | Select-Object -Last 1)
$RHID_Gel_Antenna_HIGH  = ($storyboard | Select-String "Bring Up: Gel Antenna" | select-string "PASS"| Select-String "low"  | Select-Object -Last 1)
$RHID_Syringe_Stallout_FAT  = ($storyboard | Select-String "Syringe Stallout FAT"  | select-string "PASS" | Select-Object -Last 1)
$RHID_Syringe_MIN_CURRENT   = ($storyboard | Select-String "Min Current"       | Select-Object -Last 1).line.split(",").TrimStart()| Select-Object -Last 1
$RHID_Mezzboard_FAT         = ($storyboard | Select-String "Mezzboard FAT"     | select-string "PASS"| Select-Object -Last 1)
$RHID_BEC_Reinsert_First    = ($storyboard | Select-String "BEC Reinsert completed" | Select-Object -First 1).line.split(",")| Select-Object -Last 1 #First BEC Insertion
$RHID_Gel_Void_First = ($storyboard | Select-String "Estimated gel void volume" | Select-Object -First 1).line.split(",").TrimStart()| Select-Object -Last 1
$RHID_BEC_Reinsert   = ($storyboard | Select-String "BEC Reinsert completed"    | Select-Object -Last 1).line.split(",")| Select-Object -Last 1 #Cover-on BEC Insertion
$RHID_Gel_Void       = ($storyboard | Select-String "Estimated gel void volume" | Select-object -last 1).line.split(",").TrimStart()| Select-Object -Last 1

# .line.split(",")| Select-Object -Last 1
$RHID_Piezo_FAT = ($storyboard | Select-String "Piezo FAT" | select-string "PASS" | Select-Object -Last 1)
$RHID_HV_FAT    = ($storyboard | Select-String "HV FAT"    | select-string "PASS" | Select-Object -Last 1)
$RHID_Laser_FAT = ($storyboard | Select-String "Laser FAT" | select-string "PASS" | Select-Object -Last 1)

$RHID_Water_Prime      = ($storyboard | Select-String "Bring Up: Water Prime" | select-string "PASS"| Select-Object -Last 1)
$RHID_Water_Prime_Plug = ($storyboard | Select-String "Plug detected"         | Select-Object -Last 1).line.split(",").TrimStart()| Select-Object -Last 2 | Select-Object -SkipLast 1
$RHID_Water_Prime
Write-Host "[ Wet-Test ] $RHID_Water_Prime_Plug" -ForegroundColor Cyan
# .line.split(",")| Select-Object -Last 1
$RHID_Lysis_Prime    = ($storyboard | Select-String "Bring Up: Lysis Prime"         | select-string "PASS"| Select-Object -Last 1)
$RHID_Buffer_Prime   = ($storyboard | Select-String "Bring Up: Buffer Prime"        | select-string "PASS"| Select-Object -Last 1)
$RHID_Lysis_Dispense = ($storyboard | Select-String "Bring Up: Lysis Dispense Test" | select-string "PASS"| Select-Object -Last 1)

$RHID_Lysate_Pull = ($storyboard | Select-String "Bring Up: Lysate Pull" | select-string "PASS"| Select-Object -Last 1)

$RHID_Capillary_Gel_Prime = ($storyboard | Select-String "Bring Up: Capillary Gel Prime" | select-string "Completed" | Select-Object -Last 1)
$RHID_Raman               = ($storyboard | Select-String "Bring Up: Verify Raman" | select-string "PASS" | Select-Object -Last 1)

$RHID_Bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Bolus Devliery Test" 
Write-host "[   Bolus  ] Passed Bolus test count:" ($RHID_Bolus | select-string "PASS").count -ForegroundColor Green

$StatusData_leaf  = Get-ChildItem -Path "$serverdir" -I $StatusData  -R | Test-path -PathType Leaf
$GM_Analysis_leaf = Get-ChildItem -Path "$serverdir" -I $GM_Analysis -R | Test-path -PathType Leaf

if ([Bool] ($StatusData_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_StatusData_PDF = Get-ChildItem -Path "$serverdir" -I $StatusData  -R | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "[ Full-Run ] $StatusData Found in these folders" -ForegroundColor Green
    $RHID_StatusData_PDF
}
else {
    Write-host "[ Full-Run ] $StatusData not found, PDF not exported or no full run has been performed" -ForegroundColor yellow }

if ([Bool] ($GM_Analysis_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_GM_Analysis = Get-ChildItem -Path "$serverdir" -I $GM_Analysis -R | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "[ Full-Run ] $GM_Analysis Found in these folders" -ForegroundColor Green
    $RHID_GM_Analysis
}
else {Write-host "[ Full-Run ] $GM_Analysis not found or no full run has been performed" -ForegroundColor yellow }

$RHID_Shipping_BEC = ($storyboard | Select-String "Shipping BEC engaged") | Select-Object -Last 1
$RHID_Shipping_BEC

# "$danno\RHID-$sn2" 
$Danno_Local_leaf = Test-Path -Path "$danno\$MachineName"
$Danno_Input_leaf = Test-Path -Path "$danno\RHID-$sn2"
IF ($Danno_Local_leaf -eq "True") {
    $RHID_Danno_Path = "$danno\$MachineName"}
    elseif ($Danno_Input_leaf -eq "True") {
    $RHID_Danno_Path = "$danno\RHID-$sn2"
    } Else {
        Write-Host "[ BoxPrep ] Boxprep not yet Initialized" -ForegroundColor Yellow
        $RHID_Danno_Path = ""
    }
If ($RHID_Danno_Path -ne "") {
    $RHID_HIDAutolite = (Get-ChildItem $RHID_Danno_Path -I *BoxPrepLog_RHID* -R  -Exclude "*.log" | Select-String "SoftGenetics License number provided is" | Select-Object -Last 1).Line.Split(" ").TrimStart() | Select-Object -Last 1
Write-Host "[HIDAutolite]" HIDAutolite License key provided is: $RHID_HIDAutolite -ForegroundColor Green
}
# $RHID_Bolus[2,3,4,5,6,7,8,9,0,1] (Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R |  select-string "Timing" | Select-Object -Last 1) ForEach-Object -MemberName Split -ArgumentList "." -ExpandProperty Line
#  $bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Timing" |  Select-Object -ExpandProperty Line  | ForEach-Object -MemberName Split -ArgumentList "="