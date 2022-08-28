$storyboard       = Get-ChildItem "$serverdir" -I storyboard*.* -R 
$MachineConfigXML = Get-ChildItem "$serverdir" -I MachineConfig.xml -R
$TC_CalibrationXML= Get-Childitem "$serverdir" -I TC_Calibration.xml -R 
$SampleQuality    = Get-ChildItem "$serverdir" -I SampleQuality.txt -R
$DannoGUIStateXML = Get-ChildItem "$serverdir" -I DannoGUIState.xml -R
$ExecutionLOG     = Get-ChildItem "$serverdir" -I execution.log -R
$GM_Analysis_PeakTable = Get-ChildItem "$serverdir" -I GM_Analysis_PeakTable.txt -R
$DxCodeXML        = Get-ChildItem "$serverdir" -I DxCode.xml -R
$MachineName = ($storyboard | Select-String "MachineName" | Select-Object -Last 1).Line.Split(":").TrimStart() | Select-Object -Last 1
Write-Host "[ RapidHIT ID] : Running query on Instrument $MachineName run data for result..." -ForegroundColor Magenta
# add check machine name first, last from log and compare with $env:computername
# convert everything to functios, execute only if condition is true

$Optics       = "[ Optics     ]" ; $PCBA         = "[ PCBA       ]" ; $Raman_Bkg    = "[ Raman Bkg  ]" 
$Heater       = "[ Heater     ]" ; $SCI          = "[ SCI        ]" ; $MachineConf  = "[MachineConf.]"
$Ambient      = "[ Ambient_Sr ]" ; $Gel_Cooler   = "[ Gel Cooler ]" ; $TC_Cal       = "[ TC_Cal     ]"
$Full_Run     = "[ Full-Run   ]" ; $SCI_Cal      = "[ SCI_Cal    ]"
$Bolus        = "[ Bolus      ]" ; $WetTest      = "[ Wet Test   ]" ; $BEC_Status   = "[ BEC_Status ]"
$BoxPrep      = "[ BoxPrep    ]" ; $HIDAutolite  = "[ HIDAutolite]" ; $Prime        = "[ PrimeStatus]"
$USB_Temp     = "[ Temp Sensor]" ; $USB_Humi     = "[ Humi Sensor]" ; $Laser        = "[ Laser      ]" 
$SHP_BEC      = "[Shipping BEC]" ; $Error_msg    = "[ Error! ]"     ; $SyringePump  = "[ SyringePump]"
$Anode_Motor  = "[Anode Motor ]" ; $Gel_RFID     = "[ Gel_RFID   ]" ; $BEC_Itlck    = "[ BEC_Intlck ]"
$HP_FAT       = "[ HP FAT     ]" ; $Syrg_Pmp     = "[Syringe Pump]" ; $Piezo        = "[ Piezo      ]"
$LP_FAT       = "[ LP FAT     ]" ; $HV           = "[ HV         ]" 
$Mezz_PCBA    = "[ MEZZ test  ]" ; $DXCODE_Str   = "[ DXcode     ]"
$Laser        = "[ Laser      ]" ; $BEC_Insertion= "[BECInsertion]"
$Test_Failed = ": Test FAILED"  ; $Test_Passed = ": Test PASSED"  ; $Test_NA = ": Test N/A"

$RHID_Firmware79 = "1001.4.79"
$File_not_Found = "Not found or no full run has been performed"
$File_found     = "Files found in Remote folders"

