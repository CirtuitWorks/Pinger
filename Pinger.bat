@REM Author: Jakub Samojluk j.samojluk@jasam.eu
@REM This program constantly pings a certain local IP address/
@REM /and dumps results into textfile
@ECHO OFF
chcp 65001
cls 

@REM load config file
for /f "delims=" %%x in (config.cfg) do (set "%%x")

@REM Header
echo PingDump by CirtuitWorks Jakub Samojluk &echo.
echo Version: %programVersion%
echo Settings
echo _____________________________________________________________________________________________________
echo.

@REM Variables
set "ip="
for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do if not defined ip set ip=%%~a
goto :SETTINGS

:SETTINGS
echo |set /p="hostname: "&hostname

for /f "tokens=1* delims=: " %%A in (
    'nslookup myip.opendns.com. resolver1.opendns.com 2^>NUL^|find "Address:"'
) do set ExtIP=%%B
echo External IP is: %ExtIP%
echo.
echo Options:
echo [1] Ping Gateway continuously
echo [2] Ping Gateway with summary every 4 pings
echo [3] Ping Custom address pool continuously
echo [4] Ping Custom address pool with summary every 4 pings
echo [5] Settings
echo.
choice /C 12345 /M "Mode:" 
echo. &echo. Chosen mode: %ERRORLEVEL% 
if %ERRORLEVEL% EQU 1 (echo Pinging %ip% &echo %ip%>pingertmp.txt &start /min Pinger_parser.bat 0 &goto :DISCLAIMER)
if %ERRORLEVEL% EQU 2 (echo Pinging %ip% &echo %ip%>pingertmp.txt &start /min Pinger_parser.bat 1 &goto :DISCLAIMER)
if %ERRORLEVEL% EQU 3 (set mode=0 &set /p numberOfInstances= Enter number of addresses to ping:)
if %ERRORLEVEL% EQU 4 (set mode=1 &set /p numberOfInstances= Enter number of addresses to ping:)
if %ERRORLEVEL% EQU 5 (echo Settings not ready!!! && pause && goto SETTINGS)


set instancesLeft=%numberOfInstances%
goto :ADDRESSPARSER

@REM Parse each entered address to file and pass right flag to Pinger.bat
:ADDRESSPARSER
setlocal enabledelayedexpansion
for /L %%x in (1, 1, %numberOfInstances%) do (
    echo|set /p= instance: %%x &echo|set /p= "/" &echo|set /p=%numberOfInstances%
    echo.
    set /p queriedAddress=Set IP:
    ECHO !queriedAddress! >> pingertmp.txt
    echo pinging:  %queriedAddress%
    if %mode% EQU 0 (start /min Pinger_parser.bat 0)
    if %mode% EQU 1 (start /min Pinger_parser.bat 1)   
    )
goto :DISCLAIMER

:DISCLAIMER
echo This window will close if ANY KEY is pressed. Ping is running in CMD window(s) in the background. No additional action is required. If you wish to finish pinging, just close all CMD windows.
pause
exit
