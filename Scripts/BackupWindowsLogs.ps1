# Create a directory for the exported logs
$logDirectory = Join-Path -Path $env:TEMP -ChildPath "WindowsLogs"
New-Item -ItemType Directory -Path $logDirectory -Force

# Get a list of all root event logs (those that do not have a slash in their names)
$logList = wevtutil el | Where-Object { $_ -notmatch '/' }

# Export all root event logs
foreach ($log in $logList) {
    $logPath = Join-Path -Path $logDirectory -ChildPath "$log.evtx"
    Start-Process -FilePath "wevtutil" -ArgumentList "epl `"$log`" `"$logPath`"" -NoNewWindow -Wait
}

# Destination path for the zip file
$destinationPath = Join-Path -Path $env:TEMP -ChildPath "WindowsLogs.zip"

# Create a zip file containing the exported logs
Compress-Archive -Path $logDirectory\* -DestinationPath $destinationPath -Force

# Print the location of the zip file
Write-Output "The zip file has been created at: $destinationPath"