$USB_Temp_RD                = " Last 3 Runs end Ambient  reading in °C"
$USB_Humi_RD                = " Last 3 Runs end Humidity reading in  %"
$Bolus_Test_count_Str       = "                Passed Bolus test count"
$Machine_Config_Str         = "                  Machine Configuration"
$SyringePump_Cal            = "  Syringe Pump Calibration in m/s and %"
$Blue_Background_Str        = "                        Blue_Background"
$SCI_Calibration            = "                        SCI Calibration"
$Bec_Status_Str             = "  BEC Insertion, Gel Purge, LastGelFill"
$Prime_Status               = "               Lysis/Water Prime Status"
$Laser_Hour                 = "                             Laser Hour"
$RHID_TC_Calibration_Str    = "               Thermocycler Calibration"
$RHID_QMini_str             = "                   Q-mini serial number"
$RHID_Coeff_Str             = "  Coefficients"
$RHID_Infl_Str              = "                       Inflection Point"
$RHID_Mainboard_str         = "            Main board firmware version"
$RHID_Mezzbaord_str         = "            Mezz board firmware version"
$RHID_HIDAutolite_Trial     = "             HIDAutolite License Status"
$RHID_Anode_Motor_Str       = "                        Anode Motor FAT"
$RHID_Lysis_Heater_str      = "                       Lysis Heater FAT"
$RHID_DN_Heater_str         = "                                 DN FAT"
$RHID_PCR_Heater_str        = "                                PCR FAT"
$RHID_Optics_Heater_str     = "                      Optics Heater FAT"
$RHID_Gel_Cooler_str        = "                        Gel Cooling FAT"
$RHID_Ambient_str           = "                            Ambient FAT"
$RHID_CAM_FAT_str           = "                                CAM FAT"
$RHID_SCI_Insertion_FAT_Str = "                      SCI Insertion FAT"
$RHID_FRONT_END_FAT_Str     = "                          FRONT END FAT"
$RHID_FE_Motor_Calibration_Str = "         Bring Up: FE Motor Calibration"
$RHID_FE_Motor_Test_Str     = "         Bring Up:        FE Motor Test"
$RHID_Homing_Error_Test_Str = "         Bring Up:    Homing Error Test"
$RHID_FL_Homing_Error_wCAM_Test_Str = "   Bring Up: FL Homing Error w/CAM Test"
$RHID_SCI_Antenna_Test_Str  = "         Bring Up:     SCI Antenna Test"
$RHID_Mezz_Test_Str         = "                              MEZZ test"
$RHID_HP_FAT_Str            = "                                 HP FAT"
$RHID_LP_FAT_Str            = "                                 LP FAT"
$BEC_Interlock_FAT_Str      = "                      BEC Interlock FAT"
$RHID_Gel_Antenna_Str_LOW   = "         Bring Up:   Gel Antenna -  LOW"
$RHID_Gel_Antenna_Str_HIGH  = "         Bring Up:   Gel Antenna - HIGH"
$RHID_Syringe_Stallout_FAT_Str = "                   Syringe Stallout FAT"
$RHID_Mezzboard_FAT_STR     = "                          Mezzboard FAT"
$RHID_Water_Prime_Str       = "         Bring Up:          Water Prime"
$RHID_Lysis_Prime_Str       = "         Bring Up:          Lysis Prime"
$RHID_Verify_Raman_Str      = "         Bring Up:         Verify Raman"
$RHID_Buffer_Prime_Str      = "         Bring Up:   Buffe Buffer Prime"
$RHID_Lysis_Dispense_Str    = "         Bring Up:  Lysis Dispense Test"
$RHID_Lystate_Pull_Str      = "         Bring Up:          Lysate Pull"
$RHID_HV_FAT_Str            = "                                 HV FAT"
$RHID_Laser_FAT_Str         = "                              Laser FAT"
$RHID_Piezo_FAT_str         = "                              Piezo FAT"
$RHID_Capillary_Gel_Prime_Str = "         Bring Up:  Capillary Gel Prime"
$Danno_SS_Count             = "          Saved Danno Screenshots Count"
$Remote_Str                 = "     Remote $Drive\$MachineName\Internal\ Size" 
$Local_Str                  = "       Local Folder E:\RapidHIT ID Size" 
$HIDAutolite_Execution_Str  = "  Latest HIDAutolite Execution"
$RHID_HIDAutolite_Str       = "SoftGenetics License number provided is"

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

<#Bolus_Current,53.93
Bolus_Timing,15.8#>

IF ([Bool]$RHID_QMini_SN -eq "True") {
    $RHID_QMini_SN_Filter = $RHID_QMini_SN.line.split(":").TrimStart() | Select-object -last 1
    Write-Host "$Optics : $RHID_QMini_str : $RHID_QMini_SN_Filter" -ForegroundColor Green}
    Else { Write-Host "$Optics : $RHID_QMini_str : Not Available" -ForegroundColor Yellow}

IF ([Bool]$RHID_QMini_Coeff -eq "True") {
    $RHID_QMini_Coeff_Filter = $RHID_QMini_Coeff.line.split(":").TrimStart() | Select-object -last 1
    Write-Host "$Optics : $RHID_Coeff_Str : $RHID_QMini_Coeff_Filter" -ForegroundColor Green}
    Else{ Write-Host "$Optics : $RHID_Coeff_Str : Not Available" -ForegroundColor Yellow}

