# Heater tests
Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "Lysis Heater FAT"  | Select-Object -Last 1
Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "DN FAT"            | Select-Object -Last 1
Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "PCR FAT"           | Select-Object -Last 1 
Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "Optics Heater FAT" | Select-Object -Last 1

# Mainboard tests
"Gel Cooling FAT", "Ambient FAT"

# SCI tests
"SCI Sensor/CAM FAT", "FRONT END FAT", "Bring Up: FE Motor Calibration",
"Bring Up: FE Motor Test", "Bring Up: Homing Error Test", "Bring Up: FL Homing Error w/CAM Test", "SCI Antenna Test"

# Mezzboard Motor

# Mezz sensors

# RFIDs

# Laser

# Wet tests

# Bolus tests 
