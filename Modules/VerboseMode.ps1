Function RHID_Heater_Verbose {
        "$DebugStr : [Lysis Heater Pass Counter ] : " + $RHID_Lysis_Heater_FAT_PASS.count
    if ($RHID_Lysis_Heater_FAT_PASS.count -gt 0) {
        "$DebugStr : [Lysis Heater Pass Result  ] : " + $RHID_Lysis_Heater_FAT_PASS.line.split(",").TrimStart()[-1]
    }
        "$DebugStr : [Lysis Heater Fail Counter ] : " + $RHID_Lysis_Heater_FAT_FAIL.count

    if ($RHID_Lysis_Heater_FAT_FAIL.count -gt 0) {
        "$DebugStr : [Optics Heater Fail Result ] : " + ($RHID_Lysis_Heater_FAT_FAIL.line.split("==>").TrimStart() | Select-String "PWM")[-1]
        "$DebugStr : [Lysis Heater Fail Result  ] : " + $RHID_Lysis_Heater_FAT_FAIL.line.split(",").TrimStart()[-1]
    
    }
        "$DebugStr : [DN Heater Pass Counter    ] : " + $RHID_DN_Heater_FAT_PASS.count
    if ($RHID_DN_Heater_FAT_PASS.count -gt 0) {
        "$DebugStr : [DN Heater Pass Result     ] : " + $RHID_DN_Heater_FAT_PASS.line.split(",").TrimStart()[-1]
    
    }
        "$DebugStr : [DN Heater Fail Counter    ] : " + $RHID_DN_Heater_FAT_FAIL.count
    if ($RHID_DN_Heater_FAT_FAIL.count -gt 0) {
        "$DebugStr : [Optics Heater Fail Result ] : " + ($RHID_DN_Heater_FAT_FAIL.line.split("==>").TrimStart() | Select-String "PWM")[-1]
        "$DebugStr : [DN Heater Fail Result     ] : " + $RHID_DN_Heater_FAT_FAIL.line.split(",").TrimStart()[-1]
    }

        "$DebugStr : [PCR Heater Pass Counter   ] : " + $RHID_PCR_Heater_FAT_PASS.count
    if ($RHID_PCR_Heater_FAT_PASS.count -gt 0) {
        "$DebugStr : [PCR Heater Pass Result    ] : " + $RHID_PCR_Heater_FAT_PASS.line.split(",").TrimStart()[-1]
    }

        "$DebugStr : [PCR Heater Fail Counter   ] : " + $RHID_PCR_Heater_FAT_FAIL.count
    if ($RHID_PCR_Heater_FAT_FAIL.count -gt 0) {
        "$DebugStr : [Optics Heater Fail Result ] : " + ($RHID_PCR_Heater_FAT_FAIL.line.split("==>").TrimStart() | Select-String "PWM")[-1]
        "$DebugStr : [PCR Heater Fail Result    ] : " + $RHID_PCR_Heater_FAT_FAIL.line.split(",").TrimStart()[-1]
    }

        "$DebugStr : [Optics Heater Pass Counter] : " + $RHID_Optics_Heater_FAT_PASS.count
    if ($RHID_Optics_Heater_FAT_PASS.count -gt 0) {
        "$DebugStr : [Optics Heater Pass Result ] : " + $RHID_Optics_Heater_FAT_PASS.line.split(",").TrimStart()[-1]
    }

        "$DebugStr : [Optics Heater Fail Counter] : " + $RHID_Optics_Heater_FAT_FAIL.count
    if ($RHID_Optics_Heater_FAT_FAIL.count -gt 0) {
        "$DebugStr : [Optics Heater Fail Result ] : " + ($RHID_Optics_Heater_FAT_FAIL.line.split("==>").TrimStart() | Select-String "PWM")[-1]
        "$DebugStr : [Optics Heater Fail Result ] : " + $RHID_Optics_Heater_FAT_FAIL.line.split(",").TrimStart()[-1]
    }
}

