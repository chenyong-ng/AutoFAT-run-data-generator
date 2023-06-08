<#
Provides more detailed test results
#>

$RHID_Lysis1_Ramp       = (($storyboard | Select-String "Lysis1 Ramp Rate =")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis1_Temp_Avg   = (($storyboard | Select-String "Lysis1 Temp Average =" | Select-String "(84.5/85.5C)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis1_Temp_SD    = (($storyboard | Select-String "Lysis1 Temp SD =" | Select-String "(< 0.25C)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis1_PWM_Avg    = (($storyboard | Select-String "Lysis1 PWM Average =" | Select-String "(0/2600)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis1_PWM_SD     = (($storyboard | Select-String "Lysis1 PWM SD =" | Select-String "(< 1000)")[-1].line.split(",").TrimStart())[-1]

$RHID_Lysis2_Ramp       = (($storyboard | Select-String "Lysis2 Ramp Rate =")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis2_Temp_Avg   = (($storyboard | Select-String "Lysis2 Temp Average =" | Select-String "(84.5/85.5C)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis2_Temp_SD    = (($storyboard | Select-String "Lysis2 Temp SD =" | Select-String "(< 0.25C)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis2_PWM_Avg    = (($storyboard | Select-String "Lysis2 PWM Average =" | Select-String "(0/2600)")[-1].line.split(",").TrimStart())[-1]
$RHID_Lysis2_PWM_SD     = (($storyboard | Select-String "Lysis2 PWM SD =" | Select-String "(< 1000)")[-1].line.split(",").TrimStart())[-1]

$RHID_Ambient_Temp = (($storyboard | Select-String "Ambient Temp =" | Select-String "(< 40C)")[-1].line.split(",").TrimStart())[-1]