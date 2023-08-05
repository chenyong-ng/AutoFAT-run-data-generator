function RHID_MainFunctions {
. $PSScriptRoot\Set-WindowStyle.ps1
. $PSScriptRoot\set-volume.ps1
. $PSScriptRoot\Set-ScreenResolutionEx.ps1
. $PSScriptRoot\AdapterTypes.ps1
set-variable -name "serverdir" -value "E:\RapidHIT ID"
Write-Host "$info : Reading from local machine $env:COMPUTERNAME folder"
$ScreenWidth = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
$ScreenHeight = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height
    if (($strMonitors -ne $InteralDisplay) -and ($ScreenWidth -lt "1080")) {
    displayswitch /external
    Start-Sleep -Seconds 5
        Set-ScreenResolutionEx -Width 1920 -Height 1080 -DeviceID 0
        Write-Host "$info : Display Resolution set to $ScreenWidth x $ScreenHeight"}
    else {Write-Host "$info : Display Resolution: $ScreenWidth x $ScreenHeight"}
    Write-Host "$info : Display Type: $strMonitors"
    if ($SystemTimeZone -ne "(UTC-08:00) Pacific Time (US & Canada)" ) {
        Write-host "$Warning : Wrong Time Zone setting! Check Date setting in BIOS" -ForegroundColor Red
    } else {
    Write-Host "$info : System Timezone $SystemTimeZone" }
"$info : System Uptime = $SystemUptime in Hours Since Last Boot"
If ($debug -eq "On") {
$SystemQuery = ((systeminfo | select-string "OS name", "Host Name").line.split(":").TrimStart())[1, -1]
$SystemQueryOS = $SystemQuery[1] ; $SystemQueryHost = $SystemQuery[0]
"$System : $Operating_System : $SystemQueryOS"
"$System : $Host_Name : $SystemQueryHost"
}

        If ($Debug -eq "Off") {
        [audio]::Volume = 0.4
        (Get-Process -Name CMD, Powershell).MainWindowHandle | ForEach-Object { Set-WindowStyle MAXIMIZE $_ }
        }

        if ($Server_Internal -eq $False) {
            mkdir $Drive\"$HostName\Internal\RapidHIT ID\Results\Data $HostName"
            "$info : Server path $Server_Internal sucessfully created."
        } elseif ($Server_Internal -eq $True) {
            "$info : Server path $Server_Internal exists, skipping."
        }
        "$info : Check if Server path already created : $Server_Internal"

        Set-Location $Inst_rhid_Result
        if ($Nonlinearity_Leaf -eq $True) { $NonLinearity_FileSize = (Get-Item $Inst_rhid_Result\$Nonlinearity_File | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }
        if ($Nonlinearity_Leaf -eq $False) {
            New-Item "Non-linearity Calibration $HostName.PNG" -ItemType File
            Write-host "$info : Created placeholder file: Non-linearity Calibration $HostName.PNG"
        }
        elseif ($NonLinearity_FileSize -eq '0') {
            Write-host "$Warning : Empty $Nonlinearity_File detected, reported as $NonLinearity_FileSize KB" -ForegroundColor Yellow
        }
        else {
            Write-Host "$info : 'Non-linearity Calibration $HostName.PNG' already exists, size is:" $NonLinearity_FileSize KB
        }

        if ($Waves_Leaf -eq $True) { $Waves_Filesize = (Get-Item $Inst_rhid_Result\$Waves_File | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }
        if ($Waves_Leaf -eq $False) {
            New-Item "Waves $HostName.PNG" -ItemType File
            Write-host "$info : Created placeholder file: Waves $HostName.PNG"
        }
        elseif ($Waves_Filesize -eq '0') {
            Write-host "$Warning : Empty $Waves_File detected, reported as $Waves_Filesize KB" -ForegroundColor Yellow
        }
        else {
            Write-Host "$info : 'Waves $HostName.PNG' already exists, size is:" $Waves_Filesize KB
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
        } else {
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
        Write-host "$info : Backup Instrument TC_Calibration.xml & Waves screenshot to server"
        }

        if (($Waves_Filesize -eq 0) -or ($NonLinearity_FileSize -eq 0)) {
        $keypress = read-host "$info : Enter y to open Snipping tool and Waves for taking screenshot, Enter to skip"
        "$info : Make sure AutoFAT is not running, as Waves will cause resource conflict"

        if ($keypress -eq 'y') {
            Start-Process -WindowStyle Normal -FilePath [String]$ScriptConfig.Global.Notepad "TC_verification $HostName.TXT"
            Start-Process -WindowStyle Normal -FilePath [String]$ScriptConfig.Global.SnippingTool
            Start-Process -WindowStyle Normal -FilePath [String]$ScriptConfig.Global.Broadcom_Waves
            Start-Process -WindowStyle Normal -FilePath [String]$ScriptConfig.Global.GuiSec
    }
}
}
 # Main function to check whether if it's RHID instrument or Workstation