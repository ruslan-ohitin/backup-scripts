::@echo off

:: --------------------------------------------------
:: Simple batch to backup system partition on the fly
:: You need to install DriveImage XML
:: http://www.runtime.org/driveimage-xml.htm
:: 
:: 
:: Ruslan Ohitin 2008. ruslan.ohitin@gmail.com 
:: --------------------------------------------------

 rem Path to DriveImage XML
 set dpath=%ProgramFiles%\Runtime Software\DriveImage XML

 rem Path to archive directory
 set arcdir=\\dom\backup\
 
 rem get current date as YYYYMMDD
 set curdate=%date:~-4%%date:~3,2%%date:~0,2%
 
 set arcname=%Computername%-%curdate%


 set arcpath=%arcdir%%computername%-1

 if exist "%arcdir%%computername%-3" rmdir /s /q "%arcdir%%computername%-3" 
 if exist "%arcdir%%computername%-2" ren "%arcdir%%computername%-2" "%computername%-3"
 if exist "%arcdir%%computername%-1" ren "%arcdir%%computername%-1" "%computername%-2"

 if not exist "%arcpath%\nul" mkdir "%arcpath%"

 "%dpath%\dixml.exe" /c2 /s /v /b%SystemDrive% /t"%arcpath%\%arcname%"
