
"$Loading : Heaters textual filtering commands "
$RHID_Lysis_Heater_FAT      = $storyboard | Select-String "Lysis Heater FAT"
$RHID_DN_Heater_FAT         = $storyboard | Select-String "DN FAT"
$RHID_PCR_Heater_FAT        = $storyboard | Select-String "PCR FAT"
$RHID_Optics_Heater_FAT     = $storyboard | Select-String "Optics Heater FAT"

$RHID_Gel_Cooler_FAT        = $storyboard | Select-String "Gel Cooling FAT"
$RHID_Ambient_FAT           = $storyboard | Select-String "Ambient FAT"

"$Loading : SCI textual filtering commands "
$RHID_CAM_FAT               = ($storyboard | Select-String "CAM FAT" | Select-Object -Last 1)
$RHID_SCI_Insertion_FAT     = ($storyboard | Select-String "SCI Insertion FAT" | Select-Object -Last 1)
$RHID_FRONT_END_FAT         = ($storyboard | Select-String "FRONT END FAT" | Select-Object -Last 1)
$RHID_FE_Motor_Calibration  = ($storyboard | Select-String "Bring Up: FE Motor Calibration" | Select-Object -Last 1)
$RHID_FE_Motor_Test         = ($storyboard | Select-String "Bring Up: FE Motor Test" | Select-Object -Last 1)
$RHID_Homing_Error_Test     = ($storyboard | Select-String "Bring Up: Homing Error Test" | Select-Object -Last 1)
$RHID_FL_Homing_Error_wCAM_Test = ($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | Select-Object -Last 1)

$RHID_SCI_Antenna_Test      = ($storyboard | Select-String "Bring Up: SCI Antenna Test" | Select-Object -Last 1)
$RHID_Mezz_test             = $storyboard | Select-String "MEZZ test" | Select-Object -Last 1

"$Loading : MEZZ textual filtering commands "
$RHID_HP_FAT                = $storyboard | Select-String "HP FAT"    | Select-Object -Last 1
$RHID_LP_FAT                = $storyboard | Select-String "LP FAT"    | Select-Object -Last 1
$RHID_Anode_Motor_FAT       = $storyboard | Select-String "Anode Motor FAT" | Select-Object -Last 1

"$Loading : BEC textual filtering commands "
$RHID_BEC_Interlock_FAT     = ($storyboard | Select-String "BEC Interlock FAT" | Select-Object -Last 1)
$RHID_Gel_Antenna_LOW       = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "Low" | Select-Object -Last 1)
$RHID_Gel_Antenna_HIGH      = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "High"  | Select-Object -Last 1)
$RHID_Syringe_Stallout_FAT  = ($storyboard | Select-String "Syringe Stallout FAT" | Select-Object -Last 1)
$RHID_Mezzboard_FAT         = ($storyboard | Select-String "Mezzboard FAT" |  Select-Object -Last 1)

"$Loading : BEC Insertion textual filtering commands "
$RHID_BEC_Reinsert_First    = ($storyboard | Select-String "BEC Reinsert completed" | Select-Object -First 1) 
$RHID_BEC_insert_ID         = ($storyboard | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Select-String "BEC Insertion BEC_") | Select-Object -First 1
$RHID_Piezo_FAT             = ($storyboard | Select-String "Piezo FAT" | Select-Object -Last 1)
$RHID_HV_FAT                = ($storyboard | Select-String "HV FAT" | Select-Object -Last 1)
$RHID_Laser_FAT             = ($storyboard | Select-String "Laser FAT" | Select-Object -Last 1)
