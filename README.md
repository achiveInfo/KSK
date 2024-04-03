# KSK
Details about project

## Main Installing Steps 
1)  install.bat file run as administrator in cmd.
2)  pull.bat file run as administrator in cmd.
3)  start.bat file run as administrator in cmd.


## Software Installation

A) Install Batch File (env setup for project) :
  1) Enable execution of PowerShell scripts
  2) Check if Chocolatey is already installed
  3) Download and install Chocolatey
     ( Note : If Chocolately is alredy install then not need to install again.) 
  4) Set Chocolatey bin directory to the system PATH
  5) Start WSL and set default version to 2
  6) Start VM Compute
  7) Install Docker Desktop using Chocolatey
  8) Wait for Docker Desktop installation to complete
  9) Verify Docker installation

B) Pull Docker Images (for Docker Setup) :
  1) Pull Docker images
  2) Create Docker network
  3) Create Docker volume
  4) Copy start.bat using PowerShell to the root of C drive (requires elevated privileges)
  5) Copy run_back.vbs using PowerShell
  6) Copy run_back.vbs using PowerShell to the Startup folder with elevated privileges
  7) Run PowerShell script to start the installation process with administrative privileges
     ("%~dp0\dist\KSKSOFT Setup 1.0.0.exe\")
  8) Check if the installation was successfull

C) Start Batch Files
  1) Set Execution Policy for PowerShell Scripts
  2) Start Docker Desktop using PowerShell in the background
  3) Add a timeout of 10 seconds (adjust as needed)
  4) Remove containers if they exist
  5) Run the PHP Apache container
  6) Run the MySQL container
  7) Run the Adminer container
  8) Run the Node.js container
