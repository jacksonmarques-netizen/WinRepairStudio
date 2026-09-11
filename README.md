# WinRepair & Optimizer Studio

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows%2010%2F11%20x64-blue.svg)](https://www.microsoft.com/windows)
[![.NET Version](https://img.shields.io/badge/.NET-8.0-512BD4.svg)](https://dotnet.microsoft.com/)
[![UI Framework: WinUI 3](https://img.shields.io/badge/UI-WinUI%203-0078D4.svg)](https://microsoft.github.io/microsoft-ui-xaml/)

**Professional Windows 10/11 System Repair & Optimization Tool**

A comprehensive desktop application for diagnosing, repairing, and optimizing Windows systems. Built with modern technologies (.NET 8.0, WinUI 3, MVVM architecture) and designed with safety-first principles.

---

## 🎯 Features

### 🔧 System Repair
- **DISM Image Restoration** - Repair Windows component store corruption
- **System File Checker (SFC)** - Scan and fix corrupted system files
- **Boot & MBR Repair** - Fix boot sector and master boot record issues
- **BCD Rebuild** - Restore boot configuration data

### 💾 Disk & Storage Tools
- **Deep Disk Cleanup** - Remove temporary files, cache, and recycle bin
- **WinSxS Cleanup** - Optimize Windows component store
- **Drive Optimization** - TRIM and defragmentation
- **Bloatware Removal** - Uninstall pre-installed applications

### 🌐 Network & Connectivity
- **Network Stack Reset** - Full Winsock and TCP/IP restoration
- **DNS Flush** - Clear DNS cache
- **DHCP Management** - Release and renew IP configuration
- **Network Diagnostics** - Identify connectivity issues

### ⚡ Startup & Power Management
- **Startup Item Manager** - Enable/disable startup applications
- **Hibernation Control** - Configure sleep/hibernation settings
- **Power Configuration** - Optimize power usage
- **Energy Reports** - Generate power consumption analysis

### 📊 System Restore Points
- **Automatic Backup** - Create restore points before critical operations
- **Restore Management** - Browse and restore previous system states
- **Registry Backup** - Backup registry keys before modifications
- **Rollback Capability** - Undo changes safely

---

## ⚠️ Safety Features

✅ **Administrator Validation** - Requires UAC elevation for system modifications
✅ **Automatic Restore Points** - System restore point created before repairs
✅ **User Confirmation** - Dialog boxes for all destructive operations
✅ **Registry Backup** - .reg files created before registry changes
✅ **Non-Critical Operations** - Preserves essential Windows files
✅ **Comprehensive Logging** - All operations logged to local files
✅ **Error Handling** - Graceful degradation on operation failures

---

## 📋 System Requirements

| Requirement | Details |
|-------------|----------|
| **OS** | Windows 10 (Build 17763+) or Windows 11 |
| **Architecture** | 64-bit (x64) only |
| **RAM** | Minimum 2 GB (Recommended 4+ GB) |
| **Disk Space** | Minimum 500 MB free |
| **Runtime** | .NET 8.0 Desktop Runtime |
| **Privileges** | Administrator (UAC elevation required) |

---

## 🚀 Installation

### Option 1: Using the Installer (Recommended)

1. Download `WinRepairStudio_Setup_x64.exe` from [Releases](https://github.com/jacksonmarques-netizen/WinRepairStudio/releases)
2. Right-click the installer → **Run as Administrator**
3. Follow the installation wizard
4. Select desired components and language
5. Click **Install** and wait for completion
6. Optionally launch the application

### Option 2: Manual Build from Source

```bash
# Clone the repository
git clone https://github.com/jacksonmarques-netizen/WinRepairStudio.git
cd WinRepairStudio

# Restore NuGet packages
dotnet restore

# Build the project
dotnet build -c Release

# Publish as single-file executable
dotnet publish WinRepairStudio.csproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:EnableCompressionInSingleFile=true
```

### Option 3: Build Installer from Source

**Prerequisites:**
- .NET 8.0 SDK
- Inno Setup 6.0+ ([Download](https://jrsoftware.org/isdl.php))

**Windows:**
```cmd
cd Setup
build-installer.bat
```

The installer will be generated in: `bin\Installer\WinRepairStudio_Setup_x64.exe`

---

## 📖 Usage

1. **Launch the Application**
   ```
   Right-click WinRepairStudio.exe → Run as Administrator
   ```

2. **Navigate to Your Needed Tool**
   - Dashboard - View system health
   - System Repair - Fix Windows files
   - Disk Tools - Optimize storage
   - Network - Reset connectivity
   - Startup & Power - Manage startup items
   - Restore Points - Manage system backups

3. **Confirm Operations**
   - Read the operation description
   - Click the tool button
   - Confirm the action in the dialog
   - Monitor the progress log

4. **Review Results**
   - Check the output log for status
   - System Restore Points are automatically created
   - Logs are saved locally for reference

---

## 🏗️ Architecture

### Project Structure

```
WinRepairStudio/
├── Helpers/                    # Common utilities
│   ├── ObservableObject.cs    # Base MVVM class
│   ├── RelayCommand.cs        # Synchronous command
│   ├── AsyncRelayCommand.cs   # Asynchronous command
│   └── DialogHelper.cs        # Dialog utilities
├── Models/                     # Data models
│   ├── CommandResult.cs       # Process execution result
│   ├── StartupItem.cs         # Startup entry
│   └── RestorePointItem.cs    # System restore point
├── Services/                   # Business logic layer
│   ├── ProcessExecutionService.cs    # Run system commands
│   ├── SystemRestoreService.cs       # Manage restore points
│   ├── SystemRepairService.cs        # DISM, SFC, Boot repair
│   ├── DiskService.cs                # Disk cleanup & optimization
│   ├── NetworkService.cs             # Network reset
│   ├── PowerStartupService.cs        # Startup & power management
│   ├── LoggerService.cs              # Centralized logging
│   └── AppServices.cs                # Service locator
├── ViewModels/                 # MVVM ViewModel layer
│   ├── DashboardViewModel.cs
│   ├── SystemRepairViewModel.cs
│   ├── DiskToolsViewModel.cs
│   ├── NetworkViewModel.cs
│   ├── StartupPowerViewModel.cs
│   └── RestorePointsViewModel.cs
├── Views/                      # XAML Views
│   ├── DashboardPage.xaml(.cs)
│   ├── SystemRepairPage.xaml(.cs)
│   ├── DiskToolsPage.xaml(.cs)
│   ├── NetworkPage.xaml(.cs)
│   ├── StartupPowerPage.xaml(.cs)
│   └── RestorePointsPage.xaml(.cs)
├── Setup/                      # Installer files
│   ├── WinRepairStudio_Setup.iss  # Inno Setup script
│   ├── build-installer.bat        # Build script (Windows)
│   └── build-installer.sh         # Build script (Linux/macOS)
├── app.manifest                # UAC elevation manifest
├── WinRepairStudio.csproj      # Project file
├── WinRepairStudio.sln         # Solution file
├── LICENSE.txt                 # MIT License
└── README.md                   # This file
```

### Design Patterns

- **MVVM Pattern** - Clean separation of concerns
- **Dependency Injection** - Loosely coupled services via `AppServices`
- **Observer Pattern** - `INotifyPropertyChanged` for data binding
- **Command Pattern** - `RelayCommand` and `AsyncRelayCommand`
- **Service Locator** - Centralized service management

---

## 🔒 Security Considerations

### What This Tool Does

✅ Repairs Windows system files and components  
✅ Resets network configuration (Winsock, TCP/IP, DNS)  
✅ Cleans temporary and cache files  
✅ Manages startup items and power settings  
✅ Creates and manages System Restore Points  

### What This Tool Does NOT Do

❌ Does not collect or transmit personal data  
❌ Does not have network telemetry or analytics  
❌ Does not install additional software  
❌ Does not modify non-critical system files  
❌ Does not require internet connection (except for .NET runtime)  

### Important Notes

⚠️ **Always create backups** before using this tool  
⚠️ **Run as Administrator** - System modifications require elevation  
⚠️ **Do not interrupt operations** - DISM/SFC can take 30+ minutes  
⚠️ **System Restore Points are automatic** - But create external backups  
⚠️ **Network reset will disconnect all connections** - Save work first  

---

## 🔧 Development

### Prerequisites

- Visual Studio 2022 or VS Code
- .NET 8.0 SDK
- Windows 10/11 (x64)

### Build & Run

```bash
# Restore dependencies
dotnet restore

# Build in Debug mode
dotnet build

# Run the application (requires elevation)
dotnet run
```

### Project Configuration

```xml
<PropertyGroup>
  <OutputType>WinExe</OutputType>
  <TargetFramework>net8.0-windows10.0.22621.0</TargetFramework>
  <TargetPlatformMinVersion>10.0.17763.0</TargetPlatformMinVersion>
  <UseWinUI>true</UseWinUI>
  <Nullable>enable</Nullable>
  <ImplicitUsings>enable</ImplicitUsings>
</PropertyGroup>
```

---

## 📝 Logging

All operations are logged to:
```
C:\Users\[YourUsername]\AppData\Roaming\WinRepairStudio\Logs\exec_[YYYYMMDD].log
```

Log Format:
```
[2026-09-11 14:30:45] [INFO] Executando: sfc /scannow
[2026-09-11 14:31:02] [INFO] Concluído (sfc /scannow) - ExitCode: 0 - Tempo: 17000ms
```

---

## 🐛 Troubleshooting

### Application Won't Start

1. Verify .NET 8.0 Runtime is installed
   ```bash
   dotnet --info
   ```
2. Run as Administrator
3. Check system logs for error details

### Operations Failing

1. Ensure Administrator privileges
2. Disable antivirus temporarily
3. Restart the application
4. Check logs in `AppData\Roaming\WinRepairStudio\Logs`

### Network Reset Issues

1. ⚠️ **WARNING**: Will disconnect all active connections
2. Disable VPN and proxies first
3. Static IPs may be reset to DHCP
4. System restart may be required

---

## 📄 License

This project is licensed under the MIT License - see [LICENSE.txt](LICENSE.txt) for details.

### Disclaimer

This software is provided "AS IS" without warranty. Use at your own risk. The developers are not responsible for data loss or system damage resulting from improper use of this tool.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📞 Support

For issues, questions, or suggestions:

- 📧 Create an issue on [GitHub Issues](https://github.com/jacksonmarques-netizen/WinRepairStudio/issues)
- 💬 Discussions available in [GitHub Discussions](https://github.com/jacksonmarques-netizen/WinRepairStudio/discussions)
- 📖 Check the [Wiki](https://github.com/jacksonmarques-netizen/WinRepairStudio/wiki) for detailed guides

---

## 🎉 Acknowledgments

Built with:
- [Microsoft .NET 8.0](https://dotnet.microsoft.com/)
- [Windows App SDK / WinUI 3](https://microsoft.github.io/microsoft-ui-xaml/)
- [Inno Setup](https://jrsoftware.org/isinfo.php)
- [Community Contributions](https://github.com/jacksonmarques-netizen/WinRepairStudio/graphs/contributors)

---

**Made with ❤️ for the Windows community**

*Last Updated: 2026-09-11*
