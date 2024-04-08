@echo off
REM Wait for Docker installation and pull images
echo "Waiting for Docker installation and pulling images..."
timeout /t 10 /nobreak >nul

REM Pull Docker images
docker pull sudhir1991/achiveapp:mysql
docker pull sudhir1991/achiveapp:php_apache
docker pull sudhir1991/achiveapp:adminer
docker pull sudhir1991/achiveapp:node_app

echo "Images pulled successfully."

REM Create Docker network
docker network create mynet

REM Create Docker volume
docker volume create mysql_data

echo "Docker network and volume created successfully."



REM Copy start.bat using PowerShell to the root of C drive (requires elevated privileges)
powershell -Command "Start-Process cmd.exe -ArgumentList '/c copy \"%~dp0start.bat\" C:\' -Verb RunAs"
echo "start batch file copied successfully to C drive root."

@REM REM Copy run_back.vbs using PowerShell
@REM powershell -Command "Copy-Item 'run_back.vbs' \"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\" -Force"
@REM echo "run batch file copied successfully."

REM Copy run_back.vbs using PowerShell to the Startup folder with elevated privileges
powershell -Command "Start-Process cmd.exe -ArgumentList '/c copy \"%~dp0run_back.vbs\" \"%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"' -Verb RunAs"

echo "run_back.vbs copied successfully to Startup folder."



rem Start the start.bat script
Set objShell = CreateObject("WScript.Shell")
objShell.Run "cmd /c ""C:\start.bat""", 0, True
Set objShell = Nothing

rem Your other commands go here...


echo Installing application silently...

:: Run PowerShell script to start the installation process with administrative privileges
powershell -Command "Start-Process -FilePath \"%~dp0\dist\KSKSOFT Setup 1.0.0.exe\" -ArgumentList '/silent' -Wait -WindowStyle Hidden -Verb RunAs"


:: Check if the installation was successful
if %errorlevel% equ 0 (
    echo Installation complete
) else (
    echo Installation failed
)




