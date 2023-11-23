#Path definitions 
$zipFilePath = "C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection\Downloads\kape.zip"
$tempExtractPath = [System.IO.Path]::GetTempPath() + "kape"
$outputPath = "C:\Windows\Temp\kapeoutput"

# Get hostname and current date-time
$hostname = $env:COMPUTERNAME
$dateTime = Get-Date -Format "yyyyMMdd-HHmmss"

# Set the paths and parameters
$kapeExePath = Join-Path -Path $tempExtractPath -ChildPath "kape.exe"
$zipFilename = "${hostname}"
$fullZipFilePath = Join-Path -Path $outputPath -ChildPath $zipFilename
$params = "--tsource C:\ --tdest $outputPath --tflush --target !SANS_Triage --zip $zipFilename"

# Function to check and create a directory
function Ensure-Directory {
    param ([string]$Path)
    if (-not (Test-Path -Path $Path -PathType Container)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

# Function to extract zip files
function Extract-ZipFile {
    param ([string]$ZipFilePath, [string]$DestinationPath)
    $shell = New-Object -ComObject Shell.Application
    $zipFile = $shell.NameSpace($ZipFilePath)
    $destination = $shell.NameSpace($DestinationPath)
    $destination.CopyHere($zipFile.Items(), 0x10) # 0x10 flag to suppress dialog

    # Wait for extraction to complete
    while ($destination.Items().Count -lt $zipFile.Items().Count) {
        Start-Sleep -Milliseconds 500
    }
}

# Main script execution
try {
    Ensure-Directory -Path $tempExtractPath
    Ensure-Directory -Path $outputPath
    Extract-ZipFile -ZipFilePath $zipFilePath -DestinationPath $tempExtractPath

    if (Test-Path -Path $kapeExePath) {
        Start-Process -FilePath $kapeExePath -ArgumentList $params -Wait

        # Generate hashes for the zip file
        if (Test-Path -Path $fullZipFilePath) {
            $hashFile = Join-Path -Path $outputPath -ChildPath "output.hash"
            $hashes = @("MD5", "SHA1", "SHA256") | ForEach-Object {
                $hash = Get-FileHash -Path $fullZipFilePath -Algorithm $_
                "$($_): $($hash.Hash)"
            }
            $hashes | Out-File -FilePath $hashFile -Encoding UTF8
        } else {
            Write-Error "Zip file not found: $fullZipFilePath"
        }
    } else {
        Write-Error "KAPE executable not found at path: $kapeExePath"
    }
} catch {
    Write-Error "An error occurred: $_"
}
