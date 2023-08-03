$Desc_Optics        = "$Desc : Qmini and Laser infos generated during initialization of AutoFAT"
$Desc_TC            = "$Desc : SCI Thermocycler Calibration data, NaN means not yet Calibrated"
$Desc_MachineConfig = "$Desc : Info extracted from MachineCofig.xml file, Essential files"
$Desc_Firmware      = "$Desc : Win10 firmware, 1001.4.79 is the Production version"
$Desc_HIDAutoLite   = "$Desc : TestPrep installed HIDAutoLite only valid for 35 days, Data extracted from Execution.Log"
# add location info

<#
Provides more detailed test results
#>
Function RHID_Heater_Lysis_Details {
$RHID_Lysis1_Ramp = (($storyboard | Select-String "Lysis1 Ramp Rate =")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis1_Temp_Avg = (($storyboard | Select-String "Lysis1 Temp Average =" | Select-String "(84.5/85.5C)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis1_Temp_SD = (($storyboard | Select-String "Lysis1 Temp SD =" | Select-String "(< 0.25C)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis1_PWM_Avg = (($storyboard | Select-String "Lysis1 PWM Average =" | Select-String "(0/2600)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis1_PWM_SD = (($storyboard | Select-String "Lysis1 PWM SD =" | Select-String "(< 1000)")[-1].line.split(",").TrimStart())[-1]

$RHID_Lysis2_Ramp = (($storyboard | Select-String "Lysis2 Ramp Rate =")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis2_Temp_Avg = (($storyboard | Select-String "Lysis2 Temp Average =" | Select-String "(84.5/85.5C)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis2_Temp_SD = (($storyboard | Select-String "Lysis2 Temp SD =" | Select-String "(< 0.25C)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis2_PWM_Avg = (($storyboard | Select-String "Lysis2 PWM Average =" | Select-String "(0/8000)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis2_PWM_SD = (($storyboard | Select-String "Lysis2 PWM SD =" | Select-String "(< 1000)")[-1].line.split(",").TrimStart())[-1]
#change to details
"$Desc : $RHID_Lysis1_Ramp"
"$Desc : $RHID_Lysis1_Temp_Avg"
"$Desc : $RHID_Lysis1_Temp_SD"
"$Desc : $RHID_Lysis1_PWM_Avg"
"$Desc : $RHID_Lysis1_PWM_SD"
"$Desc : $RHID_Lysis2_Ramp"
"$Desc : $RHID_Lysis2_Temp_Avg"
"$Desc : $RHID_Lysis2_Temp_SD"
"$Desc : $RHID_Lysis2_PWM_Avg"
"$Desc : $RHID_Lysis2_PWM_SD"
}
# $RHID_Ambient_Temp = (($storyboard | Select-String "Ambient Temp =" | Select-String "(< 40C)")[-1].line.split(",").TrimStart())[-1]
