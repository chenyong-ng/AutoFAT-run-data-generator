
#>
# Master copy of the data extraction method, when the value is sandwitched between text that need to be discarded.
# $Storyboard = Get-ChildItem "U:\RHID-0855" -I storyboard*.txt -R | Sort-Object LastWriteTime -ErrorAction SilentlyContinue
# Will be useful in the future when XML or HTML implementations are sucessfull

$RHID_Lysis1_Ramp       = [Double]($storyboard | Select-String "Lysis1 Ramp Rate ="       )[-1].line.split("=")[-1].replace("C/s","")
$RHID_Lysis1_Temp_Avg   = [Double]($storyboard | Select-String "Lysis1 Temp Average ="    )[-1].line.split("=")[-1].replace("C (84.5/85.5C)","")
$RHID_Lysis1_Temp_SD    = [Double]($storyboard | Select-String "Lysis1 Temp SD ="         )[-1].line.split("=")[-1].replace("C (< 0.25C)","")
$RHID_Lysis1_Pwm_Avg    = [Double]($storyboard | Select-String "Lysis1 PWM Average ="     )[-1].line.split("=")[-1].replace("(0/2600)","")
$RHID_Lysis1_PWM_SD     = [Double]($storyboard | Select-String "Lysis1 PWM SD ="          )[-1].line.split("=")[-1].replace("(< 1000)","")

$RHID_Lysis2_Ramp       = [Double]($storyboard | Select-String "Lysis2 Ramp Rate ="       )[-1].line.split("=")[-1].replace("C/s","")
$RHID_Lysis2_Temp_Avg   = [Double]($storyboard | Select-String "Lysis2 Temp Average ="    )[-1].line.split("=")[-1].replace("C (84.5/85.5C)","")
$RHID_Lysis2_Temp_SD    = [Double]($storyboard | Select-String "Lysis2 Temp SD ="         )[-1].line.split("=")[-1].replace("C (< 0.25C)","")
$RHID_Lysis2_Pwm_Avg    = [Double]($storyboard | Select-String "Lysis2 PWM Average ="     )[-1].line.split("=")[-1].replace("(0/8000)","")
$RHID_Lysis2_PWM_SD     = [Double]($storyboard | Select-String "Lysis2 PWM SD ="          )[-1].line.split("=")[-1].replace("(< 1000)","")
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

