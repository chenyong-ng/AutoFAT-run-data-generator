<#
.Title          : Powershell Utility for RHID Instrument
.Source         : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version        :	v0.4
.License        : Public Domain
.Revision Date  : 10 JUL 2022
.Description    : This script are best viewed and edit in Visual Studio Code https://code.visualstudio.com/


Initialize global variables, do not change the order.
#>

$storyboard = Get-ChildItem "$serverdir" -I storyboard*.* -R
if ([bool]$storyboard -ne "True") {
    Write-Error -Message "Storyboard logfile does not exist (yet)" -ErrorAction Stop}
$MachineName = ($storyboard | Select-String "MachineName" | Select-Object -Last 1).Line.Split(":").TrimStart() | Select-Object -Last 1

$MachineConfigXML = Get-ChildItem "$serverdir" -I MachineConfig.xml -R
$TC_CalibrationXML = Get-Childitem "$serverdir" -I TC_Calibration.xml -R 
$SampleQuality = Get-ChildItem "$serverdir" -I SampleQuality.txt -R
$DannoGUIStateXML = Get-ChildItem "$serverdir" -I DannoGUIState.xml -R
$ExecutionLOG = Get-ChildItem "$serverdir" -I execution.log -R
$CoverOn_BEC_Reinsert = Get-ChildItem "$serverdir\*BEC Insertion BEC_*" -I storyboard*.* -R 
$GM_Analysis_PeakTable = Get-ChildItem "$serverdir" -I GM_Analysis_PeakTable.txt -R

. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\RHID_Str_Filters.ps1

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
    Write-Host "$TC_Cal :      $Warning : Unpopulated TC_Calibration.XML Found" -ForegroundColor RED
} elseif ($RHID_TC_Calibration.count -eq "0") {
    Write-Host "$TC_Cal :               $Warning : TC_Calibration.XML Not Found" -ForegroundColor RED
} else { 
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Calibrated" -ForegroundColor Green }

. $PSScriptRoot\TC_VerificationTXT.ps1
if ([bool]$TC_verificationTXT -eq "True") {
"$Verification : $Ambient_Probe_Str : $RHID_Verify_USB_Probe"
"$Verification : $USB_Temp_Humidity : $RHID_Verify_Probe"
"$Verification : $TC_Probe_ID : $RHID_TC_Probe_ID"
"$Verification : $TC_Steps 1 : $RHID_TC_Step1"
"$Verification : $TC_Steps 2 : $RHID_TC_Step2"
"$Verification : $TC_Steps 3 : $RHID_TC_Step3"
"$Verification : $TC_Steps 4 : $RHID_TC_Step4"
"$Verification : $Airleak_Test : $RHID_Verify_Arileak"
}

if ($RHID_MachineConfig_SN.count -eq "0") {
    Write-Host "$MachineConf :               $Warning : MachineConfig.XML Not Found" -ForegroundColor RED
}

Write-Host "$MachineConf : $Instrument_Serial : $RHID_MachineConfig_SN" -ForegroundColor Green
Write-Host "$MachineConf : $Hardware_Version : $RHID_MachineConfig_HWVer" -ForegroundColor Green
Write-Host "$MachineConf : $SCI_Configuration : $RHID_MachineConfig_HWID" -ForegroundColor Green
Write-Host "$MachineConf : $Data_Upload_Path : $RHID_MachineConfig_ServerPath" -ForegroundColor Green
Write-Host "$MachineConf : $Syringe_Pump_Calibration : $RHID_MachineConfig_Syring" -ForegroundColor Green
Write-Host "$MachineConf : $PrimeWater_Status : $RHID_MachineConfig_PrimeWater" -ForegroundColor Green
Write-Host "$MachineConf : $PrimeLysisBuffer : $RHID_MachineConfig_PrimeLysisBuffer" -ForegroundColor Green

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
} Else { Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : Undetected or Expired" -ForegroundColor Red }

$Section_Separator

<#
add more robust checking
$RHID_Lysis_Heater_FAT  = $storyboard | Select-String "Lysis Heater FAT" | select-string "pass" | Select-Object -Last 1
$RHID_Lysis_Heater_FAT.line.split(":")
#>

$RHID_Lysis_Heater_FAT = $storyboard | Select-String "Lysis Heater FAT"
$RHID_Lysis_Heater_FAT_PASS = ($RHID_Lysis_Heater_FAT | select-string "pass" ).Line.split(":").TrimStart()[-1]
if ($RHID_Lysis_Heater_FAT.count -eq "0") {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_NA" -ForegroundColor Yellow 
}
elseif ([bool]($RHID_Lysis_Heater_FAT_PASS -eq "PASS")) {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Passed" -ForegroundColor Green
        If ($DebugMode -eq "True") {
            "Lysis Heater Pass Count ($RHID_Lysis_Heater_FAT_PASS).count " 
            ($RHID_Lysis_Heater_FAT | select-string "pass" )
            ($RHID_Lysis_Heater_FAT | select-string "pass" ).Line.split(",").TrimStart()[-1]
}}
else {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Failed" -ForegroundColor Red
    If (DebugMode = "True") { $RHID_Lysis_Heater_FAT }
}



if (($RHID_DN_Heater_FAT).count -eq "0") {
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

$Section_Separator
if (($RHID_CAM_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_CAM_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_Failed" -ForegroundColor Red    }

if (($RHID_SCI_Insertion_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_SCI_Insertion_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_SCI_Insertion_FAT_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_FRONT_END_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_FRONT_END_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_FRONT_END_FAT_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_FE_Motor_Calibration).count -eq "") {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_FE_Motor_Calibration | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_FE_Motor_Calibration_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_FE_Motor_Test).count -eq "") {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_FE_Motor_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_FE_Motor_Test_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Homing_Error_Test).count -eq "") {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Homing_Error_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_Homing_Error_Test_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_FL_Homing_Error_wCAM_Test).count -eq "") {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_FL_Homing_Error_wCAM_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_FL_Homing_Error_wCAM_Test_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_SCI_Antenna_Test).count -eq "") {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_SCI_Antenna_Test | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_SCI_Antenna_Test_Str $Test_Failed" -ForegroundColor Red    }

$Section_Separator

if (($RHID_Mezz_test).count -eq "") {
    Write-Host "$MezzActuator : $RHID_Mezz_Test_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Mezz_test | Select-String "Pass") -eq "True") {
    Write-Host "$MezzActuator : $RHID_Mezz_Test_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$MezzActuator : $RHID_Mezz_Test_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_HP_FAT).count -eq "") {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_HP_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$HP_FAT : $RHID_HP_FAT_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_LP_FAT).count -eq "") {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_LP_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$LP_FAT : $RHID_LP_FAT_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Anode_Motor_FAT).count -eq "") {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Anode_Motor_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Anode_Motor : $RHID_Anode_Motor_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_BEC_Interlock_FAT).count -eq "") {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_BEC_Interlock_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$BEC_Itlck : $BEC_Interlock_FAT_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Gel_Antenna_HIGH).count -eq "") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Gel_Antenna_HIGH | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_HIGH $Test_Failed" -ForegroundColor Red    }

if (($RHID_Gel_Antenna_LOW).count -eq "") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Gel_Antenna_LOW | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Gel_RFID : $RHID_Gel_Antenna_Str_LOW $Test_Failed" -ForegroundColor Red    }

if (($RHID_Syringe_Stallout_FAT).count -eq "") {
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Syringe_Stallout_FAT | Select-String "Pass") -eq "True") {
    $RHID_Syringe_MIN_CURRENT   = ($storyboard | Select-String "Min Current" | Select-Object -Last 1).line.split(",").TrimStart()| Select-Object -Last 1
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_Passed " -ForegroundColor Green
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Cal : $RHID_Syringe_MIN_CURRENT" -ForegroundColor Cyan 
} else {
    Write-Host "$Syrg_Pmp : $RHID_Syringe_Stallout_FAT_Str $Test_Failed : $RHID_Syringe_MIN_CURRENT" -ForegroundColor Red    }

