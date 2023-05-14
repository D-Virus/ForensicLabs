# Download Sysmon
Invoke-WebRequest -Uri "https://live.sysinternals.com/Sysmon64.exe" -OutFile "C:\Sysmon64.exe"

# Download SwiftOnSecurity's Sysmon configuration
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile "C:\sysmonconfig.xml"

# Install Sysmon with the downloaded config, and accept the EULA
Start-Process -FilePath "C:\Sysmon64.exe" -ArgumentList "-i C:\sysmonconfig.xml -accepteula" -NoNewWindow -Wait

# Remove the downloaded executables
Remove-Item "C:\Sysmon64.exe"

# Check if the Sysmon service is running
$service = Get-Service -Name "Sysmon64"

if ($service.Status -ne 'Running') {
    # Start the Sysmon service
    Start-Service -Name "Sysmon64"
}

# Generate a network connection event
Invoke-WebRequest -Uri "http://github.com" -UseBasicParsing | Out-Null

# Wait a few seconds for the event to be logged
Start-Sleep -Seconds 10

# Check the event log for the network connection event
$events = Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 10 | Where-Object { $_.Id -eq 3 }

if ($events) {
    Write-Output "Sysmon is working correctly. Found recent network connection event(s):"
    Write-Output $events
} else {
    Write-Output "No recent network connection events found. Sysmon may not be working correctly."
}
