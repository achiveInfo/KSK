Achive Info Solutions software installation process Using Batch Files: -

-- Installation Using Batch files

1. Run install-step-1.bat file using Run as administrator
   -- in this section install chocoletary and set chocoletary bin path in envirornment variable

2. Run install-step-2.bat file using Run as administrator
   -- in this section enable windows features wsl and virtual coputing platform 
   -- wsl --set-default-version 2 comand 1
   -- net stop vmcompute command 2
   -- net start vmcompute   command 3
   -- After changes take effect set restart pc

3. Run install-step-3.bat file using Run as administrator
   -- in this section installing docker desktop and set path in envirornment vairable

4. Run install-step-4.bat file using Run as administrator
   -- in this section installing set time for starting docker in  10 seconds
   -- pulling all images in container
   -- move start.bat file in c drive like C:/start.bat
   -- move run_back.vbs file in startup folder
   -- start the start.bat file using command
   -- install ksksoftware/achive software and run

Achive Info Solutions software installation process Using Manual: -
1.Enable windows features wsl and virtual coputing platform  
2.Restart pc
3.Install Docker desktop exe (Downloading On Official Website )
3.Start Desktop Docker
4.Run install-step-4.bat file (Run as Administrator)


ERROR LIST
1.Virtulization ERROR for HP
Solution : Restart PC press Esc or F10 Key for boot options after got o 
           Advanced Options->System Options->checkmark Virtulization 
           after press esc and save changes.

           screen shot:












