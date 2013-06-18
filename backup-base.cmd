@echo off
 
 :: Get date and time in vars
 for /f "tokens=1-4 delims=/-. " %%G in ('date /t') do (set ADATE=%%I-%%H-%%G)
 for /f "tokens=1-4 delims=:" %%G in ('time /t') do (set ATIME=%%G:%%H)

 net use z: \\dom\backup
 
 if exist z:\base-3.bkf del z:\base-3.bkf
 if exist z:\base-2.bkf ren z:\base-2.bkf base-3.bkf
 if exist z:\base-1.bkf ren z:\base-1.bkf base-2.bkf

:: if exist \\dom\backup\base-2.bkf del \\dom\backup\base-2.bkf
:: if exist \\dom\backup\base-1.bkf ren \\dom\backup\base-1.bkf docs-2.bkf

:: del "%USERPROFILE%\Local Settings\Application Data\Microsoft\Windows NT\NTBackup\data\*.log" 
 ntbackup backup "@f:\backup\bin\backup-base.bks" /f "z:\base-1.bkf" /m normal /l:f /r:yes /d "Полный архив base от %ADATE%"
 rar a z:\base-logs.rar "%USERPROFILE%\Local Settings\Application Data\Microsoft\Windows NT\NTBackup\data\*.log" 

 ping nas        > f:\backup\bin\nas.log
 net view \\nas >> f:\backup\bin\nas.log

 net use z: /delete
