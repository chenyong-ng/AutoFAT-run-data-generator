<#
.Title          : Powershell Utility for RHID Instrument
.Source         : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version        :	v0.4
.License        : Public Domain
.Revision Date  : 10 JUL 2022
.Description    : This script are best viewed and edit in Visual Studio Code https://code.visualstudio.com/
.Todo           : 
#>

IF ($SerialRegMatch -eq "False") {
    $serverdir = "$Drive\$MachineName\Internal\RapidHIT ID\Results"
}
$TC_verificationTXT = Get-ChildItem "$serverdir" -I "TC_verification $MachineName.TXT" -R -ErrorAction SilentlyContinue
if ([bool]$TC_verificationTXT -eq "True") {
    $Ambient_Probe_Str = "                        Ambient + Probe"
    $USB_Temp_Humidity = "                        Temp + Humidity"
    $TC_Probe_ID       = "                            TC Probe ID"
    $TC_Steps          = "                              TC Step"
    $AirLeak_Test      = "                           Airleak Test"
    $Laser_SN          = "                       Laser LD_488 S/N"
    $RHID_Verify_Probe = ($TC_verificationTXT | Select-String "Ambient").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_Verify_USB_Probe = ($TC_verificationTXT | Select-String "Humidity").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Probe_ID = ($TC_verificationTXT | Select-String "TC Probe ID").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step1 = ($TC_verificationTXT | Select-String "TC Step 1").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step2 = ($TC_verificationTXT | Select-String "TC Step 2").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step3 = ($TC_verificationTXT | Select-String "TC Step 3").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_TC_Step4 = ($TC_verificationTXT | Select-String "TC Step 4").line.split(":").TrimStart() | Select-Object -Last 1
    $RHID_Verify_Arileak = ($TC_verificationTXT | Select-String "Airleak Test ").line.split(":").TrimStart() | Select-Object -Last 1
} else {
    Write-Host "$Warning : TC_verification $MachineName.TXT Does not exist." -ForegroundColor Red }