$storyboard = Get-ChildItem "$serverdir" -I storyboard*.* -R 

$storyboard | Select-String "Q-mini serial number" | Select-Object -Last 1
[bool]($storyboard | Select-String "Main board firmware version" | select-string "1001.4.79" | Select-Object -Last 1)
[bool]($storyboard | Select-String "Mezz board firmware version" | select-string "1001.4.79" | Select-Object -Last 1)

# Heater tests
$MTSS_Lysis_Heater_FAT = [bool]($storyboard | Select-String "Lysis Heater FAT" | select-string "PASS"  | Select-Object -Last 1)
if ("$MTSS_Lysis_Heater_FAT" -eq "True") {
    Write-Host "Lysis Heater FAT test PASSED" -ForegroundColor green }
else {
    Write-Host "Lysis Heater FAT test FAILED" -ForegroundColor red }

[bool]($storyboard | Select-String "DN FAT"            | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "PCR FAT"           | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "Optics Heater FAT" | select-string "PASS"  | Select-Object -Last 1)

# Mainboard tests
[bool]($storyboard | Select-String "Gel Cooling FAT" | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "Ambient FAT"     | select-string "PASS"  | Select-Object -Last 1)
# SCI tests
[bool]($storyboard | Select-String "CAM FAT"           | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "SCI Insertion FAT" | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "FRONT END FAT"                  | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "Bring Up: FE Motor Calibration" | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "Bring Up: FE Motor Test"        | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "Bring Up: Homing Erro r Test"   | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "SCI Antenna Test"               | select-string "PASS"  | Select-Object -Last 1)

# Mezzboard Motor
[bool]($storyboard | Select-String "MEZZ test" | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "LP FAT" | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "HP FAT" | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "Anode Motor FAT" | select-string "PASS"  | Select-Object -Last 1)
[bool]($storyboard | Select-String "BEC Interlock FAT" | select-string "PASS"  | Select-Object -Last 1)
$storyboard | Select-String "Bring Up: Gel Antenna" | Select-Object -Last 1
$storyboard | Select-String "Syringe Stallout FAT" | Select-Object -Last 1
$storyboard | Select-String "Mezzboard FAT" | Select-Object -Last 1
    
$storyboard | Select-String "Piezo FAT" | Select-Object -Last 1
$storyboard | Select-String "HV FAT" | Select-Object -Last 1
$storyboard | Select-String "Laser FAT" | Select-Object -Last 1
$storyboard | Select-String "Bring Up: Verify Raman" | Select-Object -Last 1

$storyboard | Select-String "Bring Up: Water Prime" | Select-Object -Last 1
$storyboard | Select-String "Plug detected" | Select-Object -Last 1
$storyboard | Select-String "Bring Up: Lysis Prime" | Select-Object -Last 1
$storyboard | Select-String "Bring Up: Buffer Prime" | Select-Object -Last 1
$storyboard | Select-String "Bring Up: Lysis Dispense Test" | Select-Object -Last 1
$storyboard | Select-String "Lysis Volume" | Select-Object -Last 1
$storyboard | Select-String "Bring Up: Lysate Pull" | Select-Object -Last 1
$storyboard | Select-String "Bring Up: Capillary Gel Prime" | Select-Object -Last 1

# Bolus tests  ([0-9]{1,3}\.\d\d[s])
$MTSS_Bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Bolus Devliery Test" | select-string "PASS"
$MTSS_Bolus
Write-host Passed Bolus test count: $MTSS_Bolus.count