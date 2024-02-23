# Get hostname and current date-time
$hostname = $env:COMPUTERNAME
$dateTime = Get-Date -Format "yyyyMMdd-HHmmss"

# Set the paths and parameters
$zipFilePath = "C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection\Downloads\kape.zip"
$extractPath = [System.IO.Path]::GetTempPath() + "kape"
$kapeExePath = Join-Path -Path $extractPath -ChildPath "kape.exe"

# Create the filename for the zip output
$zipFilename = "${hostname}_${dateTime}.zip"
$outputPath = Join-Path -Path "C:\kape\output" -ChildPath $zipFilename

# Create parameters string
$params = "--tsource C:\ --tdest C:\kape\output --tflush --target !IISLogFiles --zip $zipFilename"


# Function to check and create the extraction directory if it does not exist
function Ensure-Directory {
    param (
        [string]$Path
    )
    if (-not (Test-Path -Path $Path -PathType Container)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

# Function to extract zip files
function Extract-ZipFile {
    param (
        [string]$ZipFilePath,
        [string]$DestinationPath
    )
    $shell = New-Object -ComObject Shell.Application
    $zipFile = $shell.NameSpace($ZipFilePath)
    $destination = $shell.NameSpace($DestinationPath)
    $destination.CopyHere($zipFile.Items(), 0x10) # 0x10 flag to suppress dialog

    # Wait for the extraction to complete
    while ($destination.Items().Count -lt $zipFile.Items().Count) {
        Start-Sleep -Milliseconds 500
    }
}

# Main script execution
try {
    Ensure-Directory -Path $extractPath
    Extract-ZipFile -ZipFilePath $zipFilePath -DestinationPath $extractPath

    if (Test-Path -Path $kapeExePath) {
        Start-Process -FilePath $kapeExePath -ArgumentList $params -Wait
    } else {
        Write-Error "KAPE executable not found at path: $kapeExePath"
    }
} catch {
    Write-Error "An error occurred: $_"
}
