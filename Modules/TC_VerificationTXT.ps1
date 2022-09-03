
if ([bool]$TC_verificationTXT -eq "True") {
    $RHID_Verify_Probe = ($TC_verificationTXT | Select-String "Ambient ; Probe").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_Verify_USB_Probe = ($TC_verificationTXT | Select-String "Humidity").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Probe_ID = ($TC_verificationTXT | Select-String "TC Probe ID").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step1 = ($TC_verificationTXT | Select-String "TC Step 1").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step2 = ($TC_verificationTXT | Select-String "TC Step 2").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step3 = ($TC_verificationTXT | Select-String "TC Step 3").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step4 = ($TC_verificationTXT | Select-String "TC Step 4").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_Verify_Arileak = ($TC_verificationTXT | Select-String "Airleak Test ").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_Verify_Laser_ID = ($TC_verificationTXT | Select-String "Laser LD_488 S/N").line.split(":").TrimStart() | Select-Object -Last 1
}