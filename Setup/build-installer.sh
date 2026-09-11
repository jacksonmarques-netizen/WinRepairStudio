#!/bin/bash

# =====================================================================
# Build Script for WinRepair & Optimizer Studio Installer (Linux/macOS)
# Note: ISCC (Inno Setup) is Windows-only, this script prepares the build
# =====================================================================

echo ""
echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║   WinRepair & Optimizer Studio - Build Preparation Script          ║"
echo "║                    For Windows Build Environment                   ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""

# Check for .NET SDK
echo "[1/2] Checking .NET 8.0 SDK..."
dotnet --version > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "ERROR: .NET SDK not found. Please install .NET 8.0 SDK."
    echo "Download from: https://dotnet.microsoft.com/download/dotnet/8.0"
    exit 1
fi
echo "✓ .NET SDK found"
echo ""

# Publish the application
echo "[2/2] Publishing application as single-file executable..."
echo ""
dotnet publish WinRepairStudio.csproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:EnableCompressionInSingleFile=true -p:WindowsPackageType=None

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to publish application."
    exit 1
fi

echo ""
echo "✓ Application published successfully"
echo ""
echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║              BUILD PREPARATION COMPLETED SUCCESSFULLY              ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""
echo "Published files: bin/Release/net8.0-windows10.0.22621.0/win-x64/publish/"
echo ""
echo "NEXT STEP: On a Windows machine, run:"
echo "  1. Copy the project files to Windows"
echo "  2. Run: Setup\\build-installer.bat"
echo "  3. The .exe installer will be generated in: bin\\Installer\\"
echo ""