IF ([Bool]$RHID_QMini_Infl -eq "True") {
    $RHID_QMini_Infl_Filter = $RHID_QMini_Infl.line.split(":").TrimStart() | Select-object -last 1
    Write-Host "$Optics : $RHID_Infl_Str : $RHID_QMini_Infl_Filter" -ForegroundColor Green }
    Else{ Write-Host "$Optics : $RHID_Infl_Str : Not Available" -ForegroundColor Yellow}

If ([Bool]($RHID_TC_Calibration | Select-String "NaN") -eq "True") {
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Uncalibrated" -ForegroundColor Yellow
    Write-Host "$TC_Cal :       WARNING: Unpopulated TC_Calibration.XML Found" -ForegroundColor RED
} elseif ($RHID_TC_Calibration.count -eq "0") {
    Write-Host "$TC_Cal :               WARNING: TC_Calibration.XML Not Found" -ForegroundColor RED
} else { 
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Calibrated" -ForegroundColor Green }

if ($RHID_MachineConfig_HW.count -eq "0") {
    Write-Host "$MachineConf :               WARNING: MachineConfig.XML Not Found" -ForegroundColor RED
}
Write-Host "$MachineConf : $Machine_Config_Str : $RHID_MachineConfig_HW" -ForegroundColor Green
Write-Host "$MachineConf : $Machine_Config_Str : $RHID_MachineConfig_HW2" -ForegroundColor Green
Write-Host "$SyringePump : $SyringePump_Cal : $RHID_MachineConfig_Syring" -ForegroundColor Green
If ([Bool]$RHID_MachineConfig_Blue -eq "True") {
    Write-Host "$Raman_Bkg : $Blue_Background_Str : Stashed" -ForegroundColor Green
} else {
    Write-Host "$Raman_Bkg : $Blue_Background_Str : N/A" -ForegroundColor Yellow }

If ([Bool]$RHID_MachineConfig_SCI -eq "True") {
    Write-Host "$SCI_Cal : $SCI_Calibration : $RHID_MachineConfig_SCI mm" -ForegroundColor Green }
    Else {Write-Host $SCI_Cal : $SCI_Calibration : Uncalibrated -ForegroundColor Red}

If ([Bool]$RHID_MachineConfig_BEC -eq "True") {
Write-Host "$BEC_Status : $Bec_Status_Str : $RHID_MachineConfig_BEC" -ForegroundColor Green }

If ([Bool]$RHID_MachineConfig_Prime -eq "True") {
Write-Host "$Prime : $Prime_Status : $RHID_MachineConfig_Prime" -ForegroundColor Green }

Write-Host "$Laser : $Laser_Hour : $RHID_MachineConfig_Laser" -ForegroundColor Green
if ("$RHID_Mainboard_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mainboard_str : $RHID_Mainboard_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "$PCBA : $Error_msg $RHID_Mainboard_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red }
if ("$RHID_Mezzbaord_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mezzbaord_str : $RHID_Mezzbaord_FW_Ver" -ForegroundColor Green }
else {  
    Write-Host "$PCBA : $Error_msg $RHID_Mezzbaord_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red } 

IF ([Bool]$RHID_ExecutionLOG -eq "True") {
    $RHID_GM_Analysis_PeakTable_Filter = $RHID_GM_Analysis_PeakTable.line
    $RHID_ExecutionLOG_Filter = $RHID_ExecutionLOG.Line.Split("-").TrimStart() | Select-Object -Last 1
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : $RHID_ExecutionLOG_Filter"
    Write-Host "$HIDAutolite : $HIDAutolite_Execution_Str $RHID_GM_Analysis_PeakTable_Filter "
} Else { Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : Undetected or EXPIRED" -ForegroundColor Red }

$RHID_Lysis_Heater_FAT  = $storyboard | Select-String "Lysis Heater FAT"  | Select-Object -Last 1
$RHID_DN_Heater_FAT     = $storyboard | Select-String "DN FAT"            | Select-Object -Last 1
$RHID_PCR_Heater_FAT    = $storyboard | Select-String "PCR FAT"           | Select-Object -Last 1
$RHID_Optics_Heater_FAT = $storyboard | Select-String "Optics Heater FAT" | Select-Object -Last 1

if (($RHID_Lysis_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysis_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Failed" -ForegroundColor Red    }

if (($RHID_DN_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_DN_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_Failed"  -ForegroundColor Red    }

if (($RHID_PCR_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_PCR_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_Passed" -ForegroundColor Green  }
else {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Optics_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Optics_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_Failed" -ForegroundColor Red    }

# Mainboard tests
$RHID_Gel_Cooler_FAT = $storyboard | Select-String "Gel Cooling FAT" | Select-Object -Last 1
$RHID_Ambient_FAT    = $storyboard | Select-String "Ambient FAT"     | Select-Object -Last 1

if (($RHID_Gel_Cooler_FAT).count -eq "") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Gel_Cooler_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_Failed" -ForegroundColor Red    }
if (($RHID_Ambient_FAT).count -eq "") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Ambient_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_Failed" -ForegroundColor Red    }

# SCI tests
$RHID_CAM_FAT     = ($storyboard | Select-String "CAM FAT" | Select-Object -Last 1)
if (($RHID_CAM_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_CAM_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_Failed" -ForegroundColor Red    }

$RHID_SCI_Insertion_FAT = ($storyboard | Select-String "SCI Insertion FAT" | Select-Object -Last 1)
if (($RHID_SCI_Insertion_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_SCI_Insertion_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_Failed" -ForegroundColor Red    }

$RHID_FRONT_END_FAT = ($storyboard | Select-String "FRONT END FAT" | Select-Object -Last 1)
if (($RHID_FRONT_END_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_FRONT_END_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_Failed" -ForegroundColor Red    }
$RHID_FE_Motor_Calibration  = ($storyboard | Select-String "Bring Up: FE Motor Calibration" | Select-Object -Last 1)
if (($RHID_FE_Motor_Calibration).count -eq "") {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_FE_Motor_Calibration | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_Failed" -ForegroundColor Red    }
$RHID_FE_Motor_Test = ($storyboard | Select-String "Bring Up: FE Motor Test" | Select-Object -Last 1)
if (($RHID_FE_Motor_Test).count -eq "") {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_FE_Motor_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_Failed" -ForegroundColor Red    }
$RHID_Homing_Error_Test = ($storyboard | Select-String "Bring Up: Homing Error Test" | Select-Object -Last 1)
if (($RHID_Homing_Error_Test).count -eq "") {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Homing_Error_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_Failed" -ForegroundColor Red    }
$RHID_FL_Homing_Error_wCAM_Test = ($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | Select-Object -Last 1)
if (($RHID_FL_Homing_Error_wCAM_Test).count -eq "") {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_FL_Homing_Error_wCAM_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_Failed" -ForegroundColor Red    }
$RHID_SCI_Antenna_Test = ($storyboard | Select-String "Bring Up: SCI Antenna Test" | Select-Object -Last 1)
if (($RHID_SCI_Antenna_Test).count -eq "") {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_SCI_Antenna_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Mezz_test = $storyboard | Select-String "MEZZ test" | Select-Object -Last 1
if (($RHID_Mezz_test).count -eq "") {
    Write-Host "$Mezz_PCBA : $RHID_Mezz_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Mezz_test | Select-String "Pass") -eq "True") {
    Write-Host "$Mezz_PCBA : $RHID_Mezz_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Mezz_PCBA : $RHID_Mezz_Test_Str $Test_Failed" -ForegroundColor Red    }
$RHID_HP_FAT    = $storyboard | Select-String "HP FAT"    | Select-Object -Last 1
if (($RHID_HP_FAT).count -eq "") {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_HP_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_Failed" -ForegroundColor Red    }
$RHID_LP_FAT    = $storyboard | Select-String "LP FAT"    | Select-Object -Last 1
if (($RHID_LP_FAT).count -eq "") {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_LP_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Anode_Motor_FAT = $storyboard | Select-String "Anode Motor FAT" | Select-Object -Last 1
if (($RHID_Anode_Motor_FAT).count -eq "") {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Anode_Motor_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_Failed" -ForegroundColor Red    }

$RHID_BEC_Interlock_FAT = ($storyboard | Select-String "BEC Interlock FAT" | Select-Object -Last 1)
if (($RHID_BEC_Interlock_FAT).count -eq "") {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_BEC_Interlock_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Gel_Antenna_LOW   = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "Low" | Select-Object -Last 1)
if (($RHID_Gel_Antenna_LOW).count -eq "") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Gel_Antenna_LOW | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_Failed" -ForegroundColor Red    }
$RHID_Gel_Antenna_HIGH  = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "High"  | Select-Object -Last 1)
if (($RHID_Gel_Antenna_HIGH).count -eq "") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Gel_Antenna_HIGH | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_Failed" -ForegroundColor Red    }

$RHID_Syringe_Stallout_FAT  = ($storyboard | Select-String "Syringe Stallout FAT" | Select-Object -Last 1)
if (($RHID_Syringe_Stallout_FAT).count -eq "") {
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Syringe_Stallout_FAT | Select-String "Pass") -eq "True") {
    $RHID_Syringe_MIN_CURRENT   = ($storyboard | Select-String "Min Current"       | Select-Object -Last 1).line.split(",").TrimStart()| Select-Object -Last 1
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_Passed " -ForegroundColor Green
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str : $RHID_Syringe_MIN_CURRENT" -ForegroundColor Cyan 
} else {
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_Failed : $RHID_Syringe_MIN_CURRENT" -ForegroundColor Red    }

$RHID_Mezzboard_FAT         = ($storyboard | Select-String "Mezzboard FAT"|  Select-Object -Last 1)
if (($RHID_Mezzboard_FAT).count -eq "") {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Mezzboard_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_Failed" -ForegroundColor Red    }

$RHID_BEC_Reinsert_First    = ($storyboard | Select-String "BEC Reinsert completed" | Select-Object -First 1) #First BEC Insertion
If ([Bool]$RHID_BEC_Reinsert_First -eq "True") {
    $RHID_Gel_Void_First = ($storyboard | Select-String "Estimated gel void volume" | Select-Object -First 1).line.split("=").TrimStart() | Select-Object -Last 1
    Write-host "$BEC_Insertion :                  Cover-Off BEC Reinsert : Completed"
    Write-host "$BEC_Insertion :         First Estimated Gel Void Volume : $RHID_Gel_Void_First" -ForegroundColor Cyan}
    Else {
    Write-host "$BEC_Insertion :                 Cover-Off BEC Insertion : N/A" -ForegroundColor Yellow}

$RHID_Piezo_FAT = ($storyboard | Select-String "Piezo FAT" | Select-Object -Last 1)
if (($RHID_Piezo_FAT).count -eq "") {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Piezo_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_Failed" -ForegroundColor Red    }
$RHID_HV_FAT    = ($storyboard | Select-String "HV FAT" | Select-Object -Last 1)
if (($RHID_HV_FAT).count -eq "") {
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_HV_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_Passed" -ForegroundColor Green}
else {
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_Failed" -ForegroundColor Red    }
$RHID_Laser_FAT = ($storyboard | Select-String "Laser FAT" | Select-Object -Last 1)
if (($RHID_Laser_FAT).count -eq "") {
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Laser_FAT | Select-String "Pass") -eq "True") {
    $RHID_Raman_Signal = ($storyboard | Select-String "Raman =").Line.Split("=").TrimStart() | Select-Object -Last 1
    $RHID_Raman_Bin = ($storyboard | Select-String "Bin =").Line.Split("=").TrimStart() | Select-Object -Last 1
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$Laser :                Raman = $RHID_Raman_Signal ; Bin = $RHID_Raman_Bin" -ForegroundColor Green
}
else {
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Water_Prime      = ($storyboard | Select-String "Bring Up: Water Prime" | Select-Object -Last 1)
if (($RHID_Water_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_NA" -ForegroundColor Yellow }
elseif ([bool] ($RHID_Water_Prime | Select-String "Pass") -eq "True") {
    $RHID_Water_Prime_Plug = ($storyboard | Select-String "Plug detected" | Select-Object -Last 1).line.split(",").TrimStart() | Select-Object -Last 2 | Select-Object -SkipLast 1
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$WetTest :          $RHID_Water_Prime_Plug" -ForegroundColor Cyan }
else {
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Lysis_Prime    = ($storyboard | Select-String "Bring Up: Lysis Prime" | Select-Object -Last 1)
if (($RHID_Lysis_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysis_Prime | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Buffer_Prime   = ($storyboard | Select-String "Bring Up: Buffer Prime" |  Select-Object -Last 1)
if (($RHID_Buffer_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Buffer_Prime | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Lysis_Dispense = ($storyboard | Select-String "Bring Up: Lysis Dispense Test"| Select-Object -Last 1)
if (($RHID_Lysis_Dispense).count -eq "") {
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysis_Dispense | Select-String "Pass") -eq "True") {
    $RHID_Lysis_Dispense_Volume = ($storyboard | Select-String "Lysis Volume ="  | Select-Object -Last 1).line.split("=").TrimStart() | Select-object -last 1
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str : $RHID_Lysis_Dispense_Volume" -ForegroundColor Cyan }
else {
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Lysate_Pull = ($storyboard | Select-String "Bring Up: Lysate Pull" | Select-Object -Last 1)
if (($RHID_Lysate_Pull).count -eq "") {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysate_Pull | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Capillary_Gel_Prime = ($storyboard | Select-String "Bring Up: Capillary Gel Prime" | Select-Object -Last 1)
if (($RHID_Capillary_Gel_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Capillary_Gel_Prime | Select-String "Completed") -eq "True") {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str : Completed" -ForegroundColor Green }
else {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Raman = ($storyboard | Select-String "Bring Up: Verify Raman"  | Select-Object -Last 1)
if (($RHID_Raman).count -eq "") {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Raman | Select-String "Pass") -eq "True") {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_Passed" -ForegroundColor Green
}
else {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Bolus = Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Bolus Devliery Test" 
Write-host "$Bolus : $Bolus_Test_count_Str" : ($RHID_Bolus | select-string "PASS").count -ForegroundColor Green

$RHID_BEC_Reinsert = (Get-ChildItem "$serverdir\*BEC Insertion BEC_*" -I storyboard*.* -R  | Select-String "BEC Reinsert completed"    | Select-Object -Last 1) #Cover-on BEC Insertion 
IF ([Bool]$RHID_BEC_Reinsert -eq "True") {
    $RHID_Gel_Void = ($storyboard | Select-String "Estimated gel void volume" | Select-object -last 1).line.split("=").TrimStart() | Select-Object -Last 1
    Write-host "$BEC_Insertion :                   Cover-On BEC Reinsert : Completed"
    Write-host "$BEC_Insertion :          Last Estimated Gel Void Volume : $RHID_Gel_Void" -ForegroundColor Cyan 
}
Else {
    Write-host "$BEC_Insertion :                  Cover-On BEC Insertion : N/A" -ForegroundColor Yellow }

$GM_ILS_Score_GFE_36cycles   = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-300uL-36cycles") | Select-Object -Last 1
$GM_ILS_Score_GFE_BV  = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-BV") | Select-Object -Last 1
$GM_ILS_Score_Allelic_Ladder = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__Ladder.fsa") | Select-Object -Last 1
$GM_ILS_Score_GFE_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE_007") | Select-Object -Last 1
$GM_ILS_Score_NGM_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__NGM") | Select-Object -Last 1
$GM_ILS_Score_BLANK   = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__BLANK")| Select-Object -Last 1

$GFE_36cycles_Trace_Str   = "[1]    GFE_36cycles Trace Quality Score" ; $GFE_BV_Trace_Str         = "[2] Cover-Off Blank Trace Quality Score"
$Allelic_Ladder_Trace_Str = "[3]  Allelic Ladder Trace Quality Score" ; $GFE_007_Trace_Str        = "[4]         GFE_007 Trace Quality Score"
$NGM_007_Trace_Str        = "[5]         NGM_007 Trace Quality Score" ; $BLANK_Trace_Str          = "[6]           BLANK Trace Quality Score"
$GM_ILS           = "[ GeneMarker ]" ; $SampleName       = "[ Sample Name]"
$Cartridge_Type   = "[ Ctrg. Type ]" ; $Protocol_Setting = "[ Protocol   ]"
$Cartridge_ID     = "[ Ctrg. Lot  ]" ; $Run_Type         = "[ Run Type   ]"
$RHID_BEC_ID = "BEC_ID"
$RHID_Bolus_Timing = "Bolus_Timing"

IF ([BOOL]$GM_ILS_Score_GFE_36cycles -eq "True") {
    $GM_ILS_Score_GFE_36cycles_Score = $GM_ILS_Score_GFE_36cycles.Line.Split("	") | Select-Object -Last 1
    $DxCode2 = Get-ChildItem "$serverdir\*GFE-300uL-36cycles*"  -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem "$serverdir\*GFE-300uL-36cycles*" -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_36cycles_Trace_Str : $GM_ILS_Score_GFE_36cycles_Score $DxCode2" -ForegroundColor Green
    "$SampleName : $RHID_SampleName"
    Write-Host "$Cartridge_Type : $RHID_Cartridge_Type ; $Cartridge_ID : $RHID_Cartridge_ID" -ForegroundColor Cyan
    "$Protocol_Setting : $RHID_Protocol_Setting ; $Run_Type : $RHID_RunType"
}
Else {Write-Host "$GM_ILS : $GFE_36cycles_Trace_Str : N/A" -ForegroundColor Yellow}

IF ([BOOL]$GM_ILS_Score_GFE_BV -eq "True") {
    $DxCode2 = Get-ChildItem "$serverdir\*GFE-BV_*"  -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem "$serverdir\*GFE-BV_*" -I RunSummary.csv -R
    $GM_ILS_Score_GFE_BV_Score = $GM_ILS_Score_GFE_BV.Line.Split("	") | Select-Object -Last 1
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_BV_Trace_Str : $GM_ILS_Score_GFE_BV_Score $DxCode2"-ForegroundColor Green
    "$SampleName : $RHID_SampleName"
    Write-Host "$Cartridge_Type : $RHID_Cartridge_Type ; $Cartridge_ID : $RHID_Cartridge_ID" -ForegroundColor Cyan
    "$Protocol_Setting : $RHID_Protocol_Setting ; $Run_Type : $RHID_RunType"
}
Else { Write-Host "$GM_ILS : $GFE_BV_Trace_Str : N/A" -ForegroundColor Yellow }

IF ([BOOL]$GM_ILS_Score_Allelic_Ladder -eq "True") {
    $GM_ILS_Score_Allelic_Ladder_Score = $GM_ILS_Score_Allelic_Ladder.Line.Split("	") | Select-Object -Last 1
    $RunSummaryCSV = Get-ChildItem "$serverdir\*GFE-BV Allelic Ladder*" -I RunSummary.csv -R
    $DxCode2 = Get-ChildItem "$serverdir\*GFE-BV Allelic Ladder*"  -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $Allelic_Ladder_Trace_Str : $GM_ILS_Score_Allelic_Ladder_Score $DxCode2"-ForegroundColor Green
    "$SampleName : N/A"
    Write-Host "$Cartridge_Type : $RHID_Cartridge_Type ; $Cartridge_ID : $RHID_Cartridge_ID" -ForegroundColor Cyan
    "$Protocol_Setting : $RHID_Protocol_Setting ; $Run_Type : $RHID_RunType"
}
Else { Write-Host "$GM_ILS : $Allelic_Ladder_Trace_Str : N/A" -ForegroundColor Yellow }

IF ([BOOL]$GM_ILS_Score_GFE_007 -eq "True") {
    $GM_ILS_Score_GFE_007_Score = $GM_ILS_Score_GFE_007.Line.Split("	") | Select-Object -Last 1
    $DxCode2 = Get-ChildItem "$serverdir\*GFE_007*"  -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem "$serverdir\*GFE_007*" -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_007_Trace_Str : $GM_ILS_Score_GFE_007_Score $DxCode2" -ForegroundColor Green
    "$SampleName : $RHID_SampleName"
    Write-Host "$Cartridge_Type : $RHID_Cartridge_Type ; $Cartridge_ID : $RHID_Cartridge_ID" -ForegroundColor Cyan
    "$Protocol_Setting : $RHID_Protocol_Setting ; $Run_Type : $RHID_RunType"
}
Else { Write-Host "$GM_ILS : $GFE_007_Trace_Str : N/A" -ForegroundColor Yellow }

IF ([BOOL]$GM_ILS_Score_NGM_007 -eq "True") {
    $GM_ILS_Score_NGM_007_Score = $GM_ILS_Score_NGM_007.Line.Split("	") | Select-Object -Last 1
    $DxCode2 = Get-ChildItem "$serverdir\*NGM_007*"  -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem "$serverdir\*NGM_007*" -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $NGM_007_Trace_Str : $GM_ILS_Score_NGM_007_Score $DxCode2" -ForegroundColor Green
    "$SampleName : $RHID_SampleName"
    Write-Host "$Cartridge_Type : $RHID_Cartridge_Type ; $Cartridge_ID : $RHID_Cartridge_ID" -ForegroundColor Cyan
    "$Protocol_Setting : $RHID_Protocol_Setting ; $Run_Type : $RHID_RunType"
}
Else { Write-Host "$GM_ILS : $NGM_007_Trace_Str : N/A" -ForegroundColor Yellow }

IF ([BOOL]$GM_ILS_Score_BLANK -eq "True") {
    $GM_ILS_Score_BLANK_Score = $GM_ILS_Score_BLANK.Line.Split("	") | Select-Object -Last 1
    $DxCode2 = Get-ChildItem "$serverdir\*BLANK*"  -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem "$serverdir\*BLANK*" -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $BLANK_Trace_Str : $GM_ILS_Score_BLANK_Score $DxCode2" -ForegroundColor Green
    "$SampleName : $RHID_SampleName"
    Write-Host "$Cartridge_Type : $RHID_Cartridge_Type ; $Cartridge_ID : $RHID_Cartridge_ID" -ForegroundColor Cyan
    "$Protocol_Setting : $RHID_Protocol_Setting ; $Run_Type : $RHID_RunType"
}
Else { Write-Host "$GM_ILS : $BLANK_Trace_Str : N/A" -ForegroundColor Yellow }


$StatusData_leaf = Get-ChildItem $Drive\$MachineName -I $StatusData  -R | Test-path -PathType Leaf
$GM_Analysis_leaf = Get-ChildItem $Drive\$MachineName -I $GM_Analysis -R | Test-path -PathType Leaf

if ([Bool] ($StatusData_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_StatusData_PDF = Get-ChildItem -path "$Drive\$MachineName" -I $StatusData -R |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "$Full_Run : $StatusData $File_found" -ForegroundColor Green
    $RHID_StatusData_PDF
    } else {
    Write-host "$Full_Run : $StatusData $File_not_Found" -ForegroundColor yellow }

if ([Bool] ($GM_Analysis_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_GM_Analysis = Get-ChildItem -path "$Drive\$MachineName" -I $GM_Analysis -R |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "$Full_Run : $GM_Analysis $File_found" -ForegroundColor Green
    $RHID_GM_Analysis }
    else {Write-host "$Full_Run : $GM_Analysis $File_not_Found" -ForegroundColor yellow }

$RHID_USB_Temp_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndAmbientTemperatureC" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
$RHID_USB_Humi_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndRelativeHumidityPercent" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
Write-Host "$USB_Temp : $USB_Temp_RD : $RHID_USB_Temp_Rdr" -ForegroundColor Blue
Write-Host "$USB_Humi : $USB_Humi_RD : $RHID_USB_Humi_Rdr" -ForegroundColor Blue

$RHID_Shipping_BEC = $storyboard | Select-String "Shipping BEC engaged"
if ([bool]$RHID_Shipping_BEC -eq "True") {
    Write-Host "$SHP_BEC :   BEC Insertion completed, Shipping BEC : Engaged" -ForegroundColor Green }
    else {
    Write-Host "$SHP_BEC :           Shipping BEC not yet inserted" -ForegroundColor Yellow }

$Remote = "{0:N4} GB" -f ((Get-ChildItem -force "$Drive\$MachineName\Internal\"  -Recurse -ErrorAction SilentlyContinue | Measure-Object Length -sum ).sum / 1Gb)
$Local  = "{0:N4} GB" -f ((Get-ChildItem -force "E:\RapidHIT ID"             -Recurse -ErrorAction SilentlyContinue | Measure-Object Length -sum ).sum / 1Gb)
$Local_Folder_Msg  = Write-Host "$boxPrep : $Local_Str : $Local"
$Remote_Folder_Msg = Write-Host "$boxPrep : $Remote_Str : $Remote"
<#If ($Remote -eq "0.0000 GB") {
        mkdir $Drive\$MachineName\Internal\
    Copy-Item -Force -Recurse -Exclude "System Volume Information", "*RECYCLE.BIN", "bootsqm.dat" "E:\*" -Destination $Drive\$MachineName\Internal\
    }#>
$Danno_Local_leaf = Test-Path -Path "$danno\$MachineName"
IF ($Danno_Local_leaf -eq "True") {
    $RHID_Danno_Path = "$danno\$MachineName"
    $RHID_HIDAutolite = (Get-ChildItem $RHID_Danno_Path -I *BoxPrepLog_RHID* -R  -Exclude "*.log" | Select-String $RHID_HIDAutolite_Str | Select-Object -Last 1).Line.Split(" ").TrimStart() | Select-Object -Last 1
    $RHID_BoxPrep_Scrshot = Get-ChildItem -Path $RHID_Danno_Path\Screenshots *.PNG
    Write-Host $BoxPrep : $Danno_SS_Count : $RHID_BoxPrep_Scrshot.Name.Count -ForegroundColor Green
    $Local_Folder_Msg
    $Remote_Folder_Msg
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Str : $RHID_HIDAutolite" -ForegroundColor Green
} Else {
    $Local_Folder_Msg
    $Remote_Folder_Msg
    Write-Host "$BoxPrep : Backup Instrument folder before Boxprep !!!" -ForegroundColor Red
    Write-Host "$BoxPrep : Boxprep not yet Initialized" -ForegroundColor Yellow
}
# $RHID_Bolus[2,3,4,5,6,7,8,9,0,1] (Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R |  select-string "Timing" | Select-Object -Last 1) ForEach-Object -MemberName Split -ArgumentList "." -ExpandProperty Line
#  $Bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Timing" |  Select-Object -ExpandProperty Line  | ForEach-Object -MemberName Split -ArgumentList "="