@echo off
echo Waiting to start 10am countdown timer. 
echo Do not exit this program.
echo.

for /f %%i in ('wmic path win32_localtime get dayofweek') do call :checkday %%i

rem check to see if it is sunday
echo It is not Sunday. 
call :report "This program will exit."
exit /b


:checkday
if "%~1" == "0" (
echo It is Sunday
goto :check1
)
goto :eof

:check1
rem check time every 5 minutes
echo %time:~0,5%
if "%time:~0,4%"==" 9:4" (
goto :check2
) 
timeout /t 300 /nobreak
GOTO :check1

:check2
rem check time every 10 seconds
echo %time:~0,8%
if "%time:~0,5%"==" 9:45" (
start Time_limit.exe --config=C:\Users\Public\Documents\wrbc-timer.ini -e -s
call :report "Started timer!"
exit /b
) 
timeout /t 10 /nobreak
GOTO :check2

:report
echo %~1
timeout /t 5 /nobreak
goto :eof