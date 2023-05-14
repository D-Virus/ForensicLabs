 # Registry path
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters"

# Check if the registry key exists
if (!(Test-Path $registryPath)) {
    # Create the registry key
    New-Item -Path $registryPath -Force | Out-Null
}

# Enable Prefetch (3 = Application and Boot prefetching)
Set-ItemProperty -Path $registryPath -Name "EnablePrefetcher" -Value 3

# Test Prefetch by checking the Prefetch folder
$prefetchFolder = "C:\Windows\Prefetch"
$prefetchFiles = Get-ChildItem -Path $prefetchFolder

if ($prefetchFiles) {
    Write-Output "Prefetch is working correctly. Found files in the Prefetch folder:"
    Write-Output $prefetchFiles
} else {
    Write-Output "No files found in the Prefetch folder. Prefetch may not be working correctly."
}
 