$RHID_DN_Temp_Avg       = [Double]($storyboard | Select-String "Denature Heater" | Select-String "Temp Average ="     )[-1].line.split("=")[-1].replace("C (94.5/95.5C)","")
$RHID_DN_Temp_Max       = [Double]($storyboard | Select-String "Denature Heater" | Select-String "Temp Max Reached =" )[-1].line.split("=")[-1].replace("C (< 105C)","")
$RHID_DN_Temp_Ramp_Rate_80C     = [Double]($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Temp Ramp Rate (80C) ="    )[-1].line.split("=")[-1].replace("C/s","")
$RHID_DN_Total_Ramp_Time_80C    = [Double]($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Total Ramp Time (80C) ="   )[-1].line.split("=")[-1].replace("s (< 60s)","")
$RHID_DN_Total_Ramp_Time_94C    = [Double]($storyboard | Select-String "Denature Heater" | Select-String -SimpleMatch "Total Ramp Time (94C) ="   )[-1].line.split("=")[-1].replace("s","")

$RHID_DN_Max_96C        = [Double]($storyboard | Select-String "Denature Heater" | Select-String "Max to 96C ="   )[-1].line.split("=")[-1].replace("s (> 20s)","")
$RHID_DN_Temp_SD        = [Double]($storyboard | Select-String "Denature Heater" | Select-String "Temp SD ="      )[-1].line.split("=")[-1].replace("C (< 0.25C)","")
$RHID_DN_Pwm_Avg        = [Double]($storyboard | Select-String "Denature Heater" | Select-String "PWM Average ="  )[-1].line.split("=")[-1].replace("(< 2500)","")
$RHID_DN_PWM_SD         = [Double]($storyboard | Select-String "Denature Heater" | Select-String "PWM SD ="       )[-1].line.split("=")[-1].replace("(< 500)","")
Function RHID_DN_Heater_Details {
    "$Desc : " + "DN Temp Average          = " + "$RHID_DN_Temp_Avg"            + "C (94.5 / 95.5C)"
    "$Desc : " + "DN Temp Max Reached      = " + "$RHID_DN_Temp_Max"            + "C (< 105C)"
    "$Desc : " + "DN Temp Ramp Rate (80C)  = " + "$RHID_DN_Temp_Ramp_Rate_80C"  + "C/s"
    "$Desc : " + "DN Total Ramp Time (80C) = " + "$RHID_DN_Total_Ramp_Time_80C" + "s (< 60s)"
    "$Desc : " + "DN Total Ramp Time (94C) = " + "$RHID_DN_Total_Ramp_Time_94C" + "s"
    "$Desc : " + "DN Max to 96C            = " + "$RHID_DN_Max_96C"             + "s (> 20s)"
    "$Desc : " + "DN Temp SD               = " + "$RHID_DN_Temp_SD"             + "C (< 0.25C)"
    "$Desc : " + "DN PWM Average           = " + "$RHID_DN_Pwm_Avg"             + "(< 2500)"
    "$Desc : " + "DN PWM SD                = " + "$RHID_DN_PWM_SD"              + "(< 500)"
}

# PCR AMBIENT
$RHID_PCR_Top_Amb       = [Double]($storyboard | Select-String "PCR Top Ambient ="    )[-1].line.split("=")[-1].replace("C","")
$RHID_PCR_Bot_Amb       = [Double]($storyboard | Select-String "PCR Bottom Ambient =" )[-1].line.split("=")[-1].replace("C","")
$RHID_PCR_Amb_TopBot_Del = [Double]($storyboard | Select-String -SimpleMatch "PCR Ambient Top/Bot Delta =" )[-1].line.split("=")[-1].replace("C (< 1.5C)", "")
# PCR LOW 9C
$RHID_PCR_Top_9C_Avg    = [Double]($storyboard | Select-String "PCR Top 9C Average =" )[-1].line.split("=")[-1].replace("C (8/10C)","")
$RHID_PCR_Top_SD_9C     = [Double]($storyboard | Select-String "PCR Top SD 9C ="      )[-1].line.split("=")[-1].replace("C (< 0.25C)","")
$RHID_PCR_Bot_9C_Avg    = [Double]($storyboard | Select-String "PCR Bottom 9C Average =" )[-1].line.split("=")[-1].replace("C (8/10C)","")
$RHID_PCR_Bot_SD_9C     = [Double]($storyboard | Select-String "PCR Bottom SD 9C ="   )[-1].line.split("=")[-1].replace("C (< 0.25C)","")
$RHID_PCR_9C_TopBot_Del = [Double]($storyboard | Select-String -SimpleMatch "PCR 9C Top / Bot Delta =" )[-1].line.split("=")[-1].replace("C (< 1C)", "")
# PCR HIGH 98C
$RHID_PCR_Top_98C_Avg   = [Double]($storyboard | Select-String "PCR Top 98C Average =")[-1].line.split("=")[-1].replace("C (97.5/98.5C)", "")
$RHID_PCR_Top_SD_98C    = [Double]($storyboard | Select-String "PCR Top SD 98C ="     )[-1].line.split("=")[-1].replace("C (< 0.25C)","")
$RHID_PCR_Bot_98C_Avg   = [Double]($storyboard | Select-String "PCR Bottom 98C Average =" )[-1].line.split("=")[-1].replace("C (97.5/98.5C)","")
$RHID_PCR_Bot_SD_98C    = [Double]($storyboard | Select-String "PCR Bottom SD 98C ="  )[-1].line.split("=")[-1].replace("C (< 0.25C)","")
$RHID_PCR_98C_TopBot_Del = [Double]($storyboard | Select-String -SimpleMatch "PCR 98C Top / Bot Delta =" )[-1].line.split("=")[-1].replace("C (< 0.5C)", "")

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

$RHID_Optics_Heater_TempAvg         = [Double]($storyboard | Select-String "Optics Module" | Select-String "Temp Average ="   )[-1].line.split("=")[-1].replace("C (41.5/42.5C)", "")
$RHID_Optics_Heater_Temp_SD         = [Double]($storyboard | Select-String "Optics Module" | Select-String "Temp SD ="        )[-1].line.split("=")[-1].replace("C (< 0.1C)", "")
$RHID_Optics_Heater_Temp_Ramp_Rate  = [Double]($storyboard | Select-String "Optics Module" | Select-String "Temp Ramp Rate"   )[-1].line.split("=")[-1].replace("C/s", "")
$RHID_Optics_Heater_Ramp_Start      = [Double]($storyboard | Select-String "Optics Module" | Select-String "Ramp Start:"      )[-1].line.split(":")[-1].replace("C (30C)", "")

$RHID_Optics_Heater_Ramp_End        = [Double]($storyboard | Select-String "Optics Module" | Select-String "Ramp End:"      )[-1].line.split(":")[-1].replace("C (40C)", "")
$RHID_Optics_Heater_Ramp_Time       = [Double]($storyboard | Select-String "Optics Module" | Select-String "Ramp Time:"     )[-1].line.split(":")[-1].replace("s (< 80s)", "")
$RHID_Optics_Heater_PwmAvg          = [Double]($storyboard | Select-String "Optics Module" | Select-String "PWM Average ="  )[-1].line.split("=")[-1].replace("(< 10500)", "")
$RHID_Optics_Heater_PWM_SD          = [Double]($storyboard | Select-String "Optics Module" | Select-String "PWM SD ="        )[-1].line.split("=")[-1].replace("(< 1000)", "")
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

$RHID_Gel_Cooler_TempAvg    = [Double]($storyboard |  Select-String "BECInterface" | Select-String "Temp Average:"    | Select-String "(2.5/3.5C)" )[-1].line.split(":")[-1].replace("C (2.5/3.5C)", "")
$RHID_Gel_Cooler_VoltAvg    = [Double]($storyboard |  Select-String "BECInterface" | Select-String "Voltage Average:" | Select-String "(< 5V)"   )[-1].line.split(":")[-1].replace("V (< 5V)", "")
$RHID_Gel_Cooler_AmpAvg     = [Double]($storyboard |  Select-String "BECInterface" | Select-String "Current Average:" | Select-String "(< 1.5A)" )[-1].line.split(":")[-1].replace("A (< 1.5A)", "")

Function RHID_Gel_Cooler_Details {
    "$Desc : " + "Gel Cooler Temp Average       = " + "$RHID_Gel_Cooler_TempAvg" + "C (2.5 / 3.5C)"
    "$Desc : " + "Gel Cooler Voltage Average    = " + "$RHID_Gel_Cooler_VoltAvg" + "V (< 5V)"
    "$Desc : " + "Gel Cooler Current Average    = " + "$RHID_Gel_Cooler_AmpAvg"  + "A (< 1.5A)"
}

$RHID_Ambient_TempAvg = [Double]($storyboard | Select-String "Ambient Temp =" | Select-String "(< 40C)")[-1].line.split("=")[-1].replace("C (< 40C)", "")
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

$RHID_FE_Motor_Test_FL = [Double]($storyboard | Select-String "FL:" | Select-String "(<20%)")[-1].line.split(",")[-1].split(":")[-1].replace("% (<20%)", "")
$RHID_FE_Motor_Test_PR = [Double]($storyboard | Select-String "PR:" | Select-String "(<10%)")[-1].line.split(",")[-1].split(":")[-1].replace("% (<10%)", "")
$RHID_FE_Motor_Test_DL = [Double]($storyboard | Select-String "DL:" | Select-String "(<25%)")[-1].line.split(",")[-1].split(":")[-1].replace("% (<25%)", "")
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

$RHID_FL_Homing_Error_wCAM_FL   = [Double]($storyboard | Select-String "FL:"                        | Select-String "(<0.35mm)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("mm")[0]
$RHID_FL_Homing_Error_wCAM_CAM5 = [Double]($storyboard | Select-String -SimpleMatch "FL (CAM5):"    | Select-String "(<0.35mm)")[-1].line.split(":")[-1].split(":")[-1].split("(")[0].split("mm")[0]
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

$RHID_LP_HomeOffset = [Double]($storyboard | Select-String "LP FAT: HomeOffset Delta =").line.split("=")[-1]
Function RHID_LP_HomeOffset_Details {
    "$Desc : " + "LP HomeOffset = " + "$RHID_LP_HomeOffset" + "(< 20 steps)"
}

$RHID_HP_HomeOffset = [Double]($storyboard | Select-String "HP FAT: HomeOffset Delta =" ).line.split("=")[-1]
Function RHID_HP_HomeOffset_Details {
    "$Desc : " + "HP HomeOffset = " + "$RHID_HP_HomeOffset" + "(< 20 steps)"
}

$RHID_HP_Min_Current = [Double]($storyboard | Select-String "HP Minimum Current =" | Select-String "(<25%)")[-1].line.split("=")[-1].replace("% (<25%)", "")
$RHID_LP_Min_Current = [Double]($storyboard | Select-String "LP Minimum Current =" | Select-String "(<25%)")[-1].line.split("=")[-1].replace("% (<25%)", "")
Function RHID_Anode_Motor_Details {
    "$Desc : " + "HP Minimum Current = " + "$RHID_HP_Min_Current" + "% (<25%)"
    "$Desc : " + "LP Minimum Current = " + "$RHID_LP_Min_Current" + "% (<25%)"
}

$RHID_BEC_Interlock_Top     = ($storyboard | Select-String -SimpleMatch "BEC Interlock (Top):")[-1].line.split("(Top):")[-1].Trim()
 $RHID_BEC_Interlock_Bottom = ($storyboard | Select-String -SimpleMatch "BEC Insertion Interlock (Bottom)")[-1].line.split("(Bottom):")[-1].Trim()
Function RHID_BEC_Interlock_Details {
    "$Desc : " + "BEC Interlock (Top): " + "$RHID_BEC_Interlock_Top"
    "$Desc : " + "BEC Interlock (Bottom): " + "$RHID_BEC_Interlock_Bottom"
}

$RHID_Gel_Antenna_Strength_High = [Double]($storyboard | Select-String -simplematch "Gel Antenna Strength (High) =")[-1].line.replace("(>= 7)", "").split("=")[-1]
Function RHID_Gel_Antenna_Strength_High_Details {
    "$Desc : " + "Gel Antenna Strength (High): " + "$RHID_Gel_Antenna_Strength_High" + "(>= 7)"
}

$RHID_Gel_Antenna_Strength_Low = [Double]($storyboard | Select-String -SimpleMatch "Gel Antenna Strength (Low) =")[-1].line.replace("(>= 3)", "").split("=")[-1]
Function RHID_Gel_Antenna_Strength_Low_Details {
    "$Desc : " + "Gel Antenna Strength (Low): " + "$RHID_Gel_Antenna_Strength_Low" + "(>= 3)"
}

$RHID_MezzBoard_Start_Temp      = ($storyboard | Select-String "Instrument" | Select-String "Start Temp ="  | Select-String "(<35 C)")[-3..-1].line.split("=")[1, 3, 5].split("(")[0, 2, 4].replace("C","")
$RHID_MezzBoard_Temp_Ramp_Rate  = ($storyboard | Select-String "Instrument" | Select-String "Temp Ramp Rate ="  )[-3..-1].line.split("=")[1, 3, 5].split("C")[0, 2, 4].replace("C/s","")
$RHID_MezzBoard_Ramp_Start      = ((($storyboard | Select-String "Instrument" | Select-String "Ramp Start:"     )[-3..-1].line.Split(",")) -Match "Ramp Start:" ).split(":")[1, 3, 5].replace("C","")
$RHID_MezzBoard_Ramp_End        = ((($storyboard | Select-String "Instrument" | Select-String "Ramp End:"       )[-3..-1].line.Split(",")) -Match "Ramp End:"   ).split(":")[1, 3, 5].replace("C","")
$RHID_MezzBoard_Ramp_Time       = ((($storyboard | Select-String "Instrument" | Select-String "Ramp Time:"      )[-3..-1].line.Split(",")) -Match "Ramp Time:"  ).split(":")[1, 3, 5].replace("s","")
$RHID_MezzBoard_Time_to_60C     = ($storyboard | Select-String "Instrument" | Select-String "Time to 60C ="     )[-2,-1].line.split("=")[1,3].replace("s","")   # Mezz PCB and BEC Z1+Z3 Heaters
$RHID_MezzBoard_Time_to_42C     = ($storyboard | Select-String "Instrument" | Select-String "Time to 42 C ="    )[-1].line.split("=")[-1].replace("s","")       # Mezz PCB and BEC Cathode Heaters
$RHID_MezzBoard_Temp_Avg_60C    = ($storyboard | Select-String "Instrument" | Select-String "Temp Avg ="    | Select-String "(59.5/60.5 C)" )[-2, -1].line.split("=")[1, 3].replace("C (59.5/60.5 C)", "")
$RHID_MezzBoard_Temp_Avg_42C    = ($storyboard | Select-String "Instrument" | Select-String "Temp Avg ="    | Select-String "(41/43 C)"     )[-1].line.split("=")[-1].replace("C (41/43 C)", "")

$RHID_MezzBoard_Start_Temp_Z1       = [Double]$RHID_MezzBoard_Start_Temp[0]
$RHID_MezzBoard_Start_Temp_Z3       = [Double]$RHID_MezzBoard_Start_Temp[1]
$RHID_MezzBoard_Start_Temp_CAT      = [Double]$RHID_MezzBoard_Start_Temp[2]
$RHID_MezzBoard_Temp_Ramp_Rate_Z1   = [Double]$RHID_MezzBoard_Temp_Ramp_Rate[0]
$RHID_MezzBoard_Temp_Ramp_Rate_Z3   = [Double]$RHID_MezzBoard_Temp_Ramp_Rate[1]
$RHID_MezzBoard_Temp_Ramp_Rate_CAT  = [Double]$RHID_MezzBoard_Temp_Ramp_Rate[2]
$RHID_MezzBoard_Ramp_Start_Z1       = [Double]$RHID_MezzBoard_Ramp_Start[0]
$RHID_MezzBoard_Ramp_Start_Z3       = [Double]$RHID_MezzBoard_Ramp_Start[1]
$RHID_MezzBoard_Ramp_Start_CAT      = [Double]$RHID_MezzBoard_Ramp_Start[2]
$RHID_MezzBoard_Ramp_End_Z1         = [Double]$RHID_MezzBoard_Ramp_End[0]
$RHID_MezzBoard_Ramp_End_Z3         = [Double]$RHID_MezzBoard_Ramp_End[1]
$RHID_MezzBoard_Ramp_End_CAT        = [Double]$RHID_MezzBoard_Ramp_End[2]
$RHID_MezzBoard_Ramp_Time_Z1        = [Double]$RHID_MezzBoard_Ramp_Time[0]
$RHID_MezzBoard_Ramp_Time_Z3        = [Double]$RHID_MezzBoard_Ramp_Time[1]
$RHID_MezzBoard_Ramp_Time_CAT       = [Double]$RHID_MezzBoard_Ramp_Time[2]
$RHID_MezzBoard_Time_to_60C_Z1      = [Double]$RHID_MezzBoard_Time_to_60C[0]
$RHID_MezzBoard_Time_to_60C_Z3      = [Double]$RHID_MezzBoard_Time_to_60C[1]
$RHID_MezzBoard_Time_Cathode        = [Double]$RHID_MezzBoard_Time_to_42C
$RHID_MezzBoard_Temp_Avg_60C_Z1     = [Double]$RHID_MezzBoard_Temp_Avg_60C[0]
$RHID_MezzBoard_Temp_Avg_60C_Z3     = [Double]$RHID_MezzBoard_Temp_Avg_60C[1]
$RHID_MezzBoard_Temp_Avg_Cathode    = [Double]$RHID_MezzBoard_Temp_Avg_42C 

function MezzBoard_Test_Details {
    "$Desc : " + "Capillary Z1 Heater"
    "$Desc : " + "Start Temp      = " + "$RHID_MezzBoard_Start_Temp_Z1"     +"C (<35 C)"
    "$Desc : " + "Temp Ramp Rate  = " + "$RHID_MezzBoard_Temp_Ramp_Rate_Z1" +"C/s"
    "$Desc : " + "Ramp Start      = " + "$RHID_MezzBoard_Ramp_Start_Z1"     +"C"
    "$Desc : " + "Ramp End        = " + "$RHID_MezzBoard_Ramp_End_Z1"       +"C"
    "$Desc : " + "Ramp Time       = " + "$RHID_MezzBoard_Ramp_Time_Z1"      +"s"
    "$Desc : " + "Time to 60C     = " + "$RHID_MezzBoard_Time_to_60C_Z1"    +"s"
    "$Desc : " + "Temp Avg        = " + "$RHID_MezzBoard_Temp_Avg_60C_Z1"   +"C (59.5 / 60.5 C)"
    "$Desc : " + "Capillary Z3 Heater"
    "$Desc : " + "Start Temp      = " + "$RHID_MezzBoard_Start_Temp_Z3"     +"C (<35 C)"
    "$Desc : " + "Temp Ramp Rate  = " + "$RHID_MezzBoard_Temp_Ramp_Rate_Z3" +"C/s"
    "$Desc : " + "Ramp Start      = " + "$RHID_MezzBoard_Ramp_Start_Z3"     +"C"
    "$Desc : " + "Ramp End        = " + "$RHID_MezzBoard_Ramp_End_Z3"       +"C"
    "$Desc : " + "Ramp Time       = " + "$RHID_MezzBoard_Ramp_Time_Z3"      +"s"
    "$Desc : " + "Time to 60C     = " + "$RHID_MezzBoard_Time_to_60C_Z3"    +"s"
    "$Desc : " + "Temp Avg        = " + "$RHID_MezzBoard_Temp_Avg_60C_Z3"   +"C (59.5 / 60.5 C)"
    "$Desc : " + "Cathode Block Heater"
    "$Desc : " + "Start Temp      = " + "$RHID_MezzBoard_Start_Temp_CAT"    +"C (<35 C)"
    "$Desc : " + "Temp Ramp Rate  = " + "$RHID_MezzBoard_Temp_Ramp_Rate_CAT"+"C/s"
    "$Desc : " + "Ramp Start      = " + "$RHID_MezzBoard_Ramp_Start_CAT"    +"C"
    "$Desc : " + "Ramp End        = " + "$RHID_MezzBoard_Ramp_End_CAT"      +"C"
    "$Desc : " + "Ramp Time       = " + "$RHID_MezzBoard_Ramp_Time_CAT"     +"s"
    "$Desc : " + "Time to 42C     = " + "$RHID_MezzBoard_Time_Cathode"      +"s"
    "$Desc : " + "Temp Avg        = " + "$RHID_MezzBoard_Temp_Avg_Cathode"  +"C (41/43 C)"
}


# $Result_Separator             = "################################"
$Bolus_Folder                 = "$Path-$IndexedSerialNumber\*Bolus Delivery Test*"
#$US_Bolus_Folder              = "$US_Path-$IndexedSerialNumber\*Bolus Delivery Test*"
$RHID_Bolus_Test_Result_Image   = (Get-ChildItem "$Bolus_Folder", "$US_Bolus_Folder" -I BolusInject_*.png -R | Sort-Object LastWriteTime)
$RHID_Bolus_DN                  = (($Storyboard_Bolus_Test_Folder | Select-String "% in DN ="      ).line.split(",") | Select-String "% in DN ="      ).line.replace("% in DN =", ""      ).replace("%", "")
$RHID_Bolus_Volume              = (($Storyboard_Bolus_Test_Folder | Select-String "Volume  ="      ).line.split(",") | Select-String "Volume  ="      ).line.replace("Volume  =", ""      ).replace("uL", "")
$RHID_Bolus_Timing              = (($Storyboard_Bolus_Test_Folder | Select-String "Timing ="       ).line.split(",") | Select-String "Timing ="       ).line.replace("Timing =", ""       ).replace("s","")
$RHID_Bolus_Current             = (($Storyboard_Bolus_Test_Folder | Select-String "Bolus Current =").line.split(",") | Select-String "Bolus Current =").line.replace("Bolus Current =", "").replace("uA", "")
$i = $RHID_Bolus_Test_Result_Folder.count
$i = 0
function GetBolusData {
foreach ($RHID_Bolus_Test_Result_Folder in $RHID_Bolus_DN) {
    if ( $RHID_Bolus_Test_Result_Folder.count -gt 0) {
        #$Result_Separator
        $Bolust_Image           = ($Drive + "\" + $MachineName + "\" + $RHID_Bolus_Test_Result_Image.directory.name[$i] + "\" + $RHID_Bolus_Test_Result_Image.name[$i])
        $Bolust_Image_HTML      = ($Drive + "/" + $MachineName + "/" + $RHID_Bolus_Test_Result_Image.directory.name[$i] + "/" + $RHID_Bolus_Test_Result_Image.name[$i]).replace("\","/").replace("#","%23")
        $Bolus_Test_Counter     = [Double]($i + 1)
        $RHID_Bolus_DN_Var      = [Double]$RHID_Bolus_DN[$i]
        $RHID_Bolus_Volume_Var  = [Double]$RHID_Bolus_Volume[$i]
        $RHID_Bolus_Timing_Var  = [Double]$RHID_Bolus_Timing[$i]
        $RHID_Bolus_Current_Var = [Double]$RHID_Bolus_Current[$i]
        "Test_Counter,$Bolus_Test_Counter"
        "DN_Percentage,$RHID_Bolus_DN_Var,%"
        "Volume,$RHID_Bolus_Volume_Var,uL"
        "Timing,$RHID_Bolus_Timing_Var,s"
        "BolusCurrent,$RHID_Bolus_Current_Var,uA"
        "Image,$Bolust_Image"
        $i = $i + 1
        # Generate HTML Report with Bolus testimages
    }
}
}
$BolusDataObj = (GetBolusData | ConvertFrom-String -Delimiter ',' -PropertyNames Type, Value, Unit | select-object -skip 0)
$BolusDataObj | Out-File "$Drive\$MachineName\Internal\RapidHIT ID\Results\BolusDataObj.txt"

function GetBolusDataXML {
    foreach ($RHID_Bolus_Test_Result_Folder in $RHID_Bolus_DN) {
        if ( $RHID_Bolus_Test_Result_Folder.count -gt 0) {
            $Bolust_Image = ($Drive + "\" + $MachineName + "\" + $RHID_Bolus_Test_Result_Image.directory.name[$i] + "\" + $RHID_Bolus_Test_Result_Image.name[$i])
            $Bolus_Test_Counter     = [Double]($i + 1)
            $RHID_Bolus_DN_Var      = [Double]$RHID_Bolus_DN[$i]
            $RHID_Bolus_Volume_Var  = [Double]$RHID_Bolus_Volume[$i]
            $RHID_Bolus_Timing_Var  = [Double]$RHID_Bolus_Timing[$i]
            $RHID_Bolus_Current_Var = [Double]$RHID_Bolus_Current[$i]     
@"
<Bolus_Test>
    <Counter>$Bolus_Test_Counter</Counter>
    <Percentage>$RHID_Bolus_DN_Var</Percentage>
    <Volume>$RHID_Bolus_Volume_Var</Volume>
    <Timing>$RHID_Bolus_Timing_Var</Timing>
    <Current>$RHID_Bolus_Current_Var</Current>
    <Image>$Bolust_Image</Image>
</Bolus_Test>
"@
            $i = $i + 1
            # Generate HTML Report with Bolus testimages
        }
    }
}

[XML]$xmlMmat   = (Get-Content -Encoding utf8 -Raw "$TempXMLFile")
$xmlFragment    = $xmlMmat.CreateDocumentFragment()
$xmlFragment.InnerXml = GetBolusDataXML
$null   = $xmlMmat.TestReport.AppendChild($xmlFragment)
$xmlMmat.save("$TempXMLFile")
$xmlWriter.Flush()
$xmlWriter.Dispose()

$RHID_Piezo_FAT_Details          = $storyboard | Select-String "Bolus Current =" | Select-String "nA" 

Function RHID_Piezo_FAT_Details {
    "$Desc : " + "Mezz PCB + BEC Peizo Pump Test" + "$RHID_Piezo_FAT_Details" + "nA"
}