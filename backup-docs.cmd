@echo off
 
 set APATH=\\dom\backup
 set CPATH=%~dp0%.

 :: Get date and time in vars
 for /f "tokens=1-4 delims=/-. " %%G in ('date /t') do (set ADATE=%%I-%%H-%%G)
 for /f "tokens=1-4 delims=:" %%G in ('time /t') do (set ATIME=%%G:%%H)
 
 if exist %APATH%\docs-3.bkf del %APATH%\docs-3.bkf
 if exist %APATH%\docs-2.bkf ren %APATH%\docs-2.bkf docs-3.bkf
 if exist %APATH%\docs-1.bkf ren %APATH%\docs-1.bkf docs-2.bkf

:: if exist %APATH%\docs-2.bkf del %APATH%\docs-2.bkf
:: if exist %APATH%\docs-1.bkf ren %APATH%\docs-1.bkf docs-2.bkf

:: del "%USERPROFILE%\Local Settings\Application Data\Microsoft\Windows NT\NTBackup\data\*.log" 
 ntbackup backup "@%CPATH%\backup-docs.bks" /f "%APATH%\docs-1.bkf" /m normal /l:f /r:yes /d "Полный архив %ADATE%"
