$storyboard = Get-ChildItem "$serverdir" -I storyboard*.* -R 

$storyboard | Select-String "Q-mini serial number" | Select-Object -Last 1
$storyboard | Select-String "Main board firmware version" | Select-Object -Last 1
$storyboard | Select-String "Mezz board firmware version" | Select-Object -Last 1

# Heater tests
[bool]$storyboard | Select-String "Lysis Heater FAT"  | Select-Object -Last 1
$storyboard | Select-String "DN FAT"            | Select-Object -Last 1
$storyboard | Select-String "PCR FAT"           | Select-Object -Last 1 
$storyboard | Select-String "Optics Heater FAT" | Select-Object -Last 1

# Mainboard tests
$storyboard | Select-String "Gel Cooling FAT"   | Select-Object -Last 1
$storyboard | Select-String "Ambient FAT"       | Select-Object -Last 1

# SCI tests
$storyboard | Select-String "SCI Sensor/CAM FAT"             | Select-Object -Last 1
$storyboard | Select-String "FRONT END FAT"                  | Select-Object -Last 1
$storyboard | Select-String "Bring Up: FE Motor Calibration" | Select-Object -Last 1
$storyboard | Select-String "Bring Up: FE Motor Test"        | Select-Object -Last 1
$storyboard | Select-String "Bring Up: Homing Error Test"    | Select-Object -Last 1
$storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | Select-Object -Last 1
$storyboard | Select-String "SCI Antenna Test"               | Select-Object -Last 1

# Mezzboard Motor
$storyboard | Select-String "MEZZ test" | Select-Object -Last 1
$storyboard | Select-String "LP FAT" | Select-Object -Last 1
$storyboard | Select-String "HP FAT" | Select-Object -Last 1
$storyboard | Select-String "Anode Motor FAT" | Select-Object -Last 1
$storyboard | Select-String "BEC Interlock FAT" | Select-Object -Last 1
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