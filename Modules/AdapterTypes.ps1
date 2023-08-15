<#
.Synopsis
    List Monitors and Connection Types
.DESCRIPTION
    Credit goes to https://amgeneral.wordpress.com/2021/07/13/powershell-list-monitors-and-connection-types/
.EXAMPLE
    Run $strMonitors
.OUTPUTS
    SHP  (Internal)
    DEL DELL P2419H (DisplayPort (external))
.NOTES
    Get-WmiObject is deprecated, and only available on Powershell version 5.1
.COMPONENT
    Part of the RHID_MiniFunctions.ps1
.ROLE
    Used to detect the Display type and change the resolution
.FUNCTIONALITY
    The functionality that best describes this cmdlet
#>

$adapterTypes = @{ #https://www.magnumdb.com/search?q=parent:D3DKMDT_VIDEO_OUTPUT_TECHNOLOGY
    '-2'         = 'Unknown'
    '-1'         = 'Unknown'
    '0'          = 'VGA'
    '1'          = 'S-Video'
    '2'          = 'Composite'
    '3'          = 'Component'
    '4'          = 'DVI'
    '5'          = 'HDMI'
    '6'          = 'LVDS'
    '8'          = 'D-Jpn'
    '9'          = 'SDI'
    '10'         = 'DisplayPort (external)'
    '11'         = 'DisplayPort (internal)'
    '12'         = 'Unified Display Interface'
    '13'         = 'Unified Display Interface (embedded)'
    '14'         = 'SDTV dongle'
    '15'         = 'Miracast'
    '16'         = 'Internal'
    '2147483648' = 'Internal'
}

$arrMonitors = @()

$monitors = Get-WmiObject WmiMonitorID -Namespace root/wmi
$connections = Get-WmiObject WmiMonitorConnectionParams -Namespace root/wmi

foreach ($monitor in $monitors) {
    $manufacturer = $monitor.ManufacturerName
    $name = $monitor.UserFriendlyName
    $connectionType = ($connections | ? { $_.InstanceName -eq $monitor.InstanceName }).VideoOutputTechnology

    if ($null -ne $manufacturer) { $manufacturer = [System.Text.Encoding]::ASCII.GetString($manufacturer -ne 0) }
    if ($null -ne $name) { $name = [System.Text.Encoding]::ASCII.GetString($name -ne 0) }
    $connectionType = $adapterTypes."$connectionType"
    if ($null -eq $connectionType) { $connectionType = 'Unknown' }

    if (($null -ne $manufacturer) -or ($null -ne $name)) { $arrMonitors += "$manufacturer $name ($connectionType)" }

}

$i = 0
$strMonitors = ''
if ($arrMonitors.Count -gt 0) {
    foreach ($monitor in $arrMonitors) {
        if ($i -eq 0) { $strMonitors += $arrMonitors[$i] }
        else { $strMonitors += "`n"; $strMonitors += $arrMonitors[$i] }
        $i++
    }
}

if ($strMonitors -eq '') { $strMonitors = 'None Found' }
$strMonitors