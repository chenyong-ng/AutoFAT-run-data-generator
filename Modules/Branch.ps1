if ($SerialRegMatch -ne "True") {
    $RHID_FolderList = Get-ChildItem "$Drive\", "$US_Drive" | Where-Object { $_.PSIsContainer -and $_.Name -Match 'RHID-\d\d\d\d' }
    Write-Host "$Info : List of available RHID run folders in Servers $Drive $US_Drive for checking ↑↑↑↑" -ForegroundColor Cyan
    $RHID_FolderList | Format-wide -Property name -AutoSize
    "$Info : For latest update, get source code from Github:"
    "$Info : https://github.com/chenyong-ng/AutoFAT-run-data-generator/tree/stable"
    "$Info : Pacific Time is now : $PST_TimeZone"
    "$Info : Powershell version  : $PSVersion on $HostName"
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
    $SerialNumber = read-host "$Info : Enter Instrument Serial Number (4 digits) with alpabets as suffix to proceed"
    $IndexedSerialNumber = $serialNumber[0] + $serialNumber[1] + $serialNumber[2] + $serialNumber[3]
    # add option to check additional serial numbers
    # add function to initiate HIDAutolite with code and email for troubleshoot
    $LocalServerTestPath = Test-Path -Path $path-$IndexedSerialNumber
    $US_ServerTestPath = Test-Path -Path $US_path-$IndexedSerialNumber
    If ($SerialNumber -eq '') {
        break
    }
    elseif (($LocalServerTestPath -or $US_ServerTestPath) -ne "True") {
        Write-Error -Message "Selected Serial Number $IndexedSerialNumber does not have record in Server" -ErrorAction Stop -Category ObjectNotFound -ErrorId 404
    }
}

$Arguments = $serialNumber[4, 5, 6, 7, 8, 9, 10]
if ($Arguments -match 'v') {
    $VerboseMode = "True"
    Write-Host "$Info : [V]erboseMode Enabled via V switch" -ForegroundColor Yellow
}
if ($Arguments -match 'q') {
    $QuiteMode = "True"
    Write-Host "$Info : [Q]uiet Mode Enabled via Q switch" -ForegroundColor Yellow
}
if ($Arguments -match 'r') {
    $NoReport = "True"
    Write-Host "$Info : No [R]eport Log Generation via NR switch" -ForegroundColor Yellow
}
if ($Arguments -match 'x') {
    $NoXML = "True"
    Write-Host "$Info : No [X]ML Generation via X switch" -ForegroundColor Yellow
}
if ($Arguments -match 'd') {
    $EnableDescriptions = "True"
    Write-Host "$Info : Enabled more detailed description of each tests via D switch" -ForegroundColor Yellow
}