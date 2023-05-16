Description: Custom RECmd Batch File
Author: @dvirus
Version: 1.0
Id: 12345678-90ab-cdef-1234-567890abcdef
Keys:
    -
        Description: Computer Name
        HiveType: SYSTEM
        Category: System Info
        KeyPath: ControlSet*\Control\ComputerName\*
        ValueName: ComputerName
        Recursive: false
        Comment: "Computer Name"
    -
        Description: Shutdown Time
        HiveType: SYSTEM
        Category: System Info
        KeyPath: ControlSet00*\Control\Windows
        ValueName: ShutdownTime
        Recursive: false
        IncludeBinary: true
        BinaryConvert: FILETIME
        Comment: "Last system shutdown time"
    -
        Description: Time Zone
        HiveType: SYSTEM
        Category: System Info
        KeyPath: ControlSet001\Control\TimeZoneInformation
        ValueName: TimeZoneKeyName
        Recursive: false
    -
        Description: Operating System
        HiveType: SOFTWARE
        Category: System Info
        KeyPath: Microsoft\Windows NT\CurrentVersion
        Recursive: false
    -
        Description: Tcpip4 Interfaces
        HiveType: System
        Category: System Info
        KeyPath: ControlSet*\Services\Tcpip\Parameters\Interfaces\*
        Recursive: false
        Comment:
    -
        Description: SystemPartition
        HiveType: System
        Category: System Info
        KeyPath: Setup
        ValueName: SystemPartition
        Recursive: false
        Comment:
    -
        Description: Installed Programs
        HiveType: SOFTWARE
        Category: Software
        KeyPath: Microsoft\Windows\CurrentVersion\Uninstall
        Recursive: true
    -
        Description: User Accounts (SECURITY)
        HiveType: SECURITY
        Category: User Accounts
        KeyPath: Policy\Accounts\*
        IncludeBinary: true
        Recursive: false
        Comment: "Built-in accounts in SECURITY hive"
    -
        Description: User Accounts (SAM)
        HiveType: SAM
        Category: User Accounts
        KeyPath: SAM\Domains\Account\Users
        Recursive: false
        Comment: "User accounts in SAM hive"
    -
        Description: TotalPhysicalRAM
        HiveType: Amcache
        Category: System Info
        KeyPath: DeviceCensus\Memory
        ValueName: TotalPhysicalRAM
        Recursive: false
        Comment:
