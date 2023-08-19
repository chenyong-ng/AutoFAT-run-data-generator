$Desc_Optics        = "$Desc : Qmini and Laser infos generated during initialization of AutoFAT"
$Desc_TC            = "$Desc : SCI Thermocycler Calibration data, NaN means not yet Calibrated"
$Desc_MachineConfig = "$Desc : Info extracted from MachineCofig.xml file, Essential files"
$Desc_Firmware      = "$Desc : Win10 firmware, 1001.4.79 is the Production version"
$Desc_HIDAutoLite   = "$Desc : TestPrep installed HIDAutoLite only valid for 35 days, Data extracted from Execution.Log"
# add location info

<#
Provides more detailed test results
#>
# Master copy of the data extraction method, when the value is sandwitched between text that need to be discarded.
# $Storyboard = Get-ChildItem "U:\RHID-0855" -I storyboard*.txt -R -ErrorAction SilentlyContinue
# Will be useful in the future when XML or HTML implementations are sucessfull

$RHID_Lysis1_Ramp       = [Double]((($storyboard | Select-String "Lysis1 Ramp Rate ="       )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis1_Temp_Avg   = [Double]((($storyboard | Select-String "Lysis1 Temp Average ="    )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis1_Temp_SD    = [Double]((($storyboard | Select-String "Lysis1 Temp SD ="         )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis1_Pwm_Avg    = [Double]((($storyboard | Select-String "Lysis1 PWM Average ="     )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
$RHID_Lysis1_PWM_SD     = [Double]((($storyboard | Select-String "Lysis1 PWM SD ="          )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())

$RHID_Lysis2_Ramp       = [Double]((($storyboard | Select-String "Lysis2 Ramp Rate ="       )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis2_Temp_Avg   = [Double]((($storyboard | Select-String "Lysis2 Temp Average ="    )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis2_Temp_SD    = [Double]((($storyboard | Select-String "Lysis2 Temp SD ="         )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Lysis2_Pwm_Avg    = [Double]((($storyboard | Select-String "Lysis2 PWM Average ="     )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
$RHID_Lysis2_PWM_SD     = [Double]((($storyboard | Select-String "Lysis2 PWM SD ="          )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
Function RHID_Lysis_Heater_Details {
    "$Desc : " + "Lysis1 Ramp Rate      = " + "$RHID_Lysis1_Ramp"       + "C/s"
    "$Desc : " + "Lysis1 Temp Average   = " + "$RHID_Lysis1_Temp_Avg"   + "C (84.5 / 85.5C)"
    "$Desc : " + "Lysis1 Temp SD        = " + "$RHID_Lysis1_Temp_SD"    + "C (< 0.25C)"
    "$Desc : " + "Lysis1 PWM Average    = " + "$RHID_Lysis1_Pwm_Avg"    + "(0 / 2600)"
    "$Desc : " + "Lysis1 PWM SD         = " + "$RHID_Lysis1_PWM_SD"     + "(< 1000)"
    "$Desc : " + "Lysis2 Ramp Rate      = " + "$RHID_Lysis2_Ramp"       + "C/s"
    "$Desc : " + "Lysis2 Temp Average   = " + "$RHID_Lysis2_Temp_Avg"   + "C (84.5 / 85.5C)"
    "$Desc : " + "Lysis2 Temp SD        = " + "$RHID_Lysis2_Temp_SD"    + "C (< 0.25C)"
    "$Desc : " + "Lysis2 PWM Average    = " + "$RHID_Lysis2_Pwm_Avg"    + "(0 / 8000)"
    "$Desc : " + "Lysis2 PWM SD         = " + "$RHID_Lysis2_PWM_SD"     + "(< 1000)"
}
# $RHID_Ambient_Temp = (($storyboard | Select-String "Ambient Temp =" | Select-String "(< 40C)")[-1].line.split(",").TrimStart())[-1]

$RHID_DN_Temp_Avg       = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "Temp Average ="     )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_DN_Temp_Max       = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "Temp Max Reached =" )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_DN_Temp_Ramp_Rate_80C     = [Double]((($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Temp Ramp Rate (80C) ="    )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_DN_Total_Ramp_Time_80C    = [Double]((($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Total Ramp Time (80C) ="   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("s").trimstart()[0])
$RHID_DN_Total_Ramp_Time_94C    = [Double]((($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Total Ramp Time (94C) ="   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("s").trimstart()[0])

$RHID_DN_Max_96C        = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "Max to 96C ="   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("s")[0].trimstart())
$RHID_DN_Temp_SD        = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "Temp SD ="      )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_DN_Pwm_Avg        = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "PWM Average ="  )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
$RHID_DN_PWM_SD         = [Double]((($storyboard | Select-String "Denature Heater" | Select-String "PWM SD ="       )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
Function RHID_DN_Heater_Details {
    "$Desc : " + "DN Temp Average          = " + "$RHID_DN_Temp_Avg" + "C (94.5 / 95.5C)"
    "$Desc : " + "DN Temp Max Reached      = " + "$RHID_DN_Temp_Max" + "C (< 105C)"
    "$Desc : " + "DN Temp Ramp Rate (80C)  = " + "$RHID_DN_Temp_Ramp_Rate_80C"  + "C/s"
    "$Desc : " + "DN Total Ramp Time (80C) = " + "$RHID_DN_Total_Ramp_Time_80C" + "s (< 60s)"
    "$Desc : " + "DN Total Ramp Time (94C) = " + "$RHID_DN_Total_Ramp_Time_94C" + "s"
    "$Desc : " + "DN Max to 96C            = " + "$RHID_DN_Max_96C" + "s (> 20s)"
    "$Desc : " + "DN Temp SD               = " + "$RHID_DN_Temp_SD" + "C (< 0.25C)"
    "$Desc : " + "DN PWM Average           = " + "$RHID_DN_Pwm_Avg" + "(< 2500)"
    "$Desc : " + "DN PWM SD                = " + "$RHID_DN_PWM_SD"  + "(< 500)"
}

# PCR AMBIENT
$RHID_PCR_Top_Amb       = [Double]((($storyboard | Select-String "PCR Top Ambient ="    )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_Bot_Amb       = [Double]((($storyboard | Select-String "PCR Bottom Ambient =" )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_Amb_TopBot_Del = [Double]((($storyboard | Select-String -SimpleMatch "PCR Ambient Top/Bot Delta ="    )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
# PCR LOW 9C
$RHID_PCR_Top_9C_Avg    = [Double]((($storyboard | Select-String "PCR Top 9C Average =" )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_Top_SD_9C     = [Double]((($storyboard | Select-String "PCR Top SD 9C ="      )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_Bot_9C_Avg    = [Double]((($storyboard | Select-String "PCR Bottom 9C Average =" )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_Bot_SD_9C     = [Double]((($storyboard | Select-String "PCR Bottom SD 9C ="   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_9C_TopBot_Del = [Double]((($storyboard | Select-String -SimpleMatch "PCR 9C Top / Bot Delta ="        )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
# PCR HIGH 98C
$RHID_PCR_Top_98C_Avg   = [Double]((($storyboard | Select-String "PCR Top 98C Average =")[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_Top_SD_98C    = [Double]((($storyboard | Select-String "PCR Top SD 98C ="     )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_Bot_98C_Avg   = [Double]((($storyboard | Select-String "PCR Bottom 98C Average =" )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_Bot_SD_98C    = [Double]((($storyboard | Select-String "PCR Bottom SD 98C ="  )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_PCR_98C_TopBot_Del = [Double]((($storyboard | Select-String -SimpleMatch "PCR 98C Top / Bot Delta ="      )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())

Function RHID_PCR_Heater_Details {
    "$Desc : " + "PCR Top Ambient           = " + "$RHID_PCR_Top_Amb" + "C"
    "$Desc : " + "PCR Bottom Ambient        = " + "$RHID_PCR_Bot_Amb" + "C"
    "$Desc : " + "PCR Ambient Top/Bot Delta = " + "$RHID_PCR_Amb_TopBot_Del" + "C (< 1.5C)"

    "$Desc : " + "PCR Top 9C Average      = " + "$RHID_PCR_Top_9C_Avg"  + "C (8/10C)"
    "$Desc : " + "PCR Top SD 9C           = " + "$RHID_PCR_Top_SD_9C"   + "C (< 0.25C)"
    "$Desc : " + "PCR Bottom 9C Average   = " + "$RHID_PCR_Bot_9C_Avg"  + "C (8/10C)"
    "$Desc : " + "PCR Bottom SD 9C        = " + "$RHID_PCR_Bot_SD_9C"   + "C(< 0.25C)"
    "$Desc : " + "PCR 9C Top / Bot Delta  = " + "$RHID_PCR_9C_TopBot_Del"   + "C (< 1C)"

    "$Desc : " + "PCR Top 98C Average     = " + "$RHID_PCR_Top_98C_Avg" + "C (97.5/98.5C)"
    "$Desc : " + "PCR Top SD 98C          = " + "$RHID_PCR_Top_SD_98C"  + "C (< 0.25C)"
    "$Desc : " + "PCR Bottom 98C Average  = " + "$RHID_PCR_Bot_98C_Avg" + "C (97.5/98.5C)"
    "$Desc : " + "PCR Bottom SD 98C       = " + "$RHID_PCR_Bot_SD_98C"  + "C (< 0.25C)"
    "$Desc : " + "PCR 98C Top / Bot Delta = " + "$RHID_PCR_98C_TopBot_Del"  + "C (< 0.5C)"
}

$RHID_Optics_Heater_TempAvg         = [Double]((($storyboard | Select-String "Optics Module" | Select-String "Temp Average ="   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Optics_Heater_Temp_SD         = [Double]((($storyboard | Select-String "Optics Module" | Select-String "Temp SD ="        )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Optics_Heater_Temp_Ramp_Rate  = [Double]((($storyboard | Select-String "Optics Module" | Select-String "Temp Ramp Rate"   )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Optics_Heater_Ramp_Start      = [Double]((($storyboard | Select-String "Optics Module" | Select-String "Ramp Start:"      )[-1].line.split(",").TrimStart())[-1].split(":")[-1].split("(")[0].split("C")[0].trimstart())

$RHID_Optics_Heater_Ramp_End    = [Double]((($storyboard | Select-String "Optics Module" | Select-String "Ramp End:"     )[-1].line.split(",").TrimStart())[-1].split(":")[-1].split("(")[0].split("C")[0].trimstart())
$RHID_Optics_Heater_Ramp_Time   = [Double]((($storyboard | Select-String "Optics Module" | Select-String "Ramp Time:"    )[-1].line.split(",").TrimStart())[-1].split(":")[-1].split("(")[0].split("s")[0].trimstart())
$RHID_Optics_Heater_PwmAvg      = [Double]((($storyboard | Select-String "Optics Module" | Select-String "PWM Average =")[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())
$RHID_Optics_Heater_PWM_SD      = [Double]((($storyboard | Select-String "Optics Module" | Select-String "PWM SD "      )[-1].line.split(",").TrimStart())[-1].split("=")[-1].split("(")[0].trimstart())

Function RHID_Optics_Heater_Details {
    "$Desc : " + "Optics Temp Average   = " + "$RHID_Optics_Heater_TempAvg"         + "C (41.5/42.5C)"
    "$Desc : " + "Optics Temp SD        = " + "$RHID_Optics_Heater_Temp_SD"         + "C (< 0.1C)"
    "$Desc : " + "Optics Temp Ramp Rate = " + "$RHID_Optics_Heater_Temp_Ramp_Rate"  + "C/s"
    "$Desc : " + "Optics Ramp Start     = " + "$RHID_Optics_Heater_Ramp_Start"      + "C (30C)"

    "$Desc : " + "Optics Ramp End       = " + "$RHID_Optics_Heater_Ramp_End"        + "C (40C)"
    "$Desc : " + "Optics Ramp Time      = " + "$RHID_Optics_Heater_Ramp_Time"       + "s (< 80s)"
    "$Desc : " + "Optics PWM Average    = " + "$RHID_Optics_Heater_PwmAvg"          + "(< 15000)"
    "$Desc : " + "Optics PWM SD         = " + "$RHID_Optics_Heater_PWM_SD"          + "(< 1000)"
}

$RHID_Gel_Cooler_TempAvg = [Double]((($storyboard |  Select-String "BECInterface" | Select-String "Temp Average:"    | Select-String "(2.5/3.5C)"))[-1].line.split(",").TrimStart())[-1].split(":")[-1].split("(")[0].split("C")[0].trimstart()
$RHID_Gel_Cooler_VoltAvg = [Double]((($storyboard |  Select-String "BECInterface" | Select-String "Voltage Average:" | Select-String "(< 5V)"))[-1].line.split(",").TrimStart())[-1].split(":")[-1].split("(")[0].split("V")[0].trimstart()
$RHID_Gel_Cooler_AmpAvg  = [Double]((($storyboard |  Select-String "BECInterface" | Select-String "Current Average:" | Select-String "(< 1.5A)"))[-1].line.split(",").TrimStart())[-1].split(":")[-1].split("(")[0].split("A")[0].trimstart()

Function RHID_Gel_Cooler_Details {
    "$Desc : " + "Gel Cooler Temp Average       = " + "$RHID_Gel_Cooler_TempAvg" + "C (2.5 / 3.5C)"
    "$Desc : " + "Gel Cooler Voltage Average    = " + "$RHID_Gel_Cooler_VoltAvg" + "V (< 5V)"
    "$Desc : " + "Gel Cooler Current Average    = " + "$RHID_Gel_Cooler_AmpAvg" + "A (< 1.5A)"
}
