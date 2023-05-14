# Registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

# Check if the registry key exists
if (!(Test-Path $registryPath)) {
    # Create the registry key
    New-Item -Path $registryPath -Force | Out-Null
}

# Enable PowerShell script block logging
Set-ItemProperty -Path $registryPath -Name "EnableScriptBlockLogging" -Value 1

# Test script block logging
Invoke-Expression "Write-Output 'Testing script block logging...'"

# Wait a few seconds for the event to be logged
Start-Sleep -Seconds 10

# Check the event log for the test script block event
$events = Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" -MaxEvents 10 | Where-Object { $_.Id -eq 4104 }

if ($events) {
    Write-Output "PowerShell script block logging is working correctly. Found recent script block logging event(s):"
    Write-Output $events
} else {
    Write-Output "No recent script block logging events found. PowerShell script block logging may not be working correctly."
}
