$storyboard = Get-ChildItem "$serverdir" -I storyboard*.* -R 

#($storyboard | Select-String "Q-mini serial number" | Select-Object -Last 1)
$MTSS_QMini_str     = "Q-mini serial number"
$MTSS_Mainboard_str = "Main board firmware version"
$MTSS_Mezzbaord_str = "Mezz board firmware version"
$Firmware           = "1001.4.79"
$MTSS_QMini_SN      = ($storyboard | Select-String $MTSS_QMini_str     | Select-object -last 1).line.split(":"" ") | Select-object -last 1
$MTSS_Mainboard_FW  = ($storyboard | Select-String $MTSS_Mainboard_str | Select-object -last 1).line.split(":"" ") | Select-object -last 1
$MTSS_Mezzbaord_FW  = ($storyboard | Select-String $MTSS_Mezzbaord_str | Select-object -last 1).line.split(":"" ") | Select-object -last 1
Write-Host "$MTSS_QMini_str : $MTSS_QMini_SN" -ForegroundColor Green
if ([bool]"$MTSS_Mainboard_FW" -eq "True") {
    Write-Host "$MTSS_Mainboard_str : $Firmware" -ForegroundColor Green }
else {
    Write-Host "$MTSS_Mainboard_str not updated" -ForegroundColor Red }
if ([bool]"$MTSS_Mezzbaord_FW" -eq "True") {
    Write-Host "$MTSS_Mezzbaord_str : $Firmware" -ForegroundColor Green }
else {
    Write-Host "$MTSS_Mezzbaord_str not updated" -ForegroundColor Red }

$MTSS_Lysis_Heater_str  = "Lysis Heater FAT"
$MTSS_DN_Heater_str     = "DN Heater FAT"
$MTSS_PCR_Heater_str    = "PCR Heater FAT"
$MTSS_Optics_Heater_str = "Optics Heater FAT"
$MTSS_Lysis_Heater_FAT  = $storyboard | Select-String "Lysis Heater FAT"  | Select-Object -Last 1
$MTSS_DN_Heater_FAT     = $storyboard | Select-String "DN FAT"            | Select-Object -Last 1
$MTSS_PCR_Heater_FAT    = $storyboard | Select-String "PCR FAT"           | Select-Object -Last 1
$MTSS_Optics_Heater_FAT = $storyboard | Select-String "Optics Heater FAT" | Select-Object -Last 1

if (($MTSS_Lysis_Heater_FAT).count -eq "") {
    Write-Host "$MTSS_Lysis_Heater_str test: N/A" -ForegroundColor Yellow }
elseif ([bool]($MTSS_Lysis_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$MTSS_Lysis_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "$MTSS_Lysis_Heater_str test: FAILED" -ForegroundColor Red }

if (($MTSS_DN_Heater_FAT).count -eq "") {
    Write-Host "$MTSS_DN_Heater_str test: N/A" -ForegroundColor Yellow }
elseif ([bool]($MTSS_DN_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$MTSS_DN_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "$MTSS_DN_Heater_str test FAILED" -ForegroundColor Red }

if (($MTSS_PCR_Heater_FAT).count -eq "") {
    Write-Host "$MTSS_PCR_Heater_str test: N/A" -ForegroundColor Yellow }
elseif ([bool]($MTSS_PCR_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$MTSS_PCR_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "$MTSS_PCR_Heater_str test: FAILED" -ForegroundColor Red }

if (($MTSS_Optics_Heater_FAT).count -eq "") {
    Write-Host "$MTSS_Optics_Heater_str test: N/A" -ForegroundColor Yellow }
elseif ([bool]($MTSS_Optics_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$MTSS_Optics_Heater_str test: PASSED" -ForegroundColor Green }
else {
    Write-Host "$MTSS_Optics_Heater_str test: FAILED" -ForegroundColor Red }

# Mainboard tests
($storyboard | Select-String "Gel Cooling FAT"   | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Ambient FAT"       | select-string "PASS"| Select-Object -Last 1)
# SCI tests
($storyboard | Select-String "CAM FAT"           | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "SCI Insertion FAT" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "FRONT END FAT"                  | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: FE Motor Calibration" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: FE Motor Test"        | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Homing Erro r Test"   | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "SCI Antenna Test"               | select-string "PASS"| Select-Object -Last 1)

# Mezzboard Motor
($storyboard | Select-String "MEZZ test" | select-string "PASS" | Select-Object -Last 1)
($storyboard | Select-String "LP FAT"    | select-string "PASS" | Select-Object -Last 1)
($storyboard | Select-String "HP FAT"    | select-string "PASS" | Select-Object -Last 1)
($storyboard | Select-String "Anode Motor FAT"   | select-string "PASS"  | Select-Object -Last 1)
($storyboard | Select-String "BEC Interlock FAT" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Gel Antenna" | select-string "PASS"| Select-String "high" | Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Gel Antenna" | select-string "PASS"| Select-String "low"  | Select-Object -Last 1)
($storyboard | Select-String "Syringe Stallout FAT"  | select-string "PASS" | Select-Object -Last 1)
($storyboard | Select-String "Mezzboard FAT"     | select-string "PASS"| Select-Object -Last 1)
    
($storyboard | Select-String "Piezo FAT" | select-string "PASS" | Select-Object -Last 1)
($storyboard | Select-String "HV FAT"    | select-string "PASS" | Select-Object -Last 1)
($storyboard | Select-String "Laser FAT" | select-string "PASS" | Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Verify Raman" | select-string "PASS"| Select-Object -Last 1)

($storyboard | Select-String "Bring Up: Water Prime" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Plug detected" | Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Lysis Prime" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Buffer Prime" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Lysis Dispense Test" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Lysis Volume" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Lysate Pull" | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Bring Up: Capillary Gel Prime" | select-string "PASS"| Select-Object -Last 1)

# Bolus tests  ([0-9]{1,3}\.\d\d[s])
$MTSS_Bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Bolus Devliery Test" | select-string "PASS"
# $MTSS_Bolus[2,3,4,5,6,7,8,9,0,1]
Write-host Passed Bolus test count: $MTSS_Bolus.count

# Print RFID of BEC, Sample Cartridge. separate mtss test with prefix such sd [HEATER], [SCI] etc., add history and test count, apply no filter.