﻿$storyboard       = Get-ChildItem "$serverdir" -I storyboard*.* -R 
$MachineConfigXML = Get-ChildItem "$serverdir" -I MachineConfig.xml -R
$TC_CalibrationXML= Get-Childitem "$serverdir" -I TC_Calibration.xml -R 
$SampleQuality    = Get-ChildItem "$serverdir" -I SampleQuality.txt -R
$DannoGUIStateXML = Get-ChildItem "$serverdir" -I DannoGUIState.xml -R
$ExecutionLOG     = Get-ChildItem "$serverdir" -I execution.log -R
$GM_Analysis_PeakTable = Get-ChildItem "$serverdir" -I GM_Analysis_PeakTable.txt -R
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
$Mezz_PCBA    = "[ MEZZ test  ]"
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

$RHID_Lysis_Heater_FAT  = $storyboard | Select-String "Lysis Heater FAT"  | Select-Object -Last 1
$RHID_DN_Heater_FAT     = $storyboard | Select-String "DN FAT"            | Select-Object -Last 1
$RHID_PCR_Heater_FAT    = $storyboard | Select-String "PCR FAT"           | Select-Object -Last 1
$RHID_Optics_Heater_FAT = $storyboard | Select-String "Optics Heater FAT" | Select-Object -Last 1

$RHID_Gel_Cooler_FAT = $storyboard | Select-String "Gel Cooling FAT" | Select-Object -Last 1
$RHID_Ambient_FAT    = $storyboard | Select-String "Ambient FAT"     | Select-Object -Last 1

$GM_ILS_Score_GFE_36cycles   = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-300uL-36cycles") | Select-Object -Last 1
$GM_ILS_Score_GFE_BV  = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-BV") | Select-Object -Last 1
$GM_ILS_Score_Allelic_Ladder = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__Ladder.fsa") | Select-Object -Last 1
$GM_ILS_Score_GFE_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE_007") | Select-Object -Last 1
$GM_ILS_Score_NGM_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__NGM") | Select-Object -Last 1
$GM_ILS_Score_BLANK   = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__BLANK")| Select-Object -Last 1

$GFE_36cycles_Trace_Str   = "[1/1]        GFE_36cycles Trace Quality" ; $GFE_BV_Trace_Str         = "[1/2]     Cover-Off Blank Trace Quality"
$Allelic_Ladder_Trace_Str = "[1/3]      Allelic Ladder Trace Quality" ; $GFE_007_Trace_Str        = "[1/4]             GFE_007 Trace Quality"
$NGM_007_Trace_Str        = "[1/5]             NGM_007 Trace Quality" ; $BLANK_Trace_Str          = "[1/6]               BLANK Trace Quality"
$GM_ILS           = "[ GeneMarker ]" ; $SampleName       = "[ Sample Name]"
$Cartridge_Type   = "[ Ctrg. Info ]" ; $Protocol_Setting = "[ Protocol   ]"
$Bolus_Timing     = "[Bolus_Timing]" ; $Date_Time        = "[ Run Date   ]" 

If ([Bool]$MachineName -eq "True") {
$StatusData_leaf = Get-ChildItem $Drive\$MachineName -I $StatusData  -R | Test-path -PathType Leaf
$GM_Analysis_leaf = Get-ChildItem $Drive\$MachineName -I $GM_Analysis -R | Test-path -PathType Leaf
}

$RHID_USB_Temp_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndAmbientTemperatureC" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
$RHID_USB_Humi_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndRelativeHumidityPercent" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
