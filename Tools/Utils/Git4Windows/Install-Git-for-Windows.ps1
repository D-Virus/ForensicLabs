# This script installs Git for Windows
# Author: dvirus
# Check the lastest release here https://github.com/git-for-windows/git/releases/ and update the following path
$gitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.40.1.windows.1/Git-2.40.1-64-bit.exe"
$installerPath = "$env:TEMP\GitInstaller.exe"

# Download the installer
Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $installerPath

# Install Git
Start-Process -FilePath $installerPath -ArgumentList "/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /NOICONS /COMPONENTS=`"icons,ext\reg\shellhere,assoc,assoc_sh`"" -Wait -PassThru

# Delete the installer
Remove-Item -Path $installerPath 
