@echo off

 set APATH=\\dom\backup
 set CPATH=%~dp0%.

 :: Get date and time in vars
 for /f "tokens=1-4 delims=/-. " %%G in ('date /t') do (set ADATE=%%I-%%H-%%G)
 for /f "tokens=1-4 delims=:" %%G in ('time /t') do (set ATIME=%%G:%%H)
 
 ntbackup backup "@%CPATH%\backup-docs.bks" /f "%APATH%\docs-1.bkf" /m incremental /l:f /a /d "Инкрементный архив %ADATE% %ATIME%"
