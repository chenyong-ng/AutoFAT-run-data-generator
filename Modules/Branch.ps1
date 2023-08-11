#if ($SerialRegMatch -ne "True") {
    $RHID_FolderList        = Get-ChildItem "$Drive\", "$US_Drive" | Where-Object { $_.PSIsContainer -and $_.Name -Match 'RHID-\d\d\d\d' }
    Write-Host "$Info : List of available RHID run folders in Servers $Drive $US_Drive for checking ↑↑↑↑" -ForegroundColor Cyan
    $RHID_FolderList | Format-wide -Property name -AutoSize
    "$Info : For latest update, get source code from Github:"
    "$Info : https://github.com/chenyong-ng/AutoFAT-run-data-generator/tree/stable"
    "$Info : Pacific Time is now : $PST_TimeZone"
    "$Info : Powershell version  : $PSVersion on $HostName"
    "$Info : Host Connected to : $CheckLan, $CheckWifi " + ",Connected to Internet?: $CheckInternet"
    If ($RealtimeProtection.DisableRealtimeMonitoring -match "false") {
        Write-Host "$Info : Realtime AntiMalware Protection is enabled, Script performance might be affected" -ForegroundColor Yellow
    }
    "$Info : Only first 4 ditigs are indexed for RHID result generation"
    "$Info : Extra alphanumeric characters are passed as arguments"
    "$Info : Press Ctrl+C to Abort Script Execution"
    "$Info : Usage : enter 0477xv to enable Verbose mode but disable report generation, space are optional"
    "$Info : Enter V to enable VerboseMode, Q to anable Quiet Mode on console"
    "$Info :	R to disable Report Log Generation, X to disable XML Generation"
    "$Info :	D to enable descriptive information"
    #"$Info : Enter again to show detailed information for additional switches for various options"
    $SerialNumber           = read-host "$Info : Enter Instrument Serial Number (4 digits) with alpabets as suffix to proceed"
    $IndexedSerialNumber    = $serialNumber[0] + $serialNumber[1] + $serialNumber[2] + $serialNumber[3]
    # add option to check whether the host is using wlan or lan
    $LocalServerTestPath    = Test-Path -Path $path-$IndexedSerialNumber
    $US_ServerTestPath      = Test-Path -Path $US_path-$IndexedSerialNumber
    If ($SerialNumber -eq '') {
        break
        # Allow Instrument to check other instrument results
    }
    elseif (($LocalServerTestPath -or $US_ServerTestPath) -ne "True") {
        Write-Error -Message "No Matching Serial Number $IndexedSerialNumber found in Server" -ErrorAction Stop -Category ObjectNotFound -ErrorId 404
    }
    
$Arguments = $serialNumber[4, 5, 6, 7, 8, 9, 10,11,12,13]
if ($Arguments -match 'v') {
    $VerboseMode            = "True"
    Write-Host "$Info : [V] Swtich Activated, VerboseMode Enabled"                   -ForegroundColor Yellow
}
if ($Arguments -match 'q') {
    $QuiteMode              = "True"
    Write-Host "$Info : [Q] Switch Activated, Quiet Mode Enabled"                    -ForegroundColor Yellow
}
if ($Arguments -match 'r') {
    $NoReport               = "True"
    Write-Host "$Info : [R] Switch Activated, Report Log Generation Disabled"        -ForegroundColor Yellow
}
if ($Arguments -match 'x') {
    $NoXML                  = "True"
    Write-Host "$Info : [X] Switch Activated, XML Generation Disable"                -ForegroundColor Yellow
}
if ($Arguments -match 'd') {
    $EnableDescriptions     = "True"
    Write-Host "$Info : [D] Switch Activated, Detailed Describion Enabled For Each Tests" -ForegroundColor Yellow
}
if ($Arguments -match 'I') {
    $NoIMGPopUp             = "True"
    Write-Host "$Info : [I] Switch Activated, Image Popup Disabled"                 -ForegroundColor Yellow
}
