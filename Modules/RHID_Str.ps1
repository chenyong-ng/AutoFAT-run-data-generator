﻿
# add check machine name first, last from log and compare with $env:computername
# convert everything to functios, execute only if condition is true
$Optics       = "[ Optics     ]" ; $PCBA         = "[ PCBA       ]" ; $Raman_Bkg    = "[ Raman Bkg  ]" ; $Info         = "[ Info       ]"
$Heater       = "[ Heater     ]" ; $SCI          = "[ SCI        ]" ; $MachineConf  = "[MachineConf.]" ; $System       = "[ System     ]"
$Ambient      = "[ Ambient_Sr ]" ; $Gel_Cooler   = "[ Gel Cooler ]" ; $TC_Cal       = "[ TC_Cal     ]" ; $TC_Offsets   = "[ TC Offsets ]"
$Full_Run     = "[ Full-Run   ]" ; $SCI_Cal      = "[ SCI_Cal    ]" ; $Verification = "[Verification]" ; $D = "DEBUG"
$Bolus        = "[ Bolus      ]" ; $WetTest      = "[ Wet Test   ]" ; $BEC_Status   = "[ BEC_Status ]" ; $Loading      = "[ Loading    ]"
$BoxPrep      = "[ BoxPrep    ]" ; $HIDAutolite  = "[ HIDAutolite]" ; $Prime        = "[ PrimeStatus]" ; $Searching    = "[ Searching  ]"
$USB_Temp     = "[ Temp Sensor]" ; $USB_Humi     = "[ Humi Sensor]" ; $Laser        = "[ Laser      ]" ; $Found        = "[ Found      ]"
$SHP_BEC      = "[Shipping BEC]" ; $Error_msg    = "[ Error! ]"     ; $SyringePump  = "[ SyringePump]" ; $Not_Available = "Not Available"
$Anode_Motor  = "[Anode Motor ]" ; $Gel_RFID     = "[ Gel_RFID   ]" ; $BEC_Itlck    = "[ BEC_Intlck ]" ; $Looping      = "[ Looping    ]"
$HP_FAT       = "[ HP FAT     ]" ; $Syrg_Pmp     = "[Syringe Pump]" ; $Piezo        = "[ Piezo      ]"
$LP_FAT       = "[ LP FAT     ]" ; $HV           = "[ HV         ]" ; $FP           = "[ FP Sensor  ]"
$Mezz_PCBA    = "[ MEZZ PCBA  ]" ; $MezzActuator = "[MezzActuator]" ; $Warning      = "[ Warning    ]" 
$Laser        = "[ Laser      ]" ; $BEC_Insertion= "[BECInsertion]" ; $HD_USB_CAM   = "[ HD USB CAM ]"
$Test_Failed  = ": Test FAILED"  ; $Test_Passed  = ": Test PASSED"  ; $Test_NA = ": Test N/A"

$RHID_Firmware79 = "1001.4.79"
$File_not_Found = "Not found or no full run has been performed"
$File_found     = "Files found in Remote folders"
$FP_Sensor_Str              = "        Authentec Biometric CoProcessor"
$HD_USB_CAM_Str             = "                          HD USB Camera"
$Operating_System           = " Operating System Version"
$Host_Name                  = "                              Host Name"

