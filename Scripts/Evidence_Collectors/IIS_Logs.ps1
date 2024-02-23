# Author: @dvirus
# This script runs kape via Microsoft Windows Defender via LiveResponse Session
# PowerShell script to execute IIS_Log_Collector.exe and det ISS Logs for Forensic Investigations

# Specify the full path to the IIS_Log_Collector.exe file
$exePath = "C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection\Downloads\IIS_Log_Collector.exe"

# Use the Start-Process cmdlet to execute the .exe file
Start-Process -FilePath $exePath
