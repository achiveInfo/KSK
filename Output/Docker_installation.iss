[Setup]
PrivilegesRequired=none
AppName=Docker and Additional Software Installation
AppVersion=1.0
DefaultDirName={pf}\DockerInstallation
DefaultGroupName=Docker Installation
OutputDir=.
OutputBaseFilename=Achive_info_Software_Setup3.0
Compression=lzma
SolidCompression=yes

[Files]
Source: "C:\Users\Abhishek Talole\Desktop\New folder (3)\tst\chocolatey-2.2.2.0.msi"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "C:\Users\Abhishek Talole\Desktop\New folder (3)\tst\install.bat"; DestDir: "{app}"; Flags: deleteafterinstall

[Run]
Filename: "{tmp}\chocolatey-2.2.2.0.msi"; Flags: runhidden waituntilterminated; Parameters: "/LOG=""install.log"""
Filename: "{sys}\cmd.exe"; Parameters: "/c dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart"; Flags: runhidden waituntilterminated; Check: Is64BitInstallMode
Filename: "{sys}\cmd.exe"; Parameters: "/c dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart"; Flags: runhidden waituntilterminated; Check: Is64BitInstallMode
Filename: "{sys}\wsl.exe"; Parameters: "--set-default-version 2"; Flags: runhidden waituntilterminated; Check: Is64BitInstallMode
Filename: "{sys}\net.exe"; Parameters: "stop vmcompute"; Flags: runhidden waituntilterminated; Check: Is64BitInstallMode
Filename: "{sys}\timeout.exe"; Parameters: "/t 5 /nobreak"; Flags: runhidden; Check: Is64BitInstallMode
Filename: "{sys}\net.exe"; Parameters: "start vmcompute"; Flags: runhidden waituntilterminated; Check: Is64BitInstallMode
Filename: "{app}\install.bat"; Flags: runhidden
