$storyboard = Get-ChildItem "$serverdir" -I storyboard*.* -R 

#($storyboard | Select-String "Q-mini serial number" | Select-Object -Last 1)
$MTSS_Mainboard_str = "Main board firmware version"
$MTSS_Mezzbaord_str = "Mezz board firmware version"
$MTSS_Mainboard_FW = ($storyboard | Select-String $MTSS_Mainboard_str | select-string "1001.4.79" | Select-Object -Last 1)
$MTSS_Mezzbaord_FW = ($storyboard | Select-String $MTSS_Mezzbaord_str | select-string "1001.4.79" | Select-Object -Last 1)
if ([bool]"$MTSS_Mainboard_FW" -eq "True") {
    Write-Host "$MTSS_Mainboard_str : 1001.4.79" -ForegroundColor Green }
else {
    Write-Host "$MTSS_Mainboard_str not updated" -ForegroundColor Red }
if ([bool]"$MTSS_Mezzbaord_FW" -eq "True") {
    Write-Host "$MTSS_Mezzbaord_str : 1001.4.79" -ForegroundColor Green }
else {
    Write-Host "$MTSS_Mezzbaord_str not updated" -ForegroundColor Red }

# Heater tests
$MTSS_Lysis_Heater_FAT = ($storyboard | Select-String "Lysis Heater FAT" | select-string "PASS" | Select-Object -Last 1)
if ([bool]"$MTSS_Lysis_Heater_FAT" -eq "True") {
    Write-Host "Lysis Heater FAT test: PASSED" -ForegroundColor Green }
else {
    Write-Host "Lysis Heater FAT test: FAILED" -ForegroundColor Red }

($storyboard | Select-String "DN FAT"            | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "PCR FAT"           | select-string "PASS"| Select-Object -Last 1)
($storyboard | Select-String "Optics Heater FAT" | select-string "PASS"| Select-Object -Last 1)

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