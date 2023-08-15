function HIDAutoLite_ManualInput {
If ((Test-Path -PathType Leaf -Path $HIDAutoLitev295) -eq "True") {
    Start-Process $HIDAutoLitev295
    Set-Clipboard rhid-licensing@thermofisher.com
    start-sleep 1
    Set-Clipboard IntegenXProduction
} 
Else {
    Write-Host "$Info : HIDAutoLite License Registration Application not found" -ForegroundColor Yellow
    break
}
}

$DisplayOrientation = [Windows.Forms.SystemInformation]::ScreenOrientation
    if ($DisplayOrientation -eq "Angle0") {
    $DOI = "Landscape (0°)"
    } elseif ($DisplayOrientation -eq "Angle270" ) {
    $DOI = "Potrait (Flipped, 270°)" }

"$Info : Powershell version  : $PSVersion on $HostName"
"$Info : Host LAN Connection : $CheckLan"
"$Info : Host WIFI Connection : $CheckWifi"
"$Info : Connected to Internet?: $CheckInternet"
    $SystemQuery = ((systeminfo | select-string "OS name", "Host Name").line.split(":").TrimStart())[1, -1]
    $SystemQueryOS = $SystemQuery[1] ; $SystemQueryHost = $SystemQuery[0]
    "$System : $Operating_System : $SystemQueryOS"
    "$System : $Host_Name : $SystemQueryHost"
. $PSScriptRoot\Info_Screens.ps1
. $PSScriptRoot\AdapterTypes.ps1

    $DIMM       = [string](wmic memorychip get Manufacturer,DeviceLocator,PartNumber | Select-String "A1_DIMM0","A1_DIMM1")
    $Ram        = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1GB
    $currentPrincipal   = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $AdminMode  = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    $D = "DEBUG"
    "[$D] Ram            : $Ram GB"
    "[$D] SystemDiskSize : $Disk GB"
    "[$D] SystemDiskinfo : $Disktype"
    "[$D] Display        : $screen_cnt"; "[$D] DIMM           : $DIMM"
    "[$D] Administrator ?: $AdminMode" ; "[$D] MalwareScanner : $RealtimeProtection"
    "[$D] Local Folder  ?: $Local"     ; "[$D] Remote Folder ?: $Remote"
    "Ping to Thermo.com DNS Server " + ((ping Thermo.com) -match "Loss")
    "Ping to CloudFlare DNS Server " + ((ping 1.1.1.2) -match "Loss")
    "Ping to Google DNS Server     " + ((ping 8.8.8.8) -match "Loss")
    "Wi-Fi IP           : " + $WiFiIPaddress
    "Ethernet IP        : " + $LANIPaddress  
    $col_screens

    #todo move script pre-check to here