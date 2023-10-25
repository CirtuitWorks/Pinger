@REM Author: Jakub Samojluk j.samojluk@jasam.eu
@REM V 1.5
@REM This program constantly pings a certain local IP address/
@REM /and dumps results into PingOutput.txt
@ECHO OFF
chcp 65001
cls

@REM Header
echo PingDump by CirtuitWorks Jakub Samojluk &echo. &echo.
echo.

@REM Variables
set "ip="
set numberOfInstances=1

for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do if not defined ip set ip=%%~a
echo Options:
echo Ping [1] Gateway continuously
echo Ping [2] Gateway with summary every 4 pings
echo Ping [3] Custom address pool continuously
echo Ping [4] Custom address pool with summary every 4 pings

choice /C 1234 /M Mode: 
echo. &echo. Chosen mode: %ERRORLEVEL% 
if %ERRORLEVEL% EQU 1 (echo Pinging %ip% &echo %ip%>PingDumpTmp.txt &start /min pingdump_helper.bat 0 &goto :DISCLAIMER)
if %ERRORLEVEL% EQU 2 (echo Pinging %ip% &echo %ip%>PingDumpTmp.txt &start /min pingdump_helper.bat 1 &goto :DISCLAIMER)
if %ERRORLEVEL% EQU 3 (set mode=0 &set /p numberOfInstances= Enter number of addresses to ping:)
if %ERRORLEVEL% EQU 4 (set mode=1 &set /p numberOfInstances= Enter number of addresses to ping:)
set instancesLeft=%numberOfInstances%
goto :ADDRESSPARSER

@REM Parse each entered address to file and pass right flag to Pinger.bat
:ADDRESSPARSER
setlocal enabledelayedexpansion
for /L %%x in (1, 1, %numberOfInstances%) do (
    echo|set /p= instance: %%x &echo|set /p= "/" &echo|set /p=%numberOfInstances%
    echo.
    set /p queriedAddress=Set IP:
    ECHO !queriedAddress! > PingDumpTmp.txt
    echo pinging:  %queriedAddress
    if %mode% EQU 0 (start /min pingdump_helper.bat 0)
    if %mode% EQU 1 (start /min pingdump_helper.bat 1)   
    )
goto :DISCLAIMER

:DISCLAIMER
echo This window will close if ANY KEY is pressed. Ping is running in CMD window(s) in the background. No additional action is required. If you wish to finish pinging, just close all CMD windows.
pause
exit