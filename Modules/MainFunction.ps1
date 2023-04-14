
. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\Set-WindowStyle.ps1
. $PSScriptRoot\set-volume.ps1
. $PSScriptRoot\Set-ScreenResolutionEx.ps1
. $PSScriptRoot\AdapterTypes.ps1
set-variable -name "serverdir" -value "E:\RapidHIT ID"
Write-Host "$info : Reading from local machine $env:COMPUTERNAME folder"
    if ($strMonitors -ne $InteralDisplay) {
    displayswitch /external
    Start-Sleep -Seconds 5
        Set-ScreenResolutionEx -Width 1920 -Height 1080 -DeviceID 0
        Write-Host "$info : Display Resolution set to 1920 x 1080" }
        Write-Host "$info : Display Type: $strMonitors"
    $Win110Patch_RegKey = "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{96236EEA-504A-4395-8C4D-299A6CA26A3F}_is1"
    if ($SystemTimeZone -ne "(UTC-08:00) Pacific Time (US & Canada)" ) {
        Write-host "$Warning : Wrong Time Zone setting! Check Date setting in BIOS" -ForegroundColor Red
    } else {
    Write-Host "$info : System Timezone $SystemTimeZone" }

$RHID_FP_Sensor = (Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Select-String "TouchChip Fingerprint Coprocessor" )
$RHID_USB_HD_Camera = (Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Select-String "HD USB Camera" )
If ([Bool]$RHID_FP_Sensor -eq "True") {"$FP : $FP_Sensor_Str : Present" } else { "$FP : $FP_Sensor_Str : N/A" }
If ([Bool]$RHID_USB_HD_Camera -eq "True") {"$HD_USB_CAM : $HD_USB_CAM_Str : Present"} else {"$HD_USB_CAM : $HD_USB_CAM_Str : N/A"}
$SystemQuery = ((systeminfo | select-string "OS name", "Host Name").line.split(":").TrimStart())[1,-1]
"$System : $Operating_System :", $SystemQuery[1]
"$System : $Host_Name :", $SystemQuery[0]
    $Win10patch_leaf = Test-Path -Path "$Win110Patch_RegKey" 
    if ($Win10patch_leaf -eq "True") {
        $Win10patch = Get-ItemPropertyValue "$Win110Patch_RegKey" 'DisplayName'
        Write-host "$info : $Win10patch Installed" -ForegroundColor Magenta
    }
    else {
        Write-host "$Warning : Patch ABRHID_Win10_Patch20201208 not installed" -ForegroundColor red
    }
        Write-host "$info : RapidHIT Instrument $name detected, creating Server folder"
        If ($Debug -eq "Off") {
        [audio]::Volume = 0.4
        (Get-Process -Name CMD, Powershell).MainWindowHandle | ForEach-Object { Set-WindowStyle MAXIMIZE $_ }
        }
        if ($internal -eq $False) {
            mkdir U:\"$name\Internal\RapidHIT ID\Results\Data $name"
            Write-host "$info : Server path $internal sucessfully created."
        }
        Set-Location $result
        if ($waves -eq $True) { $wvfs = (Get-Item $result\$wv | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }
        if ($nlc   -eq $True) { $nlfs = (Get-Item $result\$nl | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }
        if ($nlc -eq $False) {
            New-Item -Path "Non-linearity Calibration $name.PNG" -ItemType File
            Write-host "$info : Created placeholder file: Non-linearity Calibration $name.PNG"
        }
        elseif ($nlfs -eq '0') {
            Write-host "$Warning : Empty $nl detected, reported as $nlfs KB" -ForegroundColor Yellow
        }
        else {
            Write-Host "$info : 'Non-linearity Calibration $name.PNG' already exists, size is:" $nlfs KB
        }
        if ($waves -eq $False) {
            New-Item -Path "Waves $name.PNG" -ItemType File
            Write-host "$info : Created placeholder file: Waves $name.PNG"
        }
        elseif ($wvfs -eq '0') {
            Write-host "$Warning : Empty $wv detected, reported as $wvfs KB" -ForegroundColor Yellow
        }
        else {
            Write-Host "$info : 'Waves $name.PNG' already exists, size is:" $wvfs KB
        }

        if ($mcleaf -eq $False) {
            MachineConfigXML > $rhid\$MachineConfig
            Write-host "$info : '$MachineConfig' created"
        }
        else {
            Write-Host "$info : '$MachineConfig' already exists"
        }
        if ($tc -eq $False) {
            TC_verification > "TC_verification $name.TXT"
            Write-host "$info  : Created placeholder file: TC_verification $name.TXT"
        }
        if (($wvfs -gt 1) -and ($nlfs -gt 1)) {
        #BackupConfig
        }
        if (($wvfs -eq 0) -or ($nlfs -eq 0)) {
        $keypress = read-host "$info : Enter y to open Snipping tool and Waves for taking screenshot, Enter to skip"
        "$info : Make sure AutoFAT is not running, as Waves will cause resource conflict"
        if ($keypress -eq 'y') {
            Start-Process -WindowStyle Normal -FilePath notepad.exe "TC_verification $name.TXT"
            Start-Process -WindowStyle Normal -FilePath SnippingTool.exe
            Start-Process -WindowStyle Normal -FilePath C:\"Program Files (x86)\RGB Lasersystems"\Waves\Waves.exe
            Start-Process -WindowStyle Normal -FilePath D:\gui-sec\gui_sec_V1001_4_79.exe
        }    
    }

 # Main function to check whether if it's RHID instrument or Workstation