
. $PSScriptRoot\Set-WindowStyle.ps1
. $PSScriptRoot\set-volume.ps1
. $PSScriptRoot\Set-ScreenResolutionEx.ps1
. $PSScriptRoot\AdapterTypes.ps1
set-variable -name "serverdir" -value "E:\RapidHIT ID"
Write-Host "$info : Reading from local machine $env:COMPUTERNAME folder"
Add-Type -Assembly System.Windows.Forms #duplicate entry
$ScreenWidth = ([system.windows.forms.screen]::AllScreens).workingarea.width
$ScreenHeight = ([system.windows.forms.screen]::AllScreens).workingarea.height
    if ($strMonitors -ne $InteralDisplay) {
    displayswitch /external
    Start-Sleep -Seconds 5
        Set-ScreenResolutionEx -Width 1920 -Height 1080 -DeviceID 0
        Write-Host "$info : Display Resolution set to 1920 x 1080" }
        Write-Host "$info : Display Type: $strMonitors"
    if ($SystemTimeZone -ne "(UTC-08:00) Pacific Time (US & Canada)" ) {
        Write-host "$Warning : Wrong Time Zone setting! Check Date setting in BIOS" -ForegroundColor Red
    } else {
    Write-Host "$info : System Timezone $SystemTimeZone" }

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
        if ($internal -eq $False) {
            mkdir U:\"$HostName\Internal\RapidHIT ID\Results\Data $HostName"
            Write-host "$info : Server path $internal sucessfully created."
        }
        Set-Location $Inst_rhid_Result
        if ($Waves_Leaf -eq $True) { $wvfs = (Get-Item $Inst_rhid_Result\$Waves_File | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }
        if ($Nonlinearity_Leaf   -eq $True) { $nlfs = (Get-Item $Inst_rhid_Result\$Nonlinearity_File | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }
        if ($Nonlinearity_Leaf -eq $False) {
            New-Item -Path "Non-linearity Calibration $HostName.PNG" -ItemType File
            Write-host "$info : Created placeholder file: Non-linearity Calibration $HostName.PNG"
        }
        elseif ($nlfs -eq '0') {
            Write-host "$Warning : Empty $Nonlinearity_File detected, reported as $nlfs KB" -ForegroundColor Yellow
        }
        else {
            Write-Host "$info : 'Non-linearity Calibration $HostName.PNG' already exists, size is:" $nlfs KB
        }
        if ($Waves_Leaf -eq $False) {
            New-Item -Path "Waves $HostName.PNG" -ItemType File
            Write-host "$info : Created placeholder file: Waves $HostName.PNG"
        }
        elseif ($wvfs -eq '0') {
            Write-host "$Warning : Empty $Waves_File detected, reported as $wvfs KB" -ForegroundColor Yellow
        }
        else {
            Write-Host "$info : 'Waves $HostName.PNG' already exists, size is:" $wvfs KB
        }
        if ($TC_CalibrationXML_Leaf -eq $False) {
            TC_CalibrationXML_Gen > $Inst_rhid_Folder\$TC_CalibrationXML_File
            Write-host "$info : '$TC_CalibrationXML_File' created"
        }
        else {
            Write-Host "$info : '$TC_CalibrationXML_File' already exists"
        }
        if ($MachineConfig_Leaf -eq $False) {
            MachineConfigXML > $Inst_rhid_Folder\$MachineConfig_File
            Write-host "$info : '$MachineConfig_File' created"
        }
        else {
            Write-Host "$info : '$MachineConfig_File' already exists"
        }
        if ($TC_verification_Leaf -eq $False) {
            TC_verification > "TC_verification $HostName.TXT"
            Write-host "$info  : Created placeholder file: TC_verification $HostName.TXT"
        }
        if (($wvfs -gt 1) -and ($nlfs -gt 1)) {
        #BackupConfig
        }
        if (($wvfs -eq 0) -or ($nlfs -eq 0)) {
        $keypress = read-host "$info : Enter y to open Snipping tool and Waves for taking screenshot, Enter to skip"
        "$info : Make sure AutoFAT is not running, as Waves will cause resource conflict"
        if ($keypress -eq 'y') {
            Start-Process -WindowStyle Normal -FilePath notepad.exe "TC_verification $HostName.TXT"
            Start-Process -WindowStyle Normal -FilePath SnippingTool.exe
            Start-Process -WindowStyle Normal -FilePath C:\"Program Files (x86)\RGB Lasersystems"\Waves\Waves.exe
            Start-Process -WindowStyle Normal -FilePath D:\gui-sec\gui_sec_V1001_4_79.exe
        }    
    }

 # Main function to check whether if it's RHID instrument or Workstation