@echo off
echo Waiting to start 9am countdown timer. 
echo Do not exit this program.
echo.
rem test for acceptable dates until the end of 2026
if "%date:~4,10" == "14/04/2022" (goto :check1)
if "%date:~4,10" == "07/04/2023" (goto :check1)
if "%date:~4,10" == "29/03/2024" (goto :check1)
if "%date:~4,10" == "18/04/2025" (goto :check1)
if "%date:~4,10" == "03/04/2026" (goto :check1)
if "%date:~4,5" == "25/12" (goto :check1)
echo It is not Easter or Christmas.
echo This program will exit!
timeout /t 5 /nobreak

goto :eof

:check1
rem check time every 5 minutes
echo %time:~0,5%
if "%time:~0,4%"=="08:4" (
goto :check2
) 
timeout /t 300 /nobreak
GOTO :check1

:check2
rem check time every 10 seconds
echo %time:~0,8%
if "%time:~0,5%"=="08:45" (
echo Starting timer!
start Time_limit.exe --config=C:\Users\Public\Documents\wrbc-timer.ini -e -s
exit /b
) 
timeout /t 10 /nobreak
GOTO :check2