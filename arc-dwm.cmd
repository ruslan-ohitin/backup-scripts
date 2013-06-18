@echo off

 set VERSION=2009-11-18

 setlocal enabledelayedexpansion

 set DEBUG=1

::
:: �������� ��娢��� ����� � ��⮬���᪮� ��२��������� ����� ��娢��.
::
:: ��易⥫�� ��ࠬ��� - ��� ����� ��娢�樨:
:: 		arc-dwn.cmd name
:: ������ ����⢮���� 䠩�� name.inc � name.xcl, ᮤ�ঠ騥 ��᪨ 䠩���,
:: ����砥��� � �᪫�砥��� �� ��娢�
:: ��娢 ᮧ������ � ������� rar.exe
::
:: �奬� ��२��������� ����� ��娢��.
:: ������騩 ��娢 name-d7.rar 㤠�����
:: ����� ���� �ந�室�� "ᤢ��" � ���樨 ����� 䠩���:
:: name-d6.rar ��२�����뢠���� � name-d7.rar � �.�.
:: ᮧ������ ⥪�騩 ��娢 � ������ name-d1.rar
::
:: �᫨ 㤠�塞� ��娢 name-d7.rar ���� ��娢� name-w1.rar �� 7 ��� 
:: ����� ����, � ��娢 name-w4.rar 㤠�����, � �ந�室�� ��२���������:
:: name-w3.rar � name-w4.rar
:: name-w2.rar � name-w3.rar
:: name-w1.rar � name-w2.rar
:: name-d7.rar � name-w1.rar
:: 
:: ����塞� ��娢 name-w4.rar ⠪��-�� ��ࠧ�� ������ � ��樨 ������� 
:: ��娢�� name-m01 .. name-m12, ������ ����. 
:: ������ � ���� � name-m01 �� �⮬ ������ ���� ����� ���� ࠢ�� 28 ���.
::
:: ��᫠� ��⨭, ruslan.ohitin@gmail.com, �ᥭ� 2009.
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

 rem �᫨ ���� 䠩� d7, � ��� �㦭� 㤠���� ��� ��२�������� � w1
 if exist "%APATH%\%ANAME%-d7.%AEXT%" (

	if %DEBUG%==1 echo ��諨 d7 

	rem ���� w1 �������
	if exist "%APATH%\%ANAME%-w1.%AEXT%" (

		if %DEBUG%==1 echo ��諨 w1

		rem 䠩� d7 ���� �� 7 ��� ����� ����, �㦭� ��������

		call :datedif "%APATH%\%ANAME%-w1.%AEXT%" "%APATH%\%ANAME%-d7.%AEXT%" ddif

		if %DEBUG%==1 echo d7 ���� w1 �� !ddif! ����
    
	 	if !ddif! GEQ 7 (

			if %DEBUG%==1 echo ࠧ��� ����� ��� ࠢ�� 7 ���, �㤥� ��२�����뢠��
        
			rem �।���⥫쭮 �㦭� ᤢ����� �� 1 蠣 䠩�� w1 - w4
	 		
			rem �᫨ ������� w4, �蠥�, �� � ��� ������.
			if exist "%APATH%\%ANAME%-w4.%AEXT%" (
				
				if %DEBUG%==1 echo ��諨 w4

				rem �᫨ ���� m01, �㦭� �஢����, ��᪮�쪮 w4 ����.
				if exist "%APATH%\%ANAME%-m01.%AEXT%" (

					if %DEBUG%==1 echo ��諨 m01
				    
					call :datedif "%APATH%\%ANAME%-m01.%AEXT%" "%APATH%\%ANAME%-w4.%AEXT%" ddif

					if %DEBUG%==1 echo w4 ���� m01 �� !ddif! ����
					
					rem �᫨ w4 ���� m01 �� 28 � ����� ����, ������� 䠩�� m01-m12
					if !ddif! GEQ 28 (

						if %DEBUG%==1 echo ࠧ��� ����� ���� ࠢ�� 28 ���, 㤠�塞 m12 � ᤢ����� ��⠫�� mXX

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
	

						rem �� �᢮�����襥�� ���� ����頥� w4 (w4 -> m01)
						if %DEBUG%==1 echo ��२�����뢠�� w4 � m01
						ren "%APATH%\%ANAME%-w4.%AEXT%" "%ANAME%-m01.%AEXT%"

					) else (

						rem w4 ᫨誮� �����, �모�뢠��.
						if %DEBUG%==1 echo w4 ᫨誮� �����, �모�뢠��.
						del "%APATH%\%ANAME%-w4.%AEXT%"
					)
										

				) else (
					rem m01 ���, ᬥ�� ��२�����뢠�� w4 � m01
					if %DEBUG%==1 echo m01 ���, ᬥ�� ��२�����뢠�� w4 � m01
					ren "%APATH%\%ANAME%-w4.%AEXT%" "%ANAME%-m01.%AEXT%"
				)
			)

			if %DEBUG%==1 echo ᤢ����� 䠩�� W
	 		if exist "%APATH%\%ANAME%-w3.%AEXT%" ren "%APATH%\%ANAME%-w3.%AEXT%" %ANAME%-w4.%AEXT% 
 			if exist "%APATH%\%ANAME%-w2.%AEXT%" ren "%APATH%\%ANAME%-w2.%AEXT%" %ANAME%-w3.%AEXT% 
 			if exist "%APATH%\%ANAME%-w1.%AEXT%" ren "%APATH%\%ANAME%-w1.%AEXT%" %ANAME%-w2.%AEXT% 
 	
			if %DEBUG%==1 echo ��२�����뢠�� d7 � w1
		 	ren "%APATH%\%ANAME%-d7.%AEXT%" "%ANAME%-w1.%AEXT%"

	 	) else (

 			rem d7 ��� ᫨誮� ����� ��� w1, 㤠�塞.
 			if %DEBUG%==1 echo d7 ��� ᫨誮� ����� ��� w1, 㤠�塞.
			del "%APATH%\%ANAME%-d7.%AEXT%" 

	 	)
	
	) else (

		rem w1 �� �������, ����� ��२�������� d7 � w1
		if %DEBUG%==1 echo w1 �� �������, ����� ��२�������� d7 � w1
	 	ren "%APATH%\%ANAME%-d7.%AEXT%" "%ANAME%-w1.%AEXT%"

	)

 )

 if %DEBUG%==1 echo ᤢ����� 䠩�� D
 if exist "%APATH%\%ANAME%-d6.%AEXT%" ren "%APATH%\%ANAME%-d6.%AEXT%" %ANAME%-d7.%AEXT% 
 if exist "%APATH%\%ANAME%-d5.%AEXT%" ren "%APATH%\%ANAME%-d5.%AEXT%" %ANAME%-d6.%AEXT% 
 if exist "%APATH%\%ANAME%-d4.%AEXT%" ren "%APATH%\%ANAME%-d4.%AEXT%" %ANAME%-d5.%AEXT% 
 if exist "%APATH%\%ANAME%-d3.%AEXT%" ren "%APATH%\%ANAME%-d3.%AEXT%" %ANAME%-d4.%AEXT% 
 if exist "%APATH%\%ANAME%-d2.%AEXT%" ren "%APATH%\%ANAME%-d2.%AEXT%" %ANAME%-d3.%AEXT% 
 if exist "%APATH%\%ANAME%-d1.%AEXT%" ren "%APATH%\%ANAME%-d1.%AEXT%" %ANAME%-d2.%AEXT% 
                                                           
 :: Get date and time in vars
:: for /f "tokens=1-4 delims=/-. " %%G in ('date /t') do (set ADATE=%%I-%%H-%%G)
:: for /f "tokens=1-4 delims=:" %%G in ('time /t') do (set ATIME=%%G:%%H)


 if %DEBUG%==1 echo ������� 䠩� d1

 "%CPATH%\rar.exe" a %RAROPT% -x@"%CPATH%\%ANAME%.xcl" "%APATH%\%ANAME%-d1.%AEXT%" @"%CPATH%\%ANAME%.inc"
 
 goto :EOF


:: ���᫥��� ࠧ���� � ���� ����� ��⠬� ᮧ����� 䠩���
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
