#Eric Zimmerman Forensic Tools Installer
#Author: Daniel Rodriguez 

function Unzip
{
    param([string]$zipfile, [string]$outpath)

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

$toolsDir = "$env:USERPROFILE\Desktop\ForensicTools\ZimmermanTools"
$toolZipUrl = "https://f001.backblazeb2.com/file/EricZimmermanTools/net6/All_6.zip"
$toolZipPath = Join-Path -Path $toolsDir -ChildPath "All_6.zip"

# Check if the tools directory exists, if not, create it
if (!(Test-Path -Path $toolsDir)) {
    New-Item -ItemType Directory -Path $toolsDir | Out-Null
}

# Download the zip file
Invoke-WebRequest -Uri $toolZipUrl -OutFile $toolZipPath

# Extract the contents of the main zip file
Expand-Archive -Path $toolZipPath -DestinationPath $toolsDir -Force

# Remove the downloaded zip file
Remove-Item -Path $toolZipPath

# Extract the contents of each nested zip file
Get-ChildItem -Path $toolsDir -Recurse -Filter "*.zip" | ForEach-Object {
    $folderPath = $_.DirectoryName
    Unzip -zipfile $_.FullName -outpath $folderPath
    Remove-Item $_.FullName
}

# Add the tools directory to the PATH environment variable for the current session
$env:Path += ";$toolsDir"

# Add the tools directory to the PATH environment variable permanently for the current user
[Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::User)
 
