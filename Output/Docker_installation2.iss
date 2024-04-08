[Setup]
AppName=KSK and Docker Software Installation
AppVersion=1.0
DefaultDirName={commonpf}\ArchiveInfoSoftware
DefaultGroupName=AchiveInfo
OutputDir=.Output
OutputBaseFilename=Achive_info_Software_Setup3.0
Compression=lzma
SolidCompression=yes



[Dirs]
Name: "{app}\dist"; Permissions: users-full

[Tasks]
Name: desktopicon; Description: "Create a desktop icon"; GroupDescription: "Additional tasks:";

[Icons]
Name: "{commondesktop}\My Program"; Filename: "{app}\ArchiveInfo.10.exe"; Tasks: desktopicon

[Run]
Filename: "{cmd}"; Parameters: "/c powershell -Command ""Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"""; \
    Flags: runhidden waituntilterminated; StatusMsg: "Setting Execution Policy for PowerShell Scripts..."
Filename: "{cmd}"; Parameters: "/c dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Enabling Windows Subsystem for Linux..."
Filename: "{cmd}"; Parameters: "/c dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Enabling Virtual Machine Platform..."
Filename: "{cmd}"; Parameters: "/c wsl --set-default-version 2"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Setting WSL default version to 2..."
Filename: "{cmd}"; Parameters: "/c net stop vmcompute"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Stopping vmcompute service..."
Filename: "{cmd}"; Parameters: "/c timeout /t 5 /nobreak"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Waiting for 5 seconds..."
Filename: "{cmd}"; Parameters: "/c net start vmcompute"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Starting vmcompute service and restarting PC...";
Filename: "{cmd}"; Parameters: "/c shutdown /r /t 0"; Flags: runhidden

;Filename: "{cmd}"; Parameters: "/c echo Post-installation action 1"; Flags: runhidden postinstall
;Filename: "{app}\ArchiveInfo.10.exe"; Flags: postinstall shellexec waituntilterminated

Filename: "{cmd}"; Parameters: "/c choco install docker-desktop "; \
    Flags: runhidden waituntilterminated; StatusMsg: "Installing Docker Desktop Using Chocolatey..."
Filename: "{cmd}"; Parameters: "/c powershell -Command ""Start-Process -FilePath 'C:\Program Files\Docker\Docker\Docker Desktop.exe' -WindowStyle Hidden"""; \
    Flags: runhidden waituntilterminated; StatusMsg: "Starting Docker Desktop application..."
Filename: "{cmd}"; Parameters: "/c timeout /t 10 /nobreak >nul"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Waiting for Docker installation and pulling images..."
Filename: "{cmd}"; Parameters: "/c docker network create mynet"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Creating Docker network..."
Filename: "{cmd}"; Parameters: "/c docker volume create mysql_data"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Creating Docker volume..."
Filename: "{cmd}"; Parameters: "/c docker pull sudhir1991/achiveapp:mysql"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Pulling MySQL Docker image..."
Filename: "{cmd}"; Parameters: "/c docker pull sudhir1991/achiveapp:php_apache"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Pulling PHP Apache Docker image..."
Filename: "{cmd}"; Parameters: "/c docker pull sudhir1991/achiveapp:adminer"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Pulling Adminer Docker image..."
Filename: "{cmd}"; Parameters: "/c docker pull sudhir1991/achiveapp:node_app"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Pulling Node.js Docker image..."
Filename: "{cmd}"; Parameters: "/c powershell -Command ""Start-Process cmd.exe -ArgumentList '/c copy '%~dp0start.bat' C:\' -Verb RunAs"""; \
    Flags: runhidden waituntilterminated; StatusMsg: "Copying start.bat using PowerShell to the root of C drive..."
Filename: "{cmd}"; Parameters: "/c powershell -Command ""Start-Process cmd.exe -ArgumentList '/c copy '%~dp0run_back.vbs' '%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\'' -Verb RunAs"""; \
    Flags: runhidden waituntilterminated; StatusMsg: "Copying run_back.vbs to Startup folder..."
Filename: "{cmd}"; Parameters: "/c powershell -Command ""Start-Process -FilePath '%~dp0\dist\KSKSOFT Setup 1.0.0.exe' -ArgumentList '/silent' -Wait -WindowStyle Hidden -Verb RunAs"""; \
    Flags: runhidden waituntilterminated; StatusMsg: "Running KSKSOFT Setup silently..."
Filename: "{cmd}"; Parameters: "/c if ERRORLEVEL 0 ( echo Installation complete ) else ( echo Installation failed )"; \
    Flags: runhidden waituntilterminated; StatusMsg: "Checking if the installation was successful..."

[Code]
function IsAdminInstall: Boolean;
begin
  Result := IsAdminLoggedOn;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  StartTime: Integer;
  EndTime: Integer;
  ResultCode: Integer;
begin
  if CurStep = ssPostInstall then
  begin
    StartTime := GetTickCount;
    if not IsAdminInstall then
    begin
      WizardForm.StatusLabel.Caption := 'Installing Docker Desktop...';
      WizardForm.ProgressBar.Position := 25;
      Exec('cmd.exe', '/c choco install docker-desktop', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
      EndTime := GetTickCount;
      WizardForm.ProgressBar.Position := 50;
      WizardForm.StatusLabel.Caption := 'Docker Desktop installation completed.';
      MsgBox('Docker Desktop installation completed.' + #13#10 + 'Time taken: ' + IntToStr((EndTime - StartTime) div 1000) + ' seconds', mbInformation, MB_OK);
    end;
    WizardForm.ProgressBar.Position := 100;
  end;
end;