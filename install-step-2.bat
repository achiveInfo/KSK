@echo off

@REM REM Enable Chocolatey feature to exit on reboot detection
@REM choco feature enable --name="exitOnRebootDetected"
@REM REM Upgrade Chocolatey and exit if reboot is detected
@REM choco upgrade chocolatey --exit-when-reboot-detected -y

REM Check if WSL and Virtual Machine Platform features are already enabled
echo Checking WSL and Virtual Machine Platform features...

REM Check if WSL is enabled
dism.exe /online /get-featureinfo /featurename:Microsoft-Windows-Subsystem-Linux | find "State : Enabled" >nul
if %errorlevel% equ 0 (
    echo WSL is already enabled.
) else (
    REM Enable WSL
    echo Enabling WSL...
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
)

REM Check if Virtual Machine Platform is enabled
dism.exe /online /get-featureinfo /featurename:VirtualMachinePlatform | find "State : Enabled" >nul
if %errorlevel% equ 0 (
    echo Virtual Machine Platform is already enabled.
) else (
    REM Enable Virtual Machine Platform
    echo Enabling Virtual Machine Platform...
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
)

REM Set default WSL version to 2
echo Setting WSL default version to 2...
wsl --set-default-version 2

REM Start VM Compute service
echo Starting VM Compute service...
net start vmcompute

REM Restart PC
echo Restarting the computer...
shutdown /r /t 0

