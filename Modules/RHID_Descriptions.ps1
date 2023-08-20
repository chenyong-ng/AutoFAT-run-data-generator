
#>
# Master copy of the data extraction method, when the value is sandwitched between text that need to be discarded.
# $Storyboard = Get-ChildItem "U:\RHID-0855" -I storyboard*.txt -R -ErrorAction SilentlyContinue
# Will be useful in the future when XML or HTML implementations are sucessfull

$RHID_Lysis1_Ramp       = [Double]($storyboard | Select-String "Lysis1 Ramp Rate ="       )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Lysis1_Temp_Avg   = [Double]($storyboard | Select-String "Lysis1 Temp Average ="    )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Lysis1_Temp_SD    = [Double]($storyboard | Select-String "Lysis1 Temp SD ="         )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Lysis1_Pwm_Avg    = [Double]($storyboard | Select-String "Lysis1 PWM Average ="     )[-1].line.split(",")[-1].split("=")[-1].split("(")[0]
$RHID_Lysis1_PWM_SD     = [Double]($storyboard | Select-String "Lysis1 PWM SD ="          )[-1].line.split(",")[-1].split("=")[-1].split("(")[0]

$RHID_Lysis2_Ramp       = [Double]($storyboard | Select-String "Lysis2 Ramp Rate ="       )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Lysis2_Temp_Avg   = [Double]($storyboard | Select-String "Lysis2 Temp Average ="    )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Lysis2_Temp_SD    = [Double]($storyboard | Select-String "Lysis2 Temp SD ="         )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Lysis2_Pwm_Avg    = [Double]($storyboard | Select-String "Lysis2 PWM Average ="     )[-1].line.split(",")[-1].split("=")[-1].split("(")[0]
$RHID_Lysis2_PWM_SD     = [Double]($storyboard | Select-String "Lysis2 PWM SD ="          )[-1].line.split(",")[-1].split("=")[-1].split("(")[0]
Function RHID_Lysis_Heater_Details {
    "$Desc : " + "Lysis1 Ramp Rate      = " + "$RHID_Lysis1_Ramp"       + " C/s"
    "$Desc : " + "Lysis1 Temp Average   = " + "$RHID_Lysis1_Temp_Avg"   + " C (84.5 / 85.5C)"
    "$Desc : " + "Lysis1 Temp SD        = " + "$RHID_Lysis1_Temp_SD"    + " C (< 0.25C)"
    "$Desc : " + "Lysis1 PWM Average    = " + "$RHID_Lysis1_Pwm_Avg"    + " (0 / 2600)"
    "$Desc : " + "Lysis1 PWM SD         = " + "$RHID_Lysis1_PWM_SD"     + " (< 1000)"
    "$Desc : " + "Lysis2 Ramp Rate      = " + "$RHID_Lysis2_Ramp"       + " C/s"
    "$Desc : " + "Lysis2 Temp Average   = " + "$RHID_Lysis2_Temp_Avg"   + " C (84.5 / 85.5C)"
    "$Desc : " + "Lysis2 Temp SD        = " + "$RHID_Lysis2_Temp_SD"    + " C (< 0.25C)"
    "$Desc : " + "Lysis2 PWM Average    = " + "$RHID_Lysis2_Pwm_Avg"    + " (0 / 8000)"
    "$Desc : " + "Lysis2 PWM SD         = " + "$RHID_Lysis2_PWM_SD"     + " (< 1000)"
}
# $RHID_Ambient_Temp = (($storyboard | Select-String "Ambient Temp =" | Select-String "(< 40C)")[-1].line.split(",").TrimStart())[-1]

