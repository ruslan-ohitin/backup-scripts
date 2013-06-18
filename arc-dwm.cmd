@echo off

 set VERSION=2009-11-18

 setlocal enabledelayedexpansion

 set DEBUG=1

::
:: Создание архивных копий и автоматическое переименование старых архивов.
::
:: Обязательный параметр - имя пакета архивации:
:: 		arc-dwn.cmd name
:: Должны существовать файлы name.inc и name.xcl, содержащие маски файлов,
:: включаемых и исключаемых из архива
:: Архив создается с помощью rar.exe
::
:: Схема переименования старых архивов.
:: Существущий архив name-d7.rar удаляется
:: Каждый день происходит "сдвиг" в нумрации старых файлов:
:: name-d6.rar переименовывается в name-d7.rar и т.п.
:: создается текущий архив с именем name-d1.rar
::
:: Если удаляемый архив name-d7.rar старше архива name-w1.rar на 7 или 
:: более дней, то архив name-w4.rar удаляется, и происходит переименование:
:: name-w3.rar в name-w4.rar
:: name-w2.rar в name-w3.rar
:: name-w1.rar в name-w2.rar
:: name-d7.rar в name-w1.rar
:: 
:: Удаляемый архив name-w4.rar таким-же образом участвует в ротации месячных 
:: архивов name-m01 .. name-m12, замещая первый. 
:: Разница в днях с name-m01 при этом должна быть больше либо равна 28 дням.
::
:: Руслан Охитин, ruslan.ohitin@gmail.com, осень 2009.
::


 set CPATH=%~dp0%.
