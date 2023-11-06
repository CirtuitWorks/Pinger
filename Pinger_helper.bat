@REM Author: Jakub Samojluk j.samojluk@jasam.eu
@REM V 1.8
@REM This program constantly pings a certain local IP address/
@REM /and dumps results into textfile
@ECHO OFF
chcp 65001
cls 

@REM Header
echo PingDump by CirtuitWorks Jakub Samojluk &echo.
echo Pinger module
echo _____________________________________________________________________________________________________
echo.

@REM Variables
set /p argumentAddress=<pingertmp.txt
del pingertmp.txt
echo %argumentAddress%
set argumentFlag=%1
@REM Main
echo|set /p= "Passed argument - Address: " &echo %argumentAddress%
if %argumentFlag% EQU 0 (echo Passed argument - Mode: Continous)
if %argumentFlag% EQU 1 (echo Passed argument - Mode: Fragmented)
mkdir TXT
set fileName=%argumentAddress%
set filePathTXT=TXT\%filename%.txt
set filePathINFO=Info.txt
set "filePathTXT=%filePathTXT: =%"
if not exist "%filePathINFO%" (
fsutil file createnew  "%filePathINFO%" 100
echo =======================================================>>  "%filePathINFO%"
echo =                                                     =>>  "%filePathINFO%"
echo =                   PINGER v 1.7                      =>>  "%filePathINFO%"
echo =                                                     =>>  "%filePathINFO%"
echo =               @:j.samojluk@jasam.eu                 =>>  "%filePathINFO%"
echo =                                                     =>>  "%filePathINFO%"
echo =======================================================>>  "%filePathINFO%"
echo|set /p= "Date: ">>  "%filePathINFO%" &echo %date% >>  "%filePathINFO%"
echo|set /p= "Hostname: ">>  "%filePathINFO%" &echo %COMPUTERNAME%>>  "%filePathINFO%"
ipconfig /all >>  "%filePathINFO%"
echo|set /p= "Start date: " >>  "%filePathINFO%" &echo %DATE% >>  "%filePathINFO%"
)
if %argumentFlag% EQU 0 (goto :CONTINOUS)
if %argumentFlag% EQU 1 (goto :FRAGMENTED)
:CONTINOUS
ping -t %argumentAddress%|cmd /q /v /c "(pause&pause)>nul & for /l %%a in () do (set /p "data=" && echo(!date! !time! !data!)&ping -n 2 localhost>nul" >>  "%filePathTXT%"

:FRAGMENTED
ping -n 4 %argumentAddress%|cmd /q /v /c "(pause&pause)>nul & for /l %%a in () do (set /p "data=" && echo(!date! !time! !data!)&ping -n 2 localhost>nul" >>  "%filePathTXT%"
goto :FRAGMENTED
exit