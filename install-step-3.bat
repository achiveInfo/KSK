@echo off
REM Install Docker Desktop using Chocolatey
echo Installing Docker Desktop...
choco install docker-desktop --force -y
choco install docker-cli --force -y

REM Wait for Docker Desktop installation to complete
timeout /t 180 /nobreak >nul

REM Verify Docker installation
echo Verifying Docker installation...
docker --version
if %errorlevel% equ 0 (
    echo Docker Desktop installed successfully.
) else (
    echo Docker Desktop installation failed.
)

REM Add any additional commands or installations here

REM End of installation process
echo Installation complete.
shutdown /r /t 0