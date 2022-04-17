@echo off
echo Waiting to start the countdown timer. 
echo Do not exit this program.
echo.
rem find the day of the week
set message=Sunday
set thour= 9
for /f %%i in ('wmic path win32_localtime get dayofweek') do (
  if "%%i" == "0" (
    rem check to see if it is sunday
    if "%date:~0,5%" == "25/12" (call :starter "Christmas Day" & goto :eof) 
    call :starter "%message%"
    goto :eof
  )
)
rem test for Easter Friday or Christmas acceptable dates until the end of 2032
if "%date:~0,10%" == "15/04/2022" call :starter "Easter Friday"
if "%date:~0,10%" == "07/04/2023" call :starter "Easter Friday"
if "%date:~0,10%" == "29/03/2024" call :starter "Easter Friday"
if "%date:~0,10%" == "18/04/2025" call :starter "Easter Friday"
if "%date:~0,10%" == "03/04/2026" call :starter "Easter Friday"
if "%date:~0,10%" == "26/03/2027" call :starter "Easter Friday"
if "%date:~0,10%" == "14/04/2028" call :starter "Easter Friday"
if "%date:~0,10%" == "30/03/2029" call :starter "Easter Friday"
if "%date:~0,10%" == "19/04/2030" call :starter "Easter Friday"
if "%date:~0,10%" == "11/04/2031" call :starter "Easter Friday"
if "%date:~0,10%" == "26/03/2032" call :starter "Easter Friday"
if "%date:~0,5%" == "25/12" call :starter "Christmas Day"
rem The next line is for testing only. So normally should start with a "rem".
rem if "%date:~4,5%" == "%date:~4,5%" (echo test date found %date:~4,5% & goto :check1 )
)
echo No church service day/date found.
echo This program will exit!
timeout /t 5 /nobreak
goto :eof

:starter
echo It is %~1
if "%~1" == "Christmas Day" set thour= 8
if "%~1" == "Easter Friday" set thour= 8
goto :check1
goto :eof

:check1
rem check time every 5 minutes
echo %time:~0,5%
if "%time:~0,4%"=="%thour%:4" (
goto :check2
) 
timeout /t 300 /nobreak
GOTO :check1

:check2
rem check time every 60 seconds
echo %time:~0,8%
if "%time:~0,5%"=="%thour%:44" ( goto :check3)
timeout /t 60 /nobreak
GOTO :check2

:check3
rem check time every 2 seconds
if "%time:~0,5%"=="%thour%:45" ( 
start Time_limit.exe --config=C:\Users\Public\Documents\wrbc-timer.ini -e -s
call :report "Started timer!"
exit /b
) 
timeout /t 2 /nobreak
GOTO :check3

:report
echo %~1
timeout /t 5 /nobreak
goto :eof