$Instrument_Serial          = "                      Instrument Serial"
$Hardware_Version           = "                       Hardware Version"
$SCI_Configuration          = "                      SCI Configuration"
$Data_Upload_Path           = "                       Data Upload Path"
$Syringe_Pump_Calibration   = "               Syringe Pump Calibration"
$PrimeWater_Status          = "                      PrimeWater Status"
$PrimeLysisBuffer           = "                PrimeLysisBuffer Status"

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
$RHID_Lysis_Heater_str      = "[01/41]                Lysis Heater FAT"
$RHID_DN_Heater_str         = "[02/41]                          DN FAT"
$RHID_PCR_Heater_str        = "[03/41]                         PCR FAT"
$RHID_Optics_Heater_str     = "[04/41]               Optics Heater FAT"
$RHID_Gel_Cooler_str        = "[05/41]                 Gel Cooling FAT"
$RHID_Ambient_str           = "[06/41]                     Ambient FAT"
$RHID_CAM_FAT_str           = "[07/41]                         CAM FAT"
$RHID_SCI_Insertion_FAT_Str = "[08/41]               SCI Insertion FAT"
$RHID_FRONT_END_FAT_Str     = "[09/41]                   FRONT END FAT"
$RHID_FE_Motor_Calibration_Str = "[10/41]  Bring Up: FE Motor Calibration"
$RHID_FE_Motor_Test_Str     = "[11/41]  Bring Up:        FE Motor Test"
$RHID_Homing_Error_Test_Str = "[12/41]  Bring Up:    Homing Error Test"
$RHID_FL_Homing_Error_wCAM_Test_Str = "[13/41]  Bring Up:FL Homing Error w/CAM"
$RHID_SCI_Antenna_Test_Str  = "[14/41]  Bring Up:     SCI Antenna Test"
$RHID_Mezz_Test_Str         = "[15/41]                       MEZZ test"
$RHID_HP_FAT_Str            = "[16/41]                          HP FAT"
$RHID_LP_FAT_Str            = "[17/41]                          LP FAT"
$RHID_Anode_Motor_Str       = "[18/41]                 Anode Motor FAT"
$BEC_Interlock_FAT_Str      = "[19/41]               BEC Interlock FAT"
$RHID_Gel_Antenna_Str_HIGH  = "[20/41]  Bring Up:   Gel Antenna - HIGH"
$RHID_Gel_Antenna_Str_LOW   = "[21/41]  Bring Up:   Gel Antenna -  LOW"
$RHID_Syringe_Stallout_FAT_Str ="[22/41]            Syringe Stallout FAT"
$RHID_Syringe_Cal           = "[23/41]        Syringe Pump Calibration"
$RHID_Mezzboard_FAT_STR     = "[24/41]                   Mezzboard FAT"
$RHID_CoverOff_BEC_Reinsert = "[25/41]          Cover-Off BEC Reinsert"
$RHID_First_Gel_Void        = "[26/41] First Estimated Gel Void Volume"
$RHID_Piezo_FAT_str         = "[27/41]                       Piezo FAT"
$RHID_HV_FAT_Str            = "[28/41]                          HV FAT"
$RHID_Laser_FAT_Str         = "[29/41]                       Laser FAT"
$RHID_Laser_Raman           = "[30/41]        Raman"
$RHID_Water_Prime_Str       = "[31/41]  Bring Up:          Water Prime"
$RHID_Lysis_Prime_Str       = "[33/41]  Bring Up:          Lysis Prime"
$RHID_Buffer_Prime_Str      = "[34/41]  Bring Up:   Buffe Buffer Prime"
$RHID_Lysis_Dispense_Str    = "[35/41]  Bring Up:  Lysis Dispense Test"
$RHID_Lystate_Pull_Str      = "[36/41]  Bring Up:          Lysate Pull"
$RHID_Capillary_Gel_Prime_Str = "[37/41]  Bring Up:  Capillary Gel Prime"
$RHID_Verify_Raman_Str      = "[38/41]  Bring Up:         Verify Raman"
$Bolus_Test_count_Str       = "[39/41]         Passed Bolus test Count"
$RHID_CoverOn_BEC_Reinsert  = "[40/41]           Cover-On BEC Reinsert"
$RHID_Last_Gel_Void         = "[41/41]  Last Estimated Gel Void Volume"
$Section_Separator          = "======================================================================================"
$Danno_SS_Count             = "          Saved Danno Screenshots Count"
$USB_Temp_RD                = " Last 3 Runs end Ambient  reading in °C"
$USB_Humi_RD                = " Last 3 Runs end Humidity reading in  %"
$Remote_Str                 = "     Remote $Drive\$MachineName\Internal\ Size" 
$Local_Str                  = "       Local Folder E:\RapidHIT ID Size" 
$HIDAutolite_Execution_Str  = "  Latest HIDAutolite Execution"
$RHID_HIDAutolite_Str       = "SoftGenetics License number provided is"

$GFE_36cycles_Trace_Str   = "[1/1]        GFE_36cycles Trace Quality" ; $GFE_BV_Trace_Str         = "[1/2]     Cover-Off Blank Trace Quality"
$Allelic_Ladder_Trace_Str = "[1/3]      Allelic Ladder Trace Quality" ; $GFE_007_Trace_Str        = "[1/4]             GFE_007 Trace Quality"
$NGM_007_Trace_Str        = "[1/5]             NGM_007 Trace Quality" ; $BLANK_Trace_Str          = "[1/6]               BLANK Trace Quality"
$GM_ILS           = "[ GeneMarker ]" ; $SampleName       = "[ Sample Name]" ; $RunCounter       = "[ Run Counter]"
$Cartridge_Type   = "[ Ctrg. Info ]" ; $Protocol_Setting = "[ Protocol   ]" ; $DebugStr         = "[ DebugMode  ]"
$Bolus_Timing     = "[Bolus_Timing]" ; $Date_Time        = "[ Run Date   ]" 
