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
echo Results for custom address

@REM Variables
set /p argumentAddress=<PingDumpTmp.txt
del PingDumpTmp.txt
set argumentFlag=%1

echo|set /p= "Passed argument - Address: " &echo %argumentAddress%
if %argumentFlag% EQU 0 (echo Passed argument - Mode: Continous)
if %argumentFlag% EQU 1 (echo Passed argument - Mode: Fragmented)
set fileName=%argumentAddress%
fsutil file createnew "%filename%.txt" 100

echo =======================================================>> "%filename%.txt"
echo =                                                     =>> "%filename%.txt"
echo =                   PING TEST v1.5                    =>> "%filename%.txt"
echo =                                                     =>> "%filename%.txt"
echo =               @:j.samojluk@jasam.eu                 =>> "%filename%.txt"
echo =                                                     =>> "%filename%.txt"
echo =======================================================>> "%filename%.txt"
echo|set /p= "Date: ">> "%filename%.txt" &echo %date% >> "%filename%.txt"
echo|set /p= "Hostname: ">> "%filename%.txt" &echo %COMPUTERNAME%>> "%filename%.txt"
ipconfig /all >> "%filename%.txt"
if %argumentFlag% EQU 0 (goto :CONTINOUS)
if %argumentFlag% EQU 1 (goto :FRAGMENTED)

:CONTINOUS
echo. &echo.
echo|set /p= pinging: %argumentAddress%
ping -t %argumentAddress% >> "%filename%.txt"

:FRAGMENTED
ping -n 4 %argumentAddress% >> "%filename%.txt"
goto :FRAGMENTED
exit