$RHID_DN_Temp_Avg       = [Double]($storyboard | Select-String "Denature Heater" | Select-String "Temp Average ="     )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_DN_Temp_Max       = [Double]($storyboard | Select-String "Denature Heater" | Select-String "Temp Max Reached =" )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_DN_Temp_Ramp_Rate_80C     = [Double]($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Temp Ramp Rate (80C) ="    )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_DN_Total_Ramp_Time_80C    = [Double]($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Total Ramp Time (80C) ="   )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("s")[0]
$RHID_DN_Total_Ramp_Time_94C    = [Double]($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Total Ramp Time (94C) ="   )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("s")[0]

$RHID_DN_Max_96C        = [Double]($storyboard | Select-String "Denature Heater" | Select-String "Max to 96C ="   )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("s")[0]
$RHID_DN_Temp_SD        = [Double]($storyboard | Select-String "Denature Heater" | Select-String "Temp SD ="      )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_DN_Pwm_Avg        = [Double]($storyboard | Select-String "Denature Heater" | Select-String "PWM Average ="  )[-1].line.split(",")[-1].split("=")[-1].split("(")[0]
$RHID_DN_PWM_SD         = [Double]($storyboard | Select-String "Denature Heater" | Select-String "PWM SD ="       )[-1].line.split(",")[-1].split("=")[-1].split("(")[0]
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
$RHID_PCR_Top_Amb       = [Double]($storyboard | Select-String "PCR Top Ambient ="    )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_Bot_Amb       = [Double]($storyboard | Select-String "PCR Bottom Ambient =" )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_Amb_TopBot_Del = [Double]($storyboard | Select-String -SimpleMatch "PCR Ambient Top/Bot Delta ="    )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
# PCR LOW 9C
$RHID_PCR_Top_9C_Avg    = [Double]($storyboard | Select-String "PCR Top 9C Average =" )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_Top_SD_9C     = [Double]($storyboard | Select-String "PCR Top SD 9C ="      )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_Bot_9C_Avg    = [Double]($storyboard | Select-String "PCR Bottom 9C Average =" )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_Bot_SD_9C     = [Double]($storyboard | Select-String "PCR Bottom SD 9C ="   )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_9C_TopBot_Del = [Double]($storyboard | Select-String -SimpleMatch "PCR 9C Top / Bot Delta ="        )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
# PCR HIGH 98C
$RHID_PCR_Top_98C_Avg   = [Double]($storyboard | Select-String "PCR Top 98C Average =")[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_Top_SD_98C    = [Double]($storyboard | Select-String "PCR Top SD 98C ="     )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_Bot_98C_Avg   = [Double]($storyboard | Select-String "PCR Bottom 98C Average =" )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_Bot_SD_98C    = [Double]($storyboard | Select-String "PCR Bottom SD 98C ="  )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_PCR_98C_TopBot_Del = [Double]($storyboard | Select-String -SimpleMatch "PCR 98C Top / Bot Delta ="      )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]

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

$RHID_Optics_Heater_TempAvg         = [Double]($storyboard | Select-String "Optics Module" | Select-String "Temp Average ="   )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Optics_Heater_Temp_SD         = [Double]($storyboard | Select-String "Optics Module" | Select-String "Temp SD ="        )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Optics_Heater_Temp_Ramp_Rate  = [Double]($storyboard | Select-String "Optics Module" | Select-String "Temp Ramp Rate"   )[-1].line.split(",")[-1].split("=")[-1].split("(")[0].split("C")[0]
$RHID_Optics_Heater_Ramp_Start      = [Double]($storyboard | Select-String "Optics Module" | Select-String "Ramp Start:"      )[-1].line.split(",")[-1].split(":")[-1].split("(")[0].split("C")[0]

$RHID_Optics_Heater_Ramp_End        = [Double]($storyboard | Select-String "Optics Module" | Select-String "Ramp End:"      )[-1].line.split(",")[-1].split(":")[-1].split("(")[0].split("C")[0]
$RHID_Optics_Heater_Ramp_Time       = [Double]($storyboard | Select-String "Optics Module" | Select-String "Ramp Time:"     )[-1].line.split(",")[-1].split(":")[-1].split("(")[0].split("s")[0]
$RHID_Optics_Heater_PwmAvg          = [Double]($storyboard | Select-String "Optics Module" | Select-String "PWM Average ="  )[-1].line.split(",")[-1].split("=")[-1].split("(")[0]
$RHID_Optics_Heater_PWM_SD          = [Double]($storyboard | Select-String "Optics Module" | Select-String "PWM SD "        )[-1].line.split(",")[-1].split("=")[-1].s
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

$RHID_Gel_Cooler_TempAvg = [Double]($storyboard |  Select-String "BECInterface" | Select-String "Temp Average:"    | Select-String "(2.5/3.5C)" )[-1].line.split(",")[-1].split(":")[-1].split("(")[0].split("C")[0]
$RHID_Gel_Cooler_VoltAvg = [Double]($storyboard |  Select-String "BECInterface" | Select-String "Voltage Average:" | Select-String "(< 5V)"   )[-1].line.split(",")[-1].split(":")[-1].split("(")[0].split("V")[0]
$RHID_Gel_Cooler_AmpAvg  = [Double]($storyboard |  Select-String "BECInterface" | Select-String "Current Average:" | Select-String "(< 1.5A)" )[-1].line.split(",")[-1].split(":")[-1].split("(")[0].split("A")[0]

Function RHID_Gel_Cooler_Details {
    "$Desc : " + "Gel Cooler Temp Average       = " + "$RHID_Gel_Cooler_TempAvg" + "C (2.5 / 3.5C)"
    "$Desc : " + "Gel Cooler Voltage Average    = " + "$RHID_Gel_Cooler_VoltAvg" + "V (< 5V)"
    "$Desc : " + "Gel Cooler Current Average    = " + "$RHID_Gel_Cooler_AmpAvg"  + "A (< 1.5A)"
}

$RHID_Ambient_TempAvg = [Double]($storyboard | Select-String "Ambient Temp =" | Select-String "(< 40C)")[-1].line.split("=")[-1].split(":")[-1].split("(")[0].split("C")[0]
Function RHID_Ambient_Details {
    "$Desc : " + "Ambient Temp          = " + "$RHID_Ambient_TempAvg" + "C (< 40C)"
}

$RHID_FL_FAT_HomeOffset_Delta = [Double]($storyboard | Select-String "FL FAT: HomeOffset Delta =")[-1].line.split("=")[-1]
$RHID_DL_FAT_HomeOffset_Delta = [Double]($storyboard | Select-String "DL FAT: HomeOffset Delta =")[-1].line.split("=")[-1]
$RHID_PR_FAT_HomeOffset_Delta = [Double]($storyboard | Select-String "PR FAT: HomeOffset Delta =")[-1].line.split("=")[-1]

Function RHID_FAT_HomeOffset_Delta_Details {
    "$Desc : " + "FL FAT: HomeOffset Delta = " + "$RHID_FL_FAT_HomeOffset_Delta" + "(< 20 steps)"
    "$Desc : " + "DL FAT: HomeOffset Delta = " + "$RHID_DL_FAT_HomeOffset_Delta" + "(< 20 steps)"
    "$Desc : " + "PR FAT: HomeOffset Delta = " + "$RHID_PR_FAT_HomeOffset_Delta" + "(< 20 steps)"
}

$RHID_FE_Motor_Test_FL = [Double]($storyboard | Select-String "FL:" | Select-String "(<20%)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("%")[0]
$RHID_FE_Motor_Test_PR = [Double]($storyboard | Select-String "PR:" | Select-String "(<10%)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("%")[0]
$RHID_FE_Motor_Test_DL = [Double]($storyboard | Select-String "DL:" | Select-String "(<25%)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("%")[0]
Function RHID_FE_Motor_Test_Details {
    "$Desc : " + "FL Motor Tested OK At: " + $RHID_FE_Motor_Test_FL + "% (<20%)"
    "$Desc : " + "PR Motor Tested OK At: " + $RHID_FE_Motor_Test_PR + "% (<10%)"
    "$Desc : " + "DL Motor Tested OK At: " + $RHID_FE_Motor_Test_DL + "% (<25%)"
}

$RHID_Homing_Error_Test_FL = [Double]($storyboard | Select-String "FL:" | Select-String "(<0.35 mm)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("mm")[0]
$RHID_Homing_Error_Test_PR = [Double]($storyboard | Select-String "PR:" | Select-String "(<0.35 mm)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("mm")[0]
$RHID_Homing_Error_Test_DL = [Double]($storyboard | Select-String "DL:" | Select-String "(<0.35 mm)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("mm")[0]
Function RHID_Homing_Error_Test_Details {
    "$Desc : " + "FL Motor Homing Error At: " + $RHID_Homing_Error_Test_FL + " mm (<0.35 mm)"
    "$Desc : " + "PR Motor Homing Error At: " + $RHID_Homing_Error_Test_PR + " mm (<0.35 mm)"
    "$Desc : " + "DL Motor Homing Error At: " + $RHID_Homing_Error_Test_DL + " mm (<0.35 mm)"
}

$RHID_FL_Homing_Error_wCAM_FL   = [Double]($storyboard | Select-String "FL:" | Select-String "(<0.35mm)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("mm")[0]
$RHID_FL_Homing_Error_wCAM_CAM5 = [Double]($storyboard | Select-String -SimpleMatch "FL (CAM5):" | Select-String "(<0.35mm)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("mm")[0]
Function RHID_FL_Homing_Error_Details {
    "$Desc : " + "FL Motor Homing Error At:"        + $RHID_FL_Homing_Error_wCAM_FL     + " mm (<0.35 mm)"
    "$Desc : " + "FL Motor CAM5 Homing Error At:"   + $RHID_FL_Homing_Error_wCAM_CAM5   + " mm (<0.35 mm)"
}

#  SCI Antenna Strength = 7 (<= 7)
$RHID_SCI_An_Strength =  [double]($storyboard | Select-String "SCI Antenna Strength =")[-1].line.split(",")[-1].split("=")[1].split("(")[0]

Function RHID_SCI_AntStrength_Details {
    "$Desc : " + "SCI Antenna Strength = " + "$RHID_SCI_An_Strength" + "(<= 7)"
}

$Mezz_Actuator_Offset_55_Current = ($storyboard | Select-String "BECInterface" | Select-String "HomeOffset at 55% Current:").line.split(",")[2, 5, 8, 11].split(":")[1, 3, 5,7]
$Mezz_Actuator_Offset_55_Current_IP = [Double]$Mezz_Actuator_Offset_55_Current[0]
$Mezz_Actuator_Offset_55_Current_PB = [Double]$Mezz_Actuator_Offset_55_Current[1]
$Mezz_Actuator_Offset_55_Current_WV = [Double]$Mezz_Actuator_Offset_55_Current[2]
$Mezz_Actuator_Offset_55_Current_XM = [Double]$Mezz_Actuator_Offset_55_Current[3]
Function RHID_Mezz_Actuator_Offset_55_Current_Details {
    "$Desc : " + "Current Setting IP Motor (Front Left ) Offset = "    + "$Mezz_Actuator_Offset_55_Current_IP"
    "$Desc : " + "Current Setting PB Motor (Front Right) Offset = "    + "$Mezz_Actuator_Offset_55_Current_PB"
    "$Desc : " + "Current Setting WV Motor (Rear Left  ) Offset = "    + "$Mezz_Actuator_Offset_55_Current_WV"
    "$Desc : " + "Current Setting XM Motor (Rear Right ) Offset = "    + "$Mezz_Actuator_Offset_55_Current_XM"
}

$Mezz_Actuator_Offset_35_Current = ($storyboard | Select-String "BECInterface" | Select-String "HomeOffset at 35% Current:").Line.split(",")[2, 5, 8, 11].split(":")[1, 3, 5, 7]
    $Mezz_Actuator_Offset_35_Current_IP = [Double]$Mezz_Actuator_Offset_35_Current[0]
    $Mezz_Actuator_Offset_35_Current_PB = [Double]$Mezz_Actuator_Offset_35_Current[1]
    $Mezz_Actuator_Offset_35_Current_WV = [Double]$Mezz_Actuator_Offset_35_Current[2]
    $Mezz_Actuator_Offset_35_Current_XM = [Double]$Mezz_Actuator_Offset_35_Current[3]
Function RHID_Mezz_Actuator_Offset_35_Current_Details {
    "$Desc : " + "Current Setting IP Motor (Front Left ) Offset = "    + "$Mezz_Actuator_Offset_35_Current_IP"
    "$Desc : " + "Current Setting PB Motor (Front Right) Offset = "    + "$Mezz_Actuator_Offset_35_Current_PB"
    "$Desc : " + "Current Setting WV Motor (Rear Left  ) Offset = "    + "$Mezz_Actuator_Offset_35_Current_WV"
    "$Desc : " + "Current Setting XM Motor (Rear Right ) Offset = "    + "$Mezz_Actuator_Offset_35_Current_XM"
}

$Mezz_Actuator_Offset_Delta     = ($storyboard | Select-String "BECInterface" | Select-String "HomeOffset Delta:").Line.split(",")[2, 5, 8, 11].split(":").split("(")[1, 4, 7,10]
$Mezz_Actuator_Offset_Delta_IP = [Double]$Mezz_Actuator_Offset_Delta[0]
$Mezz_Actuator_Offset_Delta_PB = [Double]$Mezz_Actuator_Offset_Delta[1]
$Mezz_Actuator_Offset_Delta_WV = [Double]$Mezz_Actuator_Offset_Delta[2]
$Mezz_Actuator_Offset_Delta_XM = [Double]$Mezz_Actuator_Offset_Delta[3]

Function RHID_Mezz_Actuator_Offset_Details {
    "$Desc : " + "Mezzanine Actuator IP Motor (Front Left ) Offset Delta = "    + "$Mezz_Actuator_Offset_Delta_IP" + "(< 20 steps)"
    "$Desc : " + "Mezzanine Actuator PB Motor (Front Right) Offset Delta = "    + "$Mezz_Actuator_Offset_Delta_PB" + "(< 20 steps)"
    "$Desc : " + "Mezzanine Actuator WV Motor (Rear Left  ) Offset Delta = "    + "$Mezz_Actuator_Offset_Delta_WV" + "(< 20 steps)"
    "$Desc : " + "Mezzanine Actuator XM Motor (Rear Right ) Offset Delta = "    + "$Mezz_Actuator_Offset_Delta_XM" + "(< 20 steps)"
}

$RHID_HP_HomeOffset = [Double]($storyboard | Select-String "HP FAT: HomeOffset Delta =" | Select-String "(< 20 steps)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("steps")[0]
Function RHID_HP_HomeOffset_Details {
    "$Desc : " + "HP HomeOffset = " + "$RHID_HP_HomeOffset" + "(< 20 steps)"
}

$RHID_LP_HomeOffset = [Double]($storyboard | Select-String "LP FAT: HomeOffset Delta =")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("steps")[0]
Function RHID_LP_HomeOffset_Details {
    "$Desc : " + "LP HomeOffset = " + "$RHID_LP_HomeOffset" + "(< 20 steps)"
}

$RHID_HP_Min_Current = [Double]($storyboard | Select-String "HP FAT: Minimum Current =" | Select-String "(<25%)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
Function RHID_HP_Current_Details {
    "$Desc : " + "HP Minimum Current = " + "$RHID_HP_Min_Current" + "% (<25%)"
}

$RHID_LP_Min_Current = [Double]($storyboard | Select-String "LP FAT: Minimum Current =" | Select-String "(<25%)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
Function RHID_LP_Current_Details {
    "$Desc : " + "LP Minimum Current = " + "$RHID_LP_Min_Current" + "% (<25%)"
}

$RHID_BEC_Interlock_Top = [Double]($storyboard | Select-String "BEC Interlock (Top):")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
$RHID_BEC_Interlock_Bottom = [Double]($storyboard | Select-String "BEC Interlock (Bottom):")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
Function RHID_BEC_Interlock_Details {
    "$Desc : " + "BEC Interlock (Top): " + "$RHID_BEC_Interlock_Top" + "C (< 5V)"
    "$Desc : " + "BEC Interlock (Bottom): " + "$RHID_BEC_Interlock_Bottom" + "C (< 5V)"
}

$RHID_Gel_Antenna_Strength_High = [Double]($storyboard | Select-String "Gel Antenna Strength (High):")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
Function RHID_Gel_Antenna_Strength_Details {
    "$Desc : " + "Gel Antenna Strength (High): " + "$RHID_Gel_Antenna_Strength_High" + "(>= 7)"
}

$RHID_Gel_Antenna_Strength_Low = [Double]($storyboard | Select-String "Gel Antenna Strength (Low):")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
Function RHID_Gel_Antenna_Strength_Details {
    "$Desc : " + "Gel Antenna Strength (Low): " + "$RHID_Gel_Antenna_Strength_Low" + "(>= 3)"
}

$RHID_MezzBoard_Start_Temp      = [Double]($storyboard | Select-String "Instrument" | Select-String "Start Temp ="      )[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
$RHID_MezzBoard_Temp_Ramp_Rate  = [Double]($storyboard | Select-String "Instrument" | Select-String "Temp Ramp Rate ="  )[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C/s")[0]
$RHID_MezzBoard_Ramp_Start      = [Double]($storyboard | Select-String "Instrument" | Select-String "Ramp Start :"      )[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
$RHID_MezzBoard_Ramp_End        = [Double]($storyboard | Select-String "Instrument" | Select-String "Ramp End :"        )[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]
$RHID_MezzBoard_Ramp_Time       = [Double]($storyboard | Select-String "Instrument" | Select-String "Ramp Time :"       )[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("s")[0]
$RHID_MezzBoard_Time_to_60C     = [Double]($storyboard | Select-String "Instrument" | Select-String "Time to 60C ="     )[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("s")[0]
$RHID_MezzBoard_Temp_Avg        = [Double]($storyboard | Select-String "Instrument" | Select-String "Temp Avg ="        )[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("C")[0]

<#
$RHID_MezzBoard_Z1_Start_Temp = 
$RHID_MezzBoard_Z1_Temp_Ramp_Rate = 
$RHID_MezzBoard_Z1_Ramp_Start = 
$RHID_MezzBoard_Z1_Ramp_End = 
$RHID_MezzBoard_Z1_Ramp_Time = 
$RHID_MezzBoard_Z1_Time_to_60C = 
$RHID_MezzBoard_Z1_Temp_Avg = 

$RHID_MezzBoard_Z3_Start_Temp = 
$RHID_MezzBoard_Z3_Temp_Ramp_Rate = 
$RHID_MezzBoard_Z3_Ramp_Start = 
$RHID_MezzBoard_Z3_Ramp_End = 
$RHID_MezzBoard_Z3_Ramp_Time = 
$RHID_MezzBoard_Z3_Time_to_60C = 
$RHID_MezzBoard_Z3_Temp_Avg = 

$RHID_MezzBoard_CAT_Start_Temp = 
$RHID_MezzBoard_CAT_Temp_Ramp_Rate = 
$RHID_MezzBoard_CAT_Ramp_Start = 
$RHID_MezzBoard_CAT_Ramp_End = 
$RHID_MezzBoard_CAT_Ramp_Time = 
$RHID_MezzBoard_CAT_Time_to_60C = 
$RHID_MezzBoard_CAT_Temp_Avg = 


Start Temp      = 33.32C (<35 C)
Temp Ramp Rate  = 0.333C/s
Ramp Start      : 35C
Ramp End        : 50C
Ramp Time       : 45.01s
Time to 60C     = 90.47s
Temp Avg        = 60.01C (59.5 / 60.5 C)




Instrument               , CAT Took: 319.27 s
Instrument               ,    CAT Ramp Rate to 38 : 0.151 C/s
Instrument               , Z1 Took: 90.47 s
Instrument               ,    Z1 Ramp Rate to 50 : 0.333 C/s
Instrument               , Z3 Took: 28.74 s
Instrument               ,    Z3 Ramp Rate to 50 : 0.952 C/s

Instrument               , ===============
Instrument               , MezzBoard FAT: PASS
Instrument               , Z1
Instrument               ,      Start Temp      = 33.32C (<35 C)
Instrument               ,      Temp Ramp Rate  = 0.333C/s
Instrument               ,      Ramp Start      : 35C
Instrument               ,      Ramp End        : 50C
Instrument               ,      Ramp Time           : 45.01s
Instrument               ,      Time to 60C     = 90.47s
Instrument               ,      Temp Avg        = 60.01C (59.5/60.5 C)
Instrument               , Z3
Instrument               ,      Start Temp = 33.41C (<35 C)
Instrument               ,      Temp Ramp Rate = 0.952C/s
Instrument               ,          Ramp Start: 35C
Instrument               ,          Ramp End: 50.02C
Instrument               ,          Ramp Time: 15.77s
Instrument               ,      Time to 60C = 28.74s
Instrument               ,      Temp Avg = 60C (59.5/60.5 C)
Instrument               , CAT
Instrument               ,      Start Temp = 26.98C (<35 C)
Instrument               ,      Temp Ramp Rate = 0.151C/s
Instrument               ,          Ramp Start: 35C
Instrument               ,          Ramp End: 38.02C
Instrument               ,          Ramp Time: 20.03s
Instrument               ,      Time to 42 C = 319.27s
Instrument               ,      Temp Avg = 41.74C (41/43 C)"
#>