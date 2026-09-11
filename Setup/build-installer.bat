@echo off
REM =====================================================================
REM Build Script for WinRepair & Optimizer Studio Installer
REM Requires: Inno Setup 6.0+ and .NET 8.0 SDK
REM =====================================================================

echo.
echo ╔════════════════════════════════════════════════════════════════════╗
echo ║   WinRepair & Optimizer Studio - Build Installer Script            ║
echo ║                          Version 1.0.0                             ║
echo ╚════════════════════════════════════════════════════════════════════╝
echo.

REM Check for .NET SDK
echo [1/3] Checking .NET 8.0 SDK...
dotnet --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: .NET SDK not found. Please install .NET 8.0 SDK.
    echo Download from: https://dotnet.microsoft.com/download/dotnet/8.0
    pause
    exit /b 1
)
echo ✓ .NET SDK found
echo.

REM Publish the application
echo [2/3] Publishing application as single-file executable...
echo.
dotnet publish WinRepairStudio.csproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:EnableCompressionInSingleFile=true -p:WindowsPackageType=None

if errorlevel 1 (
    echo ERROR: Failed to publish application.
    pause
    exit /b 1
)
echo.
echo ✓ Application published successfully
echo.

REM Check for Inno Setup
echo [3/3] Compiling installer with Inno Setup...
echo.

REM Try common Inno Setup installation paths
set ISCC_PATH=
if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" set ISCC_PATH=C:\Program Files (x86)\Inno Setup 6\ISCC.exe
if exist "C:\Program Files\Inno Setup 6\ISCC.exe" set ISCC_PATH=C:\Program Files\Inno Setup 6\ISCC.exe
if exist "C:\Program Files (x86)\Inno Setup 5\ISCC.exe" set ISCC_PATH=C:\Program Files (x86)\Inno Setup 5\ISCC.exe
if exist "C:\Program Files\Inno Setup 5\ISCC.exe" set ISCC_PATH=C:\Program Files\Inno Setup 5\ISCC.exe

REM If not found in standard locations, search PATH
if not defined ISCC_PATH (
    for /f "delims=" %%i in ('where ISCC.exe 2^>nul') do set ISCC_PATH=%%i
)

if not defined ISCC_PATH (
    echo ERROR: Inno Setup not found.
    echo Please install Inno Setup 6.0 or later from: https://jrsoftware.org/isdl.php
    pause
    exit /b 1
)

echo ISCC Path: %ISCC_PATH%
echo.

REM Create output directory if it doesn't exist
if not exist "bin\Installer" mkdir bin\Installer

REM Compile the installer
"%ISCC_PATH%" "Setup\WinRepairStudio_Setup.iss"

if errorlevel 1 (
    echo ERROR: Installer compilation failed.
    pause
    exit /b 1
)

echo.
echo ✓ Installer compiled successfully!
echo.
echo ╔════════════════════════════════════════════════════════════════════╗
echo ║                    BUILD COMPLETED SUCCESSFULLY                    ║
echo ╚════════════════════════════════════════════════════════════════════╝
echo.
echo Output: bin\Installer\WinRepairStudio_Setup_x64.exe
echo.
echo You can now distribute this installer file.
echo Run it on any Windows 10/11 x64 system.
echo.
pause
