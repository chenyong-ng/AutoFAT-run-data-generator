$adapterTypes = @{ #https://www.magnumdb.com/search?q=parent:D3DKMDT_VIDEO_OUTPUT_TECHNOLOGY
    '-2' = 'Unknown'
    '-1' = 'Unknown'
    '0' = 'VGA'
    '1' = 'S-Video'
    '2' = 'Composite'
    '3' = 'Component'
    '4' = 'DVI'
    '5' = 'HDMI'
    '6' = 'LVDS'
    '8' = 'D-Jpn'
    '9' = 'SDI'
    '10' = 'DisplayPort (external)'
    '11' = 'DisplayPort (internal)'
    '12' = 'Unified Display Interface'
    '13' = 'Unified Display Interface (embedded)'
    '14' = 'SDTV dongle'
    '15' = 'Miracast'
    '16' = 'Internal'
    '2147483648' = 'Internal'
}

$arrMonitors = @()

#gwmi
$monitors = Get-WmiObject WmiMonitorID -Namespace root/wmi
$connections = Get-WmiObject WmiMonitorConnectionParams -Namespace root/wmi

foreach ($monitor in $monitors)
{
    $manufacturer = $monitor.ManufacturerName
    $FriendlyName = $monitor.UserFriendlyName
    $connectionType = ($connections | Where-Object {$_.InstanceName -eq $monitor.InstanceName}).VideoOutputTechnology

    if ($null -ne $manufacturer) {$manufacturer =[System.Text.Encoding]::ASCII.GetString($manufacturer -ne 0)}
    if ($null -ne $FriendlyName) { $FriendlyName = [System.Text.Encoding]::ASCII.GetString($FriendlyName -ne 0) }
    $connectionType = $adapterTypes."$connectionType"
    if ($null -eq $connectionType){$connectionType = 'Unknown'}

    if (($null -ne $manufacturer) -or ($null -ne $FriendlyName)) { $arrMonitors += "$manufacturer $HostName ($connectionType)"}

}

$i = 0
$strMonitors = ''
if ($arrMonitors.Count -gt 0){
    foreach ($monitor in $arrMonitors){
        if ($i -eq 0){$strMonitors += $arrMonitors[$i]}
        else{$strMonitors += "`n"; $strMonitors += $arrMonitors[$i]}
        $i++
    }
}

if ($strMonitors -eq ''){$strMonitors = 'None Found'}