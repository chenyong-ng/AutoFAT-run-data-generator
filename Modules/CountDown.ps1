$t          = New-TimeSpan -Seconds 8
$origpos    = $host.UI.RawUI.CursorPosition
$spinner    = @('☼', '♀', '♂', '♠', '♣', '♥', '♦', '#')
$spinnerPos = 0
$remain     = $t
$d          = ( get-date) + $t
$remain     = ($d - (get-date))

#coundown timer for script execution.
while ($remain.TotalSeconds -gt 0) {
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true).Key
        if ($key -in 'X', 'D', 'Q', 'C', 'V', 'Spacebar', 'Enter') {
            break # keypress to break out from whileloop
        }
    }
    Write-Host (" {0} " -f $spinner[$spinnerPos % 8]) -NoNewline
    write-host (" {0:d3}s {1:d3}ms : Press spacebar/enter to stop script execution" -f $remain.Seconds, $remain.MilliSeconds) -NoNewline
    $host.UI.RawUI.CursorPosition = $origpos
    $spinnerPos += 1
    Start-Sleep -seconds 0.5
    $remain = ($d - (get-date))
}
$host.UI.RawUI.CursorPosition = $origpos
Write-Host " * " -NoNewline

switch ($key) {
	('Spacebar' -or 'Enter') {
        break
    }
    D {
        . $PSScriptRoot\RHID_Diagnostic.ps1
    }
    C {
        Clear-Host
        break
    }
    V {
        Start-Process "https://github.com/chenyong-ng/AutoFAT-run-data-generator/tree/stable"
    }
    default {
        . $PSScriptRoot\Branch.ps1
    }
}