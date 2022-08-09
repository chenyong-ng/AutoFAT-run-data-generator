function Main {
    If ($SerialRegMatch -eq $True) {
. $PSScriptRoot\set-volume.ps1
. $PSScriptRoot\Set-ScreenResolutionEx.ps1
 # CHR RHID-0486 (Internal) disable if internal CHR detected
(Get-Process -Name CMD, Powershell).MainWindowHandle | ForEach-Object { Set-WindowStyle MAXIMIZE $_ }
Set-ScreenResolutionEx -Width 1920 -Height 1080 -DeviceID 0

        if ($name -eq $True) {
        $StatusData_leaf = Get-ChildItem -Path "$name" -I $StatusData  -R | Test-path -PathType Leaf
        $GM_Analysis_leaf = Get-ChildItem -Path "$name" -I $GM_Analysis -R | Test-path -PathType Leaf
        }
        $Win110Patch_RegKey = "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{96236EEA-504A-4395-8C4D-299A6CA26A3F}_is1"
        $Win10patch_leaf = Test-Path -Path "$Win110Patch_RegKey" 
        if ($Win10patch_leaf -eq "True") {
            $Win10patch = Get-ItemPropertyValue "$Win110Patch_RegKey" 'DisplayName'
            Write-host "[Info   ]: $Win10patch Installed" -ForegroundColor Magenta
        }
        else {
            Write-host "[Warning]: Patch ABRHID_Win10_Patch20201208 not installed" -ForegroundColor red
        }
        Write-host "[Info   ]: RapidHIT Instrument $name detected, creating Server folder"
        "[Info   ]: Non-linearity Calibration and Waves place-holder file."
        "[Info   ]: Force audio volume to 50%"
        
        [audio]::Volume = 0.5
        if ([Bool] ($StatusData_leaf) -eq "True" ) {
            "[Info   ]: Found $StatusData in these folders"
            Get-ChildItem -Path "$name" -I $StatusData  -R | Format-table Directory -Autosize -HideTableHeaders -wrap
        }
        else { Write-host "[Info   ]: $StatusData not found, PDF not exported or no full run has been performed" -ForegroundColor yellow }
        if ([Bool] ($GM_Analysis_leaf) -eq "True" ) {
            "[Info   ]: Found $GM_Analysis in these folders"
            Get-ChildItem -Path "$name" -I $GM_Analysis -R | Format-table Directory -Autosize -HideTableHeaders -wrap
        }
        else { Write-host "[Info   ]: $GM_Analysis not found or no full run has been performed" -ForegroundColor yellow }
        if ($internal -eq $True) {
            Write-host "[Info   ]: U:\$name\Internal\ already exists in server, skipping"
        }
        elseif ($internal -eq $False) {
            mkdir U:\"$name"\Internal\
            Write-host "[Info   ]: Server path $internal sucessfully created."
        }
        Set-Location $result
        if ($nlc -eq $False) {
            New-Item -Path "Non-linearity Calibration $name.PNG" -ItemType File
            Write-host "[Info   ]: Created placeholder file: Non-linearity Calibration $name.PNG"
        }
        elseif ($nlfs -eq '0') {
            Write-host "[Warning]: Empty file $nl detected, reported as $nlfs KB" -ForegroundColor red
        }
        else {
            Write-Host "[Info   ]: 'Non-linearity Calibration $name.PNG' already exists, skipping, File size is:" $nlfs KB
        }
        if ($waves -eq $False) {
            New-Item -Path "Waves $name.PNG" -ItemType File
            Write-host "[Info   ]: Created placeholder file: Waves $name.PNG"
        }
        elseif ($wvfs -eq '0') {
            Write-host "[Warning]: Empty file $wv detected, reported as $wvfs KB" -ForegroundColor red
        }
        else {
            Write-Host "[Info   ]: 'Waves $name.PNG' already exists, skipping, File size is:" $wvfs KB
        }

        if ($mcleaf -eq $False) {
            MachineConfigXML > $rhid\$MachineConfig
            Write-host "[Info   ]: '$MachineConfig' created"
        }
        else {
            Write-Host "[Info   ]: '$MachineConfig' already exists, skipping"
        }
        if ($tc -eq $False) {
            TC_verification > "TC_verification $name.TXT"
            Write-host "[Info   ] : Created placeholder file: TC_verification $name.TXT"
        }
        else {
            Write-Host "[Info   ]: 'TC_verification $name.TXT' already exists, skipping"
            Get-Content "TC_verification $name.TXT"
        }
        if (($wvfs -eq 0) -or ($nlfs -eq 0)) {
        $keypress = read-host "[Info   ]: Enter y to open Snipping tool and Waves for taking screenshot, Enter to skip"
        "[Info   ]: Make sure AutoFAT is not running, as Waves will cause resource conflict"
        if ($keypress -eq 'y') {
            Start-Process -WindowStyle Normal -FilePath notepad.exe "TC_verification $name.TXT"
            Start-Process -WindowStyle Normal -FilePath SnippingTool.exe
            Start-Process -WindowStyle Normal -FilePath C:\"Program Files (x86)\RGB Lasersystems"\Waves\Waves.exe
            Start-Process -WindowStyle normal -FilePath D:\gui-sec\gui_sec_V1001_4_79.exe
        }
        }
    } # Main function to check whether if it's RHID instrument or Workstation
}