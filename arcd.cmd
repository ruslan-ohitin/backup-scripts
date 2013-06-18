::@echo off

 set MAXCNT=7
 set CPATH=%~dp0%.
 set APATH=%~dp0%..

 set AEXT=rar

:rep
 set ANAME=%1

 if "%ANAME%"=="" goto end
 if not exist "%CPATH%\%ANAME%.inc" goto end
 if not exist "%CPATH%\%ANAME%.xcl" goto end

 setlocal EnableDelayedExpansion

 for /l %%i in (%MAXCNT%,-1,1) do (
	if %%i==%MAXCNT% (
		if exist "%APATH%\%ANAME%-%%i" rmdir /s /q "%APATH%\%ANAME%-%%i" 
	) else (
		set /a j=%%i+1
		rem echo %%i !j!
 		if exist "%APATH%\%ANAME%-%%i" ren "%APATH%\%ANAME%-%%i" "%ANAME%-!j!"
	)
 )

 endlocal

 :: Get date and time in vars
 for /f "tokens=1-4 delims=/-. " %%G in ('date /t') do (set ADATE=%%I%%H%%G)
 for /f "tokens=1-4 delims=:" %%G in ('time /t') do (set ATIME=%%G:%%H)

 mkdir "%APATH%\%ANAME%-1"
 "%CPATH%\rar.exe" a -r -rr -se -m5 -dh -os -ow -y -idp -ilog -x@"%CPATH%\%ANAME%.xcl" "%APATH%\%ANAME%-1\%ANAME%-%ADATE%.%AEXT%" @"%CPATH%\%ANAME%.inc"

 shift
 goto rep

:end
