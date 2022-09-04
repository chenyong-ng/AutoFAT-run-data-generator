$RHID_QMini_SN          = ($storyboard | Select-String "Q-mini serial number" | Select-object -last 1)
$RHID_QMini_Coeff       = ($storyboard | Select-String "Coefficients" | Select-object -last 1)
$RHID_QMini_Infl        = ($storyboard | Select-String "Inflection Point" | Select-object -last 1)
$RHID_Mainboard_FW_Ver  = ($storyboard | Select-String "Main board firmware version" | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_Mezzbaord_FW_Ver  = ($storyboard | Select-String "Mezz board firmware version" | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_ExecutionLOG      = $ExecutionLOG | Select-String "Your trial has" | Select-object -last 1
$RHID_GM_Analysis_PeakTable = $GM_Analysis_PeakTable | Select-String "Date/Time:" | Select-object -last 1
$RHID_TC_Calibration    = $TC_CalibrationXML | Select-Xml -XPath "//Offsets" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HW     = $MachineConfigXML  | Select-Xml -XPath "//MachineName | //HWVersion" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HW2    = $MachineConfigXML  | Select-Xml -XPath "//MachineConfiguration | //DataServerUploadPath" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Syring = $MachineConfigXML  | Select-Xml -XPath "//SyringePumpResetCalibration_ms | //SyringePumpStallCurrent" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Blue   = $MachineConfigXML  | Select-Xml -XPath "//Signature" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_SCI    = $MachineConfigXML  | Select-Xml -XPath "//FluidicHomeOffset_mm | //PreMixHomeOffset_mm | //DiluentHomeOffset_mm"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_BEC    = $MachineConfigXML  | Select-Xml -XPath "//IsBECInsertion | //LastGelPurgeOK | //RunsSinceLastGelFill" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Prime  = $MachineConfigXML  | Select-Xml -XPath "//Water | //LysisBuffer"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Laser  = $MachineConfigXML  | Select-Xml -XPath "//LaserHours " | ForEach-Object { $_.node.InnerXML }

$RHID_FP_Sensor = (Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Select-String "TouchChip Fingerprint Coprocessor" )
$RHID_USB_HD_Camera = (Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Select-String "HD USB Camera" )

$RHID_Lysis_Heater_FAT  = $storyboard | Select-String "Lysis Heater FAT"  | Select-Object -Last 1
$RHID_DN_Heater_FAT     = $storyboard | Select-String "DN FAT"            | Select-Object -Last 1
$RHID_PCR_Heater_FAT    = $storyboard | Select-String "PCR FAT"           | Select-Object -Last 1
$RHID_Optics_Heater_FAT = $storyboard | Select-String "Optics Heater FAT" | Select-Object -Last 1

$RHID_Gel_Cooler_FAT = $storyboard | Select-String "Gel Cooling FAT" | Select-Object -Last 1
$RHID_Ambient_FAT    = $storyboard | Select-String "Ambient FAT"     | Select-Object -Last 1

$RHID_CAM_FAT = ($storyboard | Select-String "CAM FAT" | Select-Object -Last 1)
$RHID_SCI_Insertion_FAT = ($storyboard | Select-String "SCI Insertion FAT" | Select-Object -Last 1)
$RHID_FRONT_END_FAT = ($storyboard | Select-String "FRONT END FAT" | Select-Object -Last 1)
$RHID_FE_Motor_Calibration = ($storyboard | Select-String "Bring Up: FE Motor Calibration" | Select-Object -Last 1)
$RHID_FE_Motor_Test = ($storyboard | Select-String "Bring Up: FE Motor Test" | Select-Object -Last 1)
$RHID_Homing_Error_Test = ($storyboard | Select-String "Bring Up: Homing Error Test" | Select-Object -Last 1)
$RHID_FL_Homing_Error_wCAM_Test = ($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | Select-Object -Last 1)

$RHID_SCI_Antenna_Test = ($storyboard | Select-String "Bring Up: SCI Antenna Test" | Select-Object -Last 1)
$RHID_Mezz_test = $storyboard | Select-String "MEZZ test" | Select-Object -Last 1

$RHID_HP_FAT    = $storyboard | Select-String "HP FAT"    | Select-Object -Last 1
$RHID_LP_FAT    = $storyboard | Select-String "LP FAT"    | Select-Object -Last 1
$RHID_Anode_Motor_FAT = $storyboard | Select-String "Anode Motor FAT" | Select-Object -Last 1

$RHID_BEC_Interlock_FAT = ($storyboard | Select-String "BEC Interlock FAT" | Select-Object -Last 1)
$RHID_Gel_Antenna_LOW = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "Low" | Select-Object -Last 1)
$RHID_Gel_Antenna_HIGH = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "High"  | Select-Object -Last 1)
$RHID_Syringe_Stallout_FAT = ($storyboard | Select-String "Syringe Stallout FAT" | Select-Object -Last 1)
$RHID_Mezzboard_FAT = ($storyboard | Select-String "Mezzboard FAT" |  Select-Object -Last 1)

