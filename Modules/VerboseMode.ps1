Function RHID_Heater_Verbose {
        "[Lysis Heater Pass Counter ] : " + $RHID_Lysis_Heater_FAT_PASS.count
    if ($RHID_Lysis_Heater_FAT_PASS.count -gt 0) {
        "[Lysis Heater Pass Result  ] : " + $RHID_Lysis_Heater_FAT_PASS.line.split(",").TrimStart()[-1] }
        "[Lysis Heater Fail Counter ] : " + $RHID_Lysis_Heater_FAT_FAIL.count
    if ($RHID_Lysis_Heater_FAT_FAIL.count -gt 0) {
        "[Lysis Heater Fail Result  ] : " + $RHID_Lysis_Heater_FAT_FAIL.line.split(",").TrimStart()[-1] }
        "[DN Heater Pass Counter    ] : " + $RHID_DN_Heater_FAT_PASS.count
    if ($RHID_DN_Heater_FAT_PASS.count -gt 0) {
        "[DN Heater Pass Result     ] : " + $RHID_DN_Heater_FAT_PASS.line.split(",").TrimStart()[-1] }
        "[DN Heater Fail Counter    ] : " + $RHID_DN_Heater_FAT_FAIL.count
    if ($RHID_DN_Heater_FAT_FAIL.count -gt 0) {
        "[DN Heater Fail Result     ] : " + $RHID_DN_Heater_FAT_FAIL.line.split(",").TrimStart()[-1] }
        "[PCR Heater Pass Counter   ] : " + $RHID_PCR_Heater_FAT_PASS.count
    if ($RHID_PCR_Heater_FAT_PASS.count -gt 0) {
        "[PCR Heater Pass Result    ] : " + $RHID_PCR_Heater_FAT_PASS.line.split(",").TrimStart()[-1] }
        "[PCR Heater Fail Counter   ] : " + $RHID_PCR_Heater_FAT_FAIL.count
    if ($RHID_PCR_Heater_FAT_FAIL.count -gt 0) {
        "[PCR Heater Fail Result    ] : " + $RHID_PCR_Heater_FAT_FAIL.line.split(",").TrimStart()[-1] }
        "[Optics Heater Pass Counter] : " + $RHID_Optics_Heater_FAT_PASS.count
    if ($RHID_Optics_Heater_FAT_PASS.count -gt 0) {
        "[Optics Heater Pass Result ] : " + $RHID_Optics_Heater_FAT_PASS.line.split(",").TrimStart()[-1] }
        "[Optics Heater Fail Counter] : " + $RHID_Optics_Heater_FAT_FAIL.count
    if ($RHID_Optics_Heater_FAT_FAIL.count -gt 0) {
        "[Optics Heater Fail Result ] : " 
        $RHID_Optics_Heater_FAT_FAIL.line.split("==>").TrimStart() | Select-String "PWM" | Select-Object -last 1
    }
}