if (($RHID_Mezzboard_FAT).count -eq "") {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Mezzboard_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Mezz_PCBA : $RHID_Mezzboard_FAT_STR $Test_Failed" -ForegroundColor Red    }

If ([Bool]$RHID_BEC_Reinsert_First -eq "True") {
    $RHID_Gel_Void_First = ($storyboard | Select-String "Estimated gel void volume" | Select-Object -First 1).line.split("=").TrimStart() | Select-Object -Last 1
    $RHID_BEC_ID_First = $RHID_BEC_insert_ID.line.split(" ").TrimStart() | Select-Object -Last 1
    Write-host "$BEC_Insertion : $RHID_CoverOff_BEC_Reinsert : Completed ; BEC_ID : $RHID_BEC_ID_First"
    Write-host "$BEC_Insertion : $RHID_First_Gel_Void : $RHID_Gel_Void_First" -ForegroundColor Cyan }
    Else {
    Write-host "$BEC_Insertion : $RHID_CoverOff_BEC_Reinsert : N/A" -ForegroundColor Yellow }

if (($RHID_Piezo_FAT).count -eq "") {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Piezo_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Piezo : $RHID_Piezo_FAT_str $Test_Failed" -ForegroundColor Red    }

if (($RHID_HV_FAT).count -eq "") {
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_HV_FAT | Select-String "Pass") -eq "True") {
    $RHID_HV_FAT_Voltage = ($storyboard | Select-String "Voltage =" | Select-String "(8650/9300V)" | Select-Object -Last 1).line.split(",").TrimStart() | Select-Object -Last 1
    $RHID_HV_FAT_Current = ($storyboard | Select-String "Current =" | Select-String "(> 5uA)" | Select-Object -Last 1).line.split(",").TrimStart() | Select-Object -Last 1
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_Passed $RHID_HV_FAT_Voltage $RHID_HV_FAT_Current" -ForegroundColor Green}
else {
    # Display err when failed "Current Under Limit. Check BEC."
    Write-Host "$HV : $RHID_HV_FAT_Str $Test_Failed $RHID_HV_FAT_Voltage $RHID_HV_FAT_Current" -ForegroundColor Red    }

if (($RHID_Laser_FAT).count -eq "") {
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Laser_FAT | Select-String "Pass") -eq "True") {
    $RHID_Raman_Signal = ($storyboard | Select-String "Raman =").Line.Split("=").TrimStart() | Select-Object -Last 1
    $RHID_Raman_Bin = ($storyboard | Select-String "Bin =").Line.Split("=").TrimStart() | Select-Object -Last 1
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$Laser : $RHID_Laser_Raman = $RHID_Raman_Signal ; Bin = $RHID_Raman_Bin" -ForegroundColor Green
} else {
    Write-Host "$Laser : $RHID_Laser_FAT_Str $Test_Failed" -ForegroundColor Red    }

$Section_Separator

if (($RHID_Water_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_NA" -ForegroundColor Yellow }
elseif ([bool] ($RHID_Water_Prime | Select-String "Pass") -eq "True") {
    $RHID_Water_Prime_Plug = ($storyboard | Select-String "Plug detected" | Select-Object -Last 1).line.split(",").TrimStart() | Select-Object -Last 2 | Select-Object -SkipLast 1
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$WetTest : [32/41]  $RHID_Water_Prime_Plug" -ForegroundColor Cyan }
else {
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Lysis_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysis_Prime | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Buffer_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Buffer_Prime | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Lysis_Dispense).count -eq "") {
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysis_Dispense | Select-String "Pass") -eq "True") {
    $RHID_Lysis_Dispense_Volume = ($storyboard | Select-String "Lysis Volume ="  | Select-Object -Last 1).line.split("=").TrimStart() | Select-object -last 1
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str : $RHID_Lysis_Dispense_Volume" -ForegroundColor Cyan }
else {
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Lysate_Pull).count -eq "") {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysate_Pull | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Capillary_Gel_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Capillary_Gel_Prime | Select-String "Completed") -eq "True") {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str : Completed" -ForegroundColor Green }
else {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Raman).count -eq "") {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Raman | Select-String "Pass") -eq "True") {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_Passed" -ForegroundColor Green
}
else {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_Failed" -ForegroundColor Red    }

$RHID_Bolus = Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*" -I storyboard*.* -R | Select-String "Bolus Devliery Test" | select-string "PASS"
if ($RHID_Bolus.count -gt 1) {
    Write-host "$Bolus : $Bolus_Test_count_Str" : $RHID_Bolus.count -ForegroundColor Green
} else {
    Write-host "$Bolus : $Bolus_Test_count_Str : N/A" -ForegroundColor Yellow
}

IF ([Bool]$RHID_BEC_Reinsert -eq "True") {
    $RHID_Gel_Void = ($storyboard | Select-String "Estimated gel void volume" | Select-object -last 1).line.split("=").TrimStart() | Select-Object -Last 1
    $RHID_BEC_ID = $RHID_BEC_Reinsert_ID.line.split(":").TrimStart() | Select-Object -Last 1
    Write-host "$BEC_Insertion : $RHID_CoverOn_BEC_Reinsert : Completed ; $RHID_BEC_ID"
    Write-host "$BEC_Insertion : $RHID_Last_Gel_Void : $RHID_Gel_Void" -ForegroundColor Cyan 
}
Else {
    Write-host "$BEC_Insertion : $RHID_CoverOn_BEC_Reinsert : N/A" -ForegroundColor Yellow
    Write-host "$BEC_Insertion : $RHID_Last_Gel_Void : N/A" -ForegroundColor Yellow }
$Section_Separator
IF ($GM_ILS_Score_GFE_36cycles.count -gt 0) {
    $GM_ILS_Score_GFE_36cycles_Score = $GM_ILS_Score_GFE_36cycles.Line.Split("	") | Select-Object -Last 1
    $serverdir36cycles = "$Drive\$MachineName\*GFE-300uL-36cycles*"
    $DxCode = Get-ChildItem $serverdir36cycles -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir36cycles -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_36cycles_Trace_Str : $GM_ILS_Score_GFE_36cycles_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/1] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/1] $RHID_SampleName"
    "$Cartridge_Type : [4/1] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"
    "$Protocol_Setting : [5/1] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $GFE_36cycles_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_Separator
