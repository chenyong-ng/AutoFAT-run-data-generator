
$ScreenWidth 	= [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
$ScreenHeight 	= [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height

if (($strMonitors -ne $InteralDisplay) -and ($ScreenWidth -lt "1080")) {
    DisplaySwitch.exe /external
    Start-Sleep -Seconds 5
    Set-ScreenResolutionEx -Width 1920 -Height 1080 -DeviceID 0
    Write-Host "$info : Display Resolution set to $ScreenWidth x $ScreenHeight"
    } else {
    Write-Host "$info : Display Resolution: $ScreenWidth x $ScreenHeight" }
Write-Host "$info : Display Type: $strMonitors"

$PST_TimeZone = [String]$ScriptConfig.Global.PST
if ($SystemTimeZone -ne "$PST_TimeZone" ) {
    Write-host "$Warning : Wrong Time Zone setting! Check Date setting in BIOS" -ForegroundColor Red
}
else {
    Write-Host "$info : System Timezone $SystemTimeZone" 
}
"$info : System Uptime = $SystemUptime in Hours Since Last Boot"

If ($Debug -eq "Off") {
    [audio]::Volume = 0.4
        (Get-Process -Name CMD, Powershell).MainWindowHandle | ForEach-Object { Set-WindowStyle MAXIMIZE $_ }
}

if ($Server_Internal -eq $False) {
    New-Item -ItemType "Directory" -Path "$Drive\$HostName\Internal\RapidHIT ID\Results\Data $HostName"
    "$info : Server path $Server_Internal sucessfully created."
}
elseif ($Server_Internal -eq $True) {
    "$info : Server path $Server_Internal exists, skipping."
}
"$info : Check if Server path already created : $Server_Internal"

# Local folder check
Set-Location $Inst_rhid_Result
if ($Nonlinearity_Leaf -eq $True) {
    $NonLinearity_FileSize = (Get-Item $Inst_rhid_Result\$Nonlinearity_File | ForEach-Object { [math]::ceiling($_.length / 1KB) })
}
if ($Nonlinearity_Leaf -eq $False) {
    New-Item $Nonlinearity_File -ItemType File
    Write-host "$info : Created placeholder file: $Nonlinearity_File"
}
elseif ($NonLinearity_FileSize -eq '0') {
    Write-host "$Warning : Empty $Nonlinearity_File, $NonLinearity_FileSize KB" -ForegroundColor Yellow
}
else {
    Write-Host "$info : '$Nonlinearity_File' file size is: $NonLinearity_FileSize KB" -ForegroundColor Green
}

if ($Waves_Leaf -eq $True) {
    $Waves_Filesize = (Get-Item $Inst_rhid_Result\$Waves_File | ForEach-Object { [math]::ceiling($_.length / 1KB) })
}
if ($Waves_Leaf -eq $False) {
    New-Item $Waves_File -ItemType File
    Write-host "$info : Created placeholder file: $Waves_File"
} elseif ($Waves_Filesize -eq '0') {
    Write-host "$Warning : Empty $Waves_File, $Waves_Filesize KB" -ForegroundColor Yellow
} else {
    Write-Host "$info : '$Waves_File' file size is: $Waves_Filesize KB" -ForegroundColor Green
}

if ($TC_CalibrationXML_Leaf -eq $False) {
    TC_CalibrationXML_Gen > $Inst_rhid_Folder\$TC_CalibrationXML_File
    Write-host "$info : '$TC_CalibrationXML_File' created"
}
else {
    Write-Host "$info : '$TC_CalibrationXML_File' already exists"
}

if ($OverrideSettingsXML_Leaf -eq $False) {

    OverrideSettingsXML_Gen > $Inst_rhid_Folder\$OverrideSettingsXML_File
    Write-host "$info : '$OverrideSettingsXML_File' created"
}
else {
    Write-Host "$info : '$OverrideSettingsXML_File' already exists"
}

if ($MachineConfig_Leaf -eq $False) {
    MachineConfigXML_Gen > $Inst_rhid_Folder\$MachineConfig_File
    Write-host "$info : '$MachineConfig_File' created"
}
else {
    Write-Host "$info : '$MachineConfig_File' already exists"
}

if ($TC_verification_Leaf -eq $False) {
    TC_verification > "TC_verification $HostName.TXT"
    Write-host "$info : Created placeholder file: TC_verification $HostName.TXT"
}

if (($Waves_Filesize -gt 1) -and ($NonLinearity_FileSize -gt 1)) {
    BackupConfig
    # add function to veirfy if backup was successful
    Write-host "$info : Backup Instrument TC_Calibration.xml & Waves screenshot to server"
}

if (($Waves_Filesize -eq 0) -or ($NonLinearity_FileSize -eq 0)) {
    $keypress = read-host "$info : Enter y to open Snipping tool and Waves for taking screenshot, Enter to skip"
    "$info : Make sure AutoFAT is not running, as Waves will cause resource conflict"

    if ($keypress -eq 'y') {
        Start-Process -WindowStyle Normal -FilePath [String]$ScriptConfig.Apps.Notepad "TC_verification $HostName.TXT"
        Start-Process -WindowStyle Normal -FilePath [String]$ScriptConfig.Apps.SnippingTool
        Start-Process -WindowStyle Normal -FilePath [String]$ScriptConfig.Apps.Broadcom_Waves
        Start-Process -WindowStyle Normal -FilePath [String]$ScriptConfig.Apps.GuiSec
    }
}

<#
"C:\Program Files (x86)\SoftGenetics\HIDAutoLite\V2.95 for IntegenX\DataCheck.exe" 7C0469C3-1269-42C8-B779-4FB6E8D0F527 35
"C:\Program Files (x86)\SoftGenetics\HIDAutoLite\V2.95 for IntegenX\AutoAnalyser" 1
#>
