# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force;
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Python
choco install python -y

# Refresh environment variables
refreshenv

# Install pip
python -m ensurepip --upgrade

# Install Selenium
pip install selenium

# Install Google Chrome
choco install googlechrome -y

# Install ChromeDriver
choco install chromedriver -y

# Install Adobe Acrobat Reader
choco install adobereader -y

# Install Open Office
choco install openoffice -y