:: set APATH=%~dp0%..
 set APATH=\\dom\backup
 set ANAME=%1
 set AEXT=rar
 set RAROPT=-r -rr -se -m5 -dh -os -ow -y -idp -ilog

 if "%ANAME%"=="" goto :EOF
 if not exist "%CPATH%\%ANAME%.inc" goto :EOF
 if not exist "%CPATH%\%ANAME%.xcl" goto :EOF

 rem Если есть файл d7, то его нужно удалить или переименовать в w1
 if exist "%APATH%\%ANAME%-d7.%AEXT%" (

	if %DEBUG%==1 echo Нашли d7 

	rem Файл w1 существует
	if exist "%APATH%\%ANAME%-w1.%AEXT%" (

		if %DEBUG%==1 echo Нашли w1

		rem файл d7 старше на 7 или более дней, нужно заменять

		call :datedif "%APATH%\%ANAME%-w1.%AEXT%" "%APATH%\%ANAME%-d7.%AEXT%" ddif

		if %DEBUG%==1 echo d7 старше w1 на !ddif! дней
    
	 	if !ddif! GEQ 7 (

			if %DEBUG%==1 echo разница больше или равна 7 дням, будем переименовывать
        
			rem Предварительно нужно сдвинуть на 1 шаг файлы w1 - w4
	 		
			rem Если существует w4, решаем, что с ним делать.
			if exist "%APATH%\%ANAME%-w4.%AEXT%" (
				
				if %DEBUG%==1 echo Нашли w4

				rem Если есть m01, нужно проверить, насколько w4 старше.
				if exist "%APATH%\%ANAME%-m01.%AEXT%" (

					if %DEBUG%==1 echo Нашли m01
				    
					call :datedif "%APATH%\%ANAME%-m01.%AEXT%" "%APATH%\%ANAME%-w4.%AEXT%" ddif

					if %DEBUG%==1 echo w4 старше m01 на !ddif! дней
					
					rem если w4 старше m01 на 28 и более дней, двигаем файлы m01-m12
					if !ddif! GEQ 28 (

						if %DEBUG%==1 echo разница больше либо равна 28 дням, удаляем m12 и сдвигаем остальные mXX

 						if exist "%APATH%\%ANAME%-m12.%AEXT%" del "%APATH%\%ANAME%-m12.%AEXT%" 

			 			if exist "%APATH%\%ANAME%-m11.%AEXT%" ren "%APATH%\%ANAME%-m11.%AEXT%" %ANAME%-m12.%AEXT% 
						if exist "%APATH%\%ANAME%-m10.%AEXT%" ren "%APATH%\%ANAME%-m10.%AEXT%" %ANAME%-m11.%AEXT% 
				 		if exist "%APATH%\%ANAME%-m09.%AEXT%" ren "%APATH%\%ANAME%-m09.%AEXT%" %ANAME%-m10.%AEXT% 
 						if exist "%APATH%\%ANAME%-m08.%AEXT%" ren "%APATH%\%ANAME%-m08.%AEXT%" %ANAME%-m09.%AEXT% 
			 			if exist "%APATH%\%ANAME%-m07.%AEXT%" ren "%APATH%\%ANAME%-m07.%AEXT%" %ANAME%-m08.%AEXT% 
				 		if exist "%APATH%\%ANAME%-m06.%AEXT%" ren "%APATH%\%ANAME%-m06.%AEXT%" %ANAME%-m07.%AEXT% 
			 			if exist "%APATH%\%ANAME%-m05.%AEXT%" ren "%APATH%\%ANAME%-m05.%AEXT%" %ANAME%-m06.%AEXT% 
			 			if exist "%APATH%\%ANAME%-m04.%AEXT%" ren "%APATH%\%ANAME%-m04.%AEXT%" %ANAME%-m05.%AEXT% 
				 		if exist "%APATH%\%ANAME%-m03.%AEXT%" ren "%APATH%\%ANAME%-m03.%AEXT%" %ANAME%-m04.%AEXT% 
			 			if exist "%APATH%\%ANAME%-m02.%AEXT%" ren "%APATH%\%ANAME%-m02.%AEXT%" %ANAME%-m03.%AEXT% 
			 			if exist "%APATH%\%ANAME%-m01.%AEXT%" ren "%APATH%\%ANAME%-m01.%AEXT%" %ANAME%-m02.%AEXT% 
	

						rem На освободившееся место помещаем w4 (w4 -> m01)
						if %DEBUG%==1 echo Переименовываем w4 в m01
						ren "%APATH%\%ANAME%-w4.%AEXT%" "%ANAME%-m01.%AEXT%"

					) else (

						rem w4 слишком молод, выкидываем.
						if %DEBUG%==1 echo w4 слишком молод, выкидываем.
						del "%APATH%\%ANAME%-w4.%AEXT%"
					)
										

				) else (
					rem m01 нет, смело переименовываем w4 в m01
					if %DEBUG%==1 echo m01 нет, смело переименовываем w4 в m01
					ren "%APATH%\%ANAME%-w4.%AEXT%" "%ANAME%-m01.%AEXT%"
				)
			)

			if %DEBUG%==1 echo сдвигаем файлы W
	 		if exist "%APATH%\%ANAME%-w3.%AEXT%" ren "%APATH%\%ANAME%-w3.%AEXT%" %ANAME%-w4.%AEXT% 
 			if exist "%APATH%\%ANAME%-w2.%AEXT%" ren "%APATH%\%ANAME%-w2.%AEXT%" %ANAME%-w3.%AEXT% 
 			if exist "%APATH%\%ANAME%-w1.%AEXT%" ren "%APATH%\%ANAME%-w1.%AEXT%" %ANAME%-w2.%AEXT% 
 	
			if %DEBUG%==1 echo Переименовываем d7 в w1
		 	ren "%APATH%\%ANAME%-d7.%AEXT%" "%ANAME%-w1.%AEXT%"

	 	) else (

 			rem d7 ещё слишком молод для w1, удаляем.
 			if %DEBUG%==1 echo d7 ещё слишком молод для w1, удаляем.
			del "%APATH%\%ANAME%-d7.%AEXT%" 

	 	)
	
	) else (

		rem w1 не существует, можно переименовать d7 в w1
		if %DEBUG%==1 echo w1 не существует, можно переименовать d7 в w1
	 	ren "%APATH%\%ANAME%-d7.%AEXT%" "%ANAME%-w1.%AEXT%"

	)

 )

 if %DEBUG%==1 echo сдвигаем файлы D
 if exist "%APATH%\%ANAME%-d6.%AEXT%" ren "%APATH%\%ANAME%-d6.%AEXT%" %ANAME%-d7.%AEXT% 
 if exist "%APATH%\%ANAME%-d5.%AEXT%" ren "%APATH%\%ANAME%-d5.%AEXT%" %ANAME%-d6.%AEXT% 
 if exist "%APATH%\%ANAME%-d4.%AEXT%" ren "%APATH%\%ANAME%-d4.%AEXT%" %ANAME%-d5.%AEXT% 
 if exist "%APATH%\%ANAME%-d3.%AEXT%" ren "%APATH%\%ANAME%-d3.%AEXT%" %ANAME%-d4.%AEXT% 
 if exist "%APATH%\%ANAME%-d2.%AEXT%" ren "%APATH%\%ANAME%-d2.%AEXT%" %ANAME%-d3.%AEXT% 
 if exist "%APATH%\%ANAME%-d1.%AEXT%" ren "%APATH%\%ANAME%-d1.%AEXT%" %ANAME%-d2.%AEXT% 
                                                           
 :: Get date and time in vars
:: for /f "tokens=1-4 delims=/-. " %%G in ('date /t') do (set ADATE=%%I-%%H-%%G)
:: for /f "tokens=1-4 delims=:" %%G in ('time /t') do (set ATIME=%%G:%%H)


 if %DEBUG%==1 echo Создаем файл d1

 "%CPATH%\rar.exe" a %RAROPT% -x@"%CPATH%\%ANAME%.xcl" "%APATH%\%ANAME%-d1.%AEXT%" @"%CPATH%\%ANAME%.inc"
 
 goto :EOF


:: Вычисление разницы в днях между датами создания файлов
:datedif %file1% %file2% result

 setlocal ENABLEEXTENSIONS

 set par=%~t1%
 
 set /a year=%par:~6,4%-1980
 set mon=%par:~3,2%
 if "%mon:~0,1%"=="0" set mon=%mon:~1,1%
 set day=%par:~0,2%
 if "%day:~0,1%"=="0" set day=%day:~1,1%
 set /a d1=%year% * 365 + %mon% * 30 + %day%
 
 set par=%~t2%
 
 set /a year=%par:~6,4%-1980
 set mon=%par:~3,2%
 if "%mon:~0,1%"=="0" set mon=%mon:~1,1%
 set day=%par:~0,2%
 if "%day:~0,1%"=="0" set day=%day:~1,1%
 set /a d2=%year% * 365 + %mon% * 30 + %day%

 set /A res=%d2%-%d1%

 endlocal&set %3=%res%&goto :EOF
