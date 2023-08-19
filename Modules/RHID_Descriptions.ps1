$Desc_Optics        = "$Desc : Qmini and Laser infos generated during initialization of AutoFAT"
$Desc_TC            = "$Desc : SCI Thermocycler Calibration data, NaN means not yet Calibrated"
$Desc_MachineConfig = "$Desc : Info extracted from MachineCofig.xml file, Essential files"
$Desc_Firmware      = "$Desc : Win10 firmware, 1001.4.79 is the Production version"
$Desc_HIDAutoLite   = "$Desc : TestPrep installed HIDAutoLite only valid for 35 days, Data extracted from Execution.Log"
# add location info

<#
Provides more detailed test results
#>


# $RHID_Lysis_Heater1_TempAvg = (($storyboard | Select-String "Lysis1 Temp Average =" | Select-String "(84.5/85.5C)")[-1].line.split(",").TrimStart())[-1]
# $RHID_Lysis_Heater1_PwmAvg  = (($storyboard | Select-String "Lysis1 PWM Average =" | Select-String "(0/2600)")[-1].line.split(",").TrimStart())[-1]
# $RHID_Lysis_Heater2_TempAvg = (($storyboard | Select-String "Lysis2 Temp Average =" | Select-String "(84.5/85.5C)")[-1].line.split(",").TrimStart())[-1]
# $RHID_Lysis_Heater2_PwmAvg  = (($storyboard | Select-String "Lysis2 PWM Average =" | Select-String "(0/8000)")[-1].line.split(",").TrimStart())[-1]

# Master copy of the data extraction method, when the value is sandwitched between text that need to be discarded.
# $Storyboard = Get-ChildItem "U:\RHID-0855" -I storyboard*.txt -R -ErrorAction SilentlyContinue
# Will be useful in the future when XML or HTML implementations are sucessfull

$RHID_Lysis1_Ramp       = [Double]((($storyboard | Select-String "Lysis1 Ramp Rate ="       )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C").trimstart()[0])
$RHID_Lysis1_Temp_Avg   = [Double]((($storyboard | Select-String "Lysis1 Temp Average ="    )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis1_Temp_SD    = [Double]((($storyboard | Select-String "Lysis1 Temp SD ="         )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis1_Pwm_Avg    = [Double]((($storyboard | Select-String "Lysis1 PWM Average ="     )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
$RHID_Lysis1_PWM_SD     = [Double]((($storyboard | Select-String "Lysis1 PWM SD ="          )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())

$RHID_Lysis2_Ramp       = [Double]((($storyboard | Select-String "Lysis2 Ramp Rate ="       )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C").trimstart()[0])
$RHID_Lysis2_Temp_Avg   = [Double]((($storyboard | Select-String "Lysis2 Temp Average ="    )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis2_Temp_SD    = [Double]((($storyboard | Select-String "Lysis2 Temp SD ="         )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis2_Pwm_Avg    = [Double]((($storyboard | Select-String "Lysis2 PWM Average ="     )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
$RHID_Lysis2_PWM_SD     = [Double]((($storyboard | Select-String "Lysis2 PWM SD ="          )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
Function RHID_Lysis_Heater_Details {
    "$Desc : " + "Lysis1 Ramp Rate      = " + "$RHID_Lysis1_Ramp" + "C/s"
    "$Desc : " + "Lysis1 Temp Average   = " + "$RHID_Lysis1_Temp_Avg" + "C (84.5 / 85.5C)"
    "$Desc : " + "Lysis1 Temp SD        = " + "$RHID_Lysis1_Temp_SD" + "C (< 0.25C)"
    "$Desc : " + "Lysis1 PWM Average    = " + "$RHID_Lysis1_Pwm_Avg" + "(0 / 2600)"
    "$Desc : " + "Lysis1 PWM SD         = " + "$RHID_Lysis1_PWM_SD" + "(< 1000)"
    "$Desc : " + "Lysis2 Ramp Rate      = " + "$RHID_Lysis2_Ramp" + "C/s"
    "$Desc : " + "Lysis2 Temp Average   = " + "$RHID_Lysis2_Temp_Avg" + "C (84.5 / 85.5C)"
    "$Desc : " + "Lysis2 Temp SD        = " + "$RHID_Lysis2_Temp_SD" + "C (< 0.25C)"
    "$Desc : " + "Lysis2 PWM Average    = " + "$RHID_Lysis2_Pwm_Avg" + "(0 / 8000)"
    "$Desc : " + "Lysis2 PWM SD         = " + "$RHID_Lysis2_PWM_SD" + "(< 1000)"
}
# $RHID_Ambient_Temp = (($storyboard | Select-String "Ambient Temp =" | Select-String "(< 40C)")[-1].line.split(",").TrimStart())[-1]

$RHID_DN_Temp_Avg       = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "Temp Average ="     )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C").trimstart()[0])
$RHID_DN_Temp_Max       = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "Temp Max Reached =" )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_DN_Temp_Ramp_Rate_80C     = [Double]((($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Temp Ramp Rate (80C) ="    )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_DN_Total_Ramp_Time_80C    = [Double]((($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Total Ramp Time (80C) ="   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("s").trimstart()[0])
$RHID_DN_Total_Ramp_Time_94C    = [Double]((($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Total Ramp Time (94C) ="   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("s").trimstart()[0])

$RHID_DN_Max_96C        = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "Max to 96C ="   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("s").trimstart()[0])
$RHID_DN_Temp_SD        = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "Temp SD ="      )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_DN_Pwm_Avg        = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "PWM Average ="  )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
$RHID_DN_PWM_SD         = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "PWM SD ="       )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
Function RHID_DN_Heater_Details {
    "$Desc : " + "Temp Average          = " + "$RHID_DN_Temp_Avg" + "C (94.5 / 95.5C)"
    "$Desc : " + "Temp Max Reached      = " + "$RHID_DN_Temp_Max" + "C (< 105C)"
    "$Desc : " + "Temp Ramp Rate (80C)  = " + "$RHID_DN_Temp_Ramp_Rate_80C" + "C/s"
    "$Desc : " + "Total Ramp Time (80C) = " + "$RHID_DN_Total_Ramp_Time_80C" + "s (< 60s)"
    "$Desc : " + "Total Ramp Time (94C) = " + "$RHID_DN_Total_Ramp_Time_94C" + "s"
    "$Desc : " + "Max to 96C            = " + "$RHID_DN_Max_96C" + "s (> 20s)"
    "$Desc : " + "Temp SD               = " + "$RHID_DN_Temp_SD" + "C (< 0.25C)"
    "$Desc : " + "PWM Average           = " + "$RHID_DN_Pwm_Avg" + "(< 2500)"
    "$Desc : " + "PWM SD                = " + "$RHID_DN_PWM_SD" + "(< 500)"
}