#First BEC Insertion
$RHID_BEC_Reinsert_First = ($storyboard | Select-String "BEC Reinsert completed" | Select-Object -First 1) 
$RHID_BEC_insert_ID = (Get-ChildItem "$serverdir\*BEC Insertion" -I storyboard*.* -R | Select-String "BEC EEPROM being detected")
$RHID_Piezo_FAT = ($storyboard | Select-String "Piezo FAT" | Select-Object -Last 1)
$RHID_HV_FAT = ($storyboard | Select-String "HV FAT" | Select-Object -Last 1)
$RHID_Laser_FAT = ($storyboard | Select-String "Laser FAT" | Select-Object -Last 1)

$RHID_Water_Prime    = ($storyboard | Select-String "Bring Up: Water Prime" | Select-Object -Last 1)
$RHID_Lysis_Prime    = ($storyboard | Select-String "Bring Up: Lysis Prime" | Select-Object -Last 1)
$RHID_Buffer_Prime   = ($storyboard | Select-String "Bring Up: Buffer Prime" |  Select-Object -Last 1)
$RHID_Lysis_Dispense = ($storyboard | Select-String "Bring Up: Lysis Dispense Test" | Select-Object -Last 1)
$RHID_Lysate_Pull = ($storyboard | Select-String "Bring Up: Lysate Pull" | Select-Object -Last 1)
$RHID_Capillary_Gel_Prime = ($storyboard | Select-String "Bring Up: Capillary Gel Prime" | Select-Object -Last 1)
$RHID_Raman = ($storyboard | Select-String "Bring Up: Verify Raman"  | Select-Object -Last 1)
#Cover-on BEC Insertion
$RHID_BEC_Reinsert = ( $CoverOn_BEC_Reinsert | Select-String "BEC Reinsert completed" | Select-Object -Last 1) 
$RHID_BEC_Reinsert_ID = ( $CoverOn_BEC_Reinsert | Select-String "BEC ID" | Select-Object -Last 1)

$GM_ILS_Score_GFE_36cycles   = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-300uL-36cycles") | Select-Object -Last 1
$GM_ILS_Score_GFE_BV  = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-BV") | Select-Object -Last 1
$GM_ILS_Score_Allelic_Ladder = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__Ladder.fsa") | Select-Object -Last 1
$GM_ILS_Score_GFE_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE_007") | Select-Object -Last 1
$GM_ILS_Score_NGM_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__NGM") | Select-Object -Last 1
$GM_ILS_Score_BLANK   = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__BLANK")| Select-Object -Last 1

If ([Bool]$MachineName -eq "True") {
$StatusData_leaf = Get-ChildItem $Drive\$MachineName -I $StatusData  -R | Test-path -PathType Leaf
$GM_Analysis_leaf = Get-ChildItem $Drive\$MachineName -I $GM_Analysis -R | Test-path -PathType Leaf
}

$RHID_USB_Temp_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndAmbientTemperatureC" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
$RHID_USB_Humi_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndRelativeHumidityPercent" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3