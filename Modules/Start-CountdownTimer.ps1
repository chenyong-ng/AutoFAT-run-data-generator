 
  # ----------------------------------countdown timer-------------------------------------------

      <#
 
    .SYNOPSIS
    Displays a text-based countdown timer in the console.
 
    .DESCRIPTION
    Displays a timer counting down the seconds until the script terminates.
    Parameters control the length that it runs for.
    Only works in the console, because of some console tricks used to display the output.
 
    .EXAMPLE
    ./Start-CountdownTimer -Hours 1 -Minutes 2 -Seconds 3
 
    .PARAMETER Days
    Optional. The number of Days to wait before finishing
 
    .PARAMETER Hours
    Optional. The number of hours to wait before finishing
 
    .PARAMETER Minutes
    Optional. The number of Minutes to wait before finishing
 
    .PARAMETER Seconds
    Optional. The number of Seconds to wait before finishing
 
    .PARAMETER TickLength
    Optional. How long to wait before refreshing
 
    .LINK
    http://blob.pureandapplied.com.au/?p=875
 
    #>
    param (
      [int]$Seconds = 0,
      [int]$TickLength = 1
    )
    $t = New-TimeSpan -Seconds 8
    $origpos = $host.UI.RawUI.CursorPosition
    $spinner =@('|', '/', '-', '\')
    $spinnerPos = 0
    $remain = $t
    $d =( get-date) + $t
    $remain = ($d - (get-date))
    while ($remain.TotalSeconds -gt 0){
      Write-Host (" {0} " -f $spinner[$spinnerPos%4]) -BackgroundColor White -ForegroundColor Black -NoNewline
      write-host (" {0:d2}s " -f $remain.Seconds) -NoNewline
      $host.UI.RawUI.CursorPosition = $origpos
      $spinnerPos += 1
      Start-Sleep -seconds $TickLength
      $remain = ($d - (get-date))
    }
    $host.UI.RawUI.CursorPosition = $origpos
    Write-Host " * "  -BackgroundColor White -ForegroundColor Black -NoNewline
    " Countdown finished"
  