 
# Specify the path to the RECMD tool, the hive files, and the batch file
$RECMDPath = 'C:\ForensicTools\ZimmermanTools\RECmd\RECmd.exe'
# Path where the Registry Files are
$HivePath = 'C:\Users\Administrator\Downloads\Evidence\C%3A\Windows\System32\config'
#The System Profiling File
$BatchFilePath = 'C:\ForensicTools\ZimmermanTools\RECmd\BatchExamples\SystemProfiling.reb'

# Use RECmd with the batch file to get the basic information
& $RECMDPath --bn $BatchFilePath -d $HivePath --csv ProfilingInfo
 
