@echo off

REM Enable execution of PowerShell scripts
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope Process -Force"

REM Check if Chocolatey is already installed
where choco >nul 2>&1
if %errorlevel% equ 0 (
    echo Chocolatey is already installed.
) else (
    REM Download and install Chocolatey
    echo Installing Chocolatey...
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "(New-Object System.Net.WebClient).DownloadFile('https://chocolatey.org/install.ps1', '%TEMP%\install-choco.ps1')" && (
        powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\install-choco.ps1"
    )
)

REM Set Chocolatey bin directory to the system PATH
set "PATH=%PATH%;C:\ProgramData\chocolatey\bin"

echo Chocolatey bin directory added to PATH.
echo successfully installed choco