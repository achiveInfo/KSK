@echo off

REM Set Execution Policy for PowerShell Scripts
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

REM Start Docker Desktop using PowerShell in the background
powershell -Command "Start-Process -FilePath 'C:\Program Files\Docker\Docker\Docker Desktop.exe' -WindowStyle Hidden"

REM Add a timeout of 10 seconds (adjust as needed)
timeout /t 12

REM Remove containers if they exist
docker rm -f php_apache mysql adminer node_app

REM Run the PHP Apache container
docker run -d -p 80:80 --network mynet --name php_apache sudhir1991/achiveapp:php_apache

REM Run the MySQL container
docker run -d -p 3307:3306 --network mynet --restart always --name mysql -v mysql_data:/var/lib/mysql sudhir1991/achiveapp:mysql

REM Run the Adminer container
docker run -d -p 8080:8080 --network mynet --restart always --name adminer sudhir1991/achiveapp:adminer

REM Run the Node.js container
docker run -d -p 3001:3001 --network mynet --restart always --name node_app sudhir1991/achiveapp:node_app