IF ($GM_ILS_Score_GFE_BV.count -gt 0) {
    $GM_ILS_Score_GFE_BV_Score = $GM_ILS_Score_GFE_BV.Line.Split("	") | Select-Object -Last 1
    $serverdir_GFE_BV = "$Drive\$MachineName\*GFE-BV_*"
    $DxCode = Get-ChildItem $serverdir_GFE_BV -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_GFE_BV -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_BV_Trace_Str : $GM_ILS_Score_GFE_BV_Score $DxCode"-ForegroundColor Green
    "$Date_Time : [2/2] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/2] $RHID_SampleName"
    "$Cartridge_Type : [4/2] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"
    "$Protocol_Setting : [5/2] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $GFE_BV_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_Separator
IF ($GM_ILS_Score_Allelic_Ladder.count -gt 0) {
    $GM_ILS_Score_Allelic_Ladder_Score = $GM_ILS_Score_Allelic_Ladder.Line.Split("	") | Select-Object -Last 1
    $serverdir_Ladder = "$Drive\$MachineName\*GFE-BV Allelic Ladder*"
    $DxCode = Get-ChildItem $serverdir_Ladder -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_Ladder -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $Allelic_Ladder_Trace_Str : $GM_ILS_Score_Allelic_Ladder_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/3] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    Write-Host "$Cartridge_Type : [3/3] $RHID_Cartridge_Type ; [Type] : $RHID_RunType" -ForegroundColor Cyan
    "$Protocol_Setting : [4/3] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $Allelic_Ladder_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_Separator
IF ($GM_ILS_Score_GFE_007.count -gt 0) {
    $GM_ILS_Score_GFE_007_Score = $GM_ILS_Score_GFE_007.Line.Split("	") | Select-Object -Last 1
    $serverdir_GFE_007 = "$Drive\$MachineName\*GFE_007*"
    $DxCode = Get-ChildItem $serverdir_GFE_007 -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_GFE_007 -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_007_Trace_Str : $GM_ILS_Score_GFE_007_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/4] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/4] $RHID_SampleName"
    "$Cartridge_Type : [4/4] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"
    "$Protocol_Setting : [5/4] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $GFE_007_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_SeparatoR
IF ($GM_ILS_Score_NGM_007.count -gt 0) {
    $GM_ILS_Score_NGM_007_Score = $GM_ILS_Score_NGM_007.Line.Split("	") | Select-Object -Last 1
    $serverdir_NGM_007 = "$Drive\$MachineName\*NGM_007*"
    $DxCode = Get-ChildItem $serverdir_NGM_007 -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_NGM_007 -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $NGM_007_Trace_Str : $GM_ILS_Score_NGM_007_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/5] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/5] $RHID_SampleName"
    Write-Host "$Cartridge_Type : [4/5] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"-ForegroundColor Green
    "$Protocol_Setting : [5/5] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $NGM_007_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_Separator
IF ($GM_ILS_Score_BLANK.count -gt 0) {
    $GM_ILS_Score_BLANK_Score = $GM_ILS_Score_BLANK.Line.Split("	") | Select-Object -Last 1
    $serverdir_BLANK = "$Drive\$MachineName\*BLANK*"
    $DxCode = Get-ChildItem $serverdir_BLANK -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_BLANK -I RunSummary.csv -R
    $BlankRunCounter = Get-ChildItem $serverdir_BLANK -I $GM_Analysis -R
    If ($BlankRunCounter.count -gt 3) { $Color = "Cyan" } else { $Color = "Red"}
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $BLANK_Trace_Str : $GM_ILS_Score_BLANK_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/6] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/6] $RHID_SampleName"
    "$Cartridge_Type : [4/6] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"
    "$Protocol_Setting : [5/6] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
    Write-Host "$RunCounter : [6/6] Blank Run Counter :" $BlankRunCounter.count -ForegroundColor $Color
}
Else { Write-Host "$GM_ILS : $BLANK_Trace_Str : N/A" -ForegroundColor Yellow }

