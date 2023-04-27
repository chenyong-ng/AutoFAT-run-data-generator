IF ($SerialRegMatch -eq "False") {
    $serverdir = "$Drive\$MachineName\Internal\RapidHIT ID\Results"
}

function RHID_TC_Verification {
$TC_verificationTXT = Get-ChildItem "$serverdir","$result" -I "TC_verification $MachineName.TXT" -R -ErrorAction SilentlyContinue
if ([bool]$TC_verificationTXT -eq "True") {
    $Ambient_Probe_Str = "                        Ambient + Probe"
    $USB_Temp_Humidity = "                        Temp + Humidity"
    $TC_Probe_ID       = "                            TC Probe ID"
    $TC_Steps          = "                              TC Step"
    $AirLeak_Test      = "                           Airleak Test"
    $RHID_Verify_Probe = ($TC_verificationTXT | Select-String "Ambient").line.split(":").TrimStart()  | Select-Object -Last 1
    $RHID_Verify_USB_Probe = ($TC_verificationTXT | Select-String "Humidity").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Probe_ID = ($TC_verificationTXT | Select-String "TC Probe ID").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step1 = ($TC_verificationTXT | Select-String "TC Step 1").line.split(":").TrimStart() | Select-Object -Last 1 
    $RHID_TC_Step2 = ($TC_verificationTXT | Select-String "TC Step 2").line.split(":").TrimStart() | Select-Object -Last 1 
    $RHID_TC_Step3 = ($TC_verificationTXT | Select-String "TC Step 3").line.split(":").TrimStart() | Select-Object -Last 1 
    $RHID_TC_Step4 = ($TC_verificationTXT | Select-String "TC Step 4").line.split(":").TrimStart() | Select-Object -Last 1 
    $RHID_Verify_Arileak = ($TC_verificationTXT | Select-String "Airleak Test ").line.split(":").TrimStart() | Select-Object -Last 1
    "$Verification : $Ambient_Probe_Str : $RHID_Verify_USB_Probe"
    "$Verification : $USB_Temp_Humidity : $RHID_Verify_Probe"
    "$Verification : $TC_Probe_ID : $RHID_TC_Probe_ID"
    "$Verification : $TC_Steps 1 : $RHID_TC_Step1"
    "$Verification : $TC_Steps 2 : $RHID_TC_Step2"
    "$Verification : $TC_Steps 3 : $RHID_TC_Step3"
    "$Verification : $TC_Steps 4 : $RHID_TC_Step4"
    "$Verification : $Airleak_Test : $RHID_Verify_Arileak"
} else {
    Write-Host "$Warning : TC_verification $MachineName.TXT Does not exist." -ForegroundColor Red }
}