$Section_Separator
if ([Bool] ($StatusData_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_StatusData_PDF = Get-ChildItem -path "$Drive\$MachineName" -I $StatusData -R |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "$Full_Run : $StatusData $File_found" -ForegroundColor Green
    $RHID_StatusData_PDF
    } else {
    Write-host "$Full_Run : $StatusData $File_not_Found" -ForegroundColor yellow }
$Section_Separator
if ([Bool] ($GM_Analysis_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_GM_Analysis = Get-ChildItem -path "$Drive\$MachineName" -I $GM_Analysis -R |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "$Full_Run : $GM_Analysis $File_found" -ForegroundColor Green
    $RHID_GM_Analysis }
    else {Write-host "$Full_Run : $GM_Analysis $File_not_Found" -ForegroundColor yellow }

Write-Host "$USB_Temp : $USB_Temp_RD : $RHID_USB_Temp_Rdr" -ForegroundColor Cyan
Write-Host "$USB_Humi : $USB_Humi_RD : $RHID_USB_Humi_Rdr" -ForegroundColor Cyan
$Section_Separator

# ignore folder with 0 size 
# "ErrorAction SilentlyContinue" workaround for older versions of Powershell.
$Remote = Get-ChildItem -force "$Drive\$MachineName\Internal\"  -Recurse -ErrorAction SilentlyContinue
$Local = Get-ChildItem -force "E:\RapidHIT ID"             -Recurse -ErrorAction SilentlyContinue
$RemoteSize = "{0:N4} GB" -f (($Remote | Measure-Object Length -sum -ErrorAction SilentlyContinue ).sum / 1Gb)
$LocalSize = "{0:N4} GB" -f (( $Local | Measure-Object Length -sum ).sum / 1Gb)
$RemoteFileCount = (Get-ChildItem "$Drive\$MachineName\Internal\"  -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count 
$localFileCount = (Get-ChildItem "E:\RapidHIT ID"  -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count 

$RHID_Shipping_BEC = $storyboard | Select-String "Shipping BEC engaged"
if ([bool]$RHID_Shipping_BEC -eq "True") {
    Write-Host "$SHP_BEC :   BEC Insertion completed, Shipping BEC : Engaged" -ForegroundColor Green
}else {
    Write-Host "$SHP_BEC :           Shipping BEC not yet inserted" -ForegroundColor Yellow }

    # block empty machine name
$Local_Folder_Msg = Write-Host "$boxPrep : $Local_Str : $LocalSize ; Files : $LocalFileCount"
$Remote_Folder_Msg = Write-Host "$boxPrep : $Remote_Str : $RemoteSize ; Files : $RemoteFileCount"
IF ([Bool]$MachineName -eq "False") {
    $Local_Folder_Msg
    $Remote_Folder_Msg
    Write-Host "$BoxPrep : Backup Instrument folder before Boxprep !!!" -ForegroundColor Red
    Write-Host "$BoxPrep : Boxprep not yet Initialized" -ForegroundColor Yellow
}
Else {
    $RHID_Danno_Path = $danno + $MachineName
    $RHID_HIDAutolite = (Get-ChildItem $RHID_Danno_Path -I *BoxPrepLog_RHID* -R -ErrorAction SilentlyContinue -Exclude "*.log" | Select-String $RHID_HIDAutolite_Str | Select-Object -Last 1).Line.Split(" ").TrimStart() | Select-Object -Last 1
    $RHID_BoxPrep_Scrshot = Get-ChildItem -Path $RHID_Danno_Path\Screenshots *.PNG -ErrorAction SilentlyContinue
    Write-Host $BoxPrep : $Danno_SS_Count : $RHID_BoxPrep_Scrshot.Name.Count -ForegroundColor Green
    $Local_Folder_Msg
    $Remote_Folder_Msg
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Str : $RHID_HIDAutolite" -ForegroundColor Green
}

if (($RemoteSize -lt $LocalSize) -and ($SerialRegMatch = "True")) {
    Write-Host "$BoxPrep :   Backing Up Instrument Run data to Remote Folder" -ForegroundColor Green
    $KeyPress_Backup = "Enter to skip backup operation"
    IF ($KeyPress_Backup -eq "") {
        "Skipped backup operation"
    } else {
        "Performing backup operation"
        #BackupBeforeShipprep
    }
}