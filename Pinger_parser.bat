@REM Author: Jakub Samojluk j.samojluk@jasam.eu
@REM This program constantly pings a certain local IP address/
@REM /and dumps results into textfile
@ECHO OFF
chcp 65001
cls 

@REM load config file
for /f "delims=" %%x in (TOOLS\config.cfg) do (set "%%x")

@REM Header
echo PingDump by CirtuitWorks Jakub Samojluk &echo.
echo Pinger module
echo _____________________________________________________________________________________________________
echo.

@REM Variables
@REM ============================================================

@REM Get data from temporary file and delete it for further iterations to use
set /p argumentAddress=<pingertmp.txt
del pingertmp.txt

echo %argumentAddress%
set argumentFlag=%1
@REM ============================================================

@REM Main
echo|set /p= "Passed argument - Address: " &echo %argumentAddress%
if %argumentFlag% EQU 0 (echo Passed argument - Mode: Continous)
if %argumentFlag% EQU 1 (echo Passed argument - Mode: Fragmented)
echo. && echo.
echo. Working!
if not exist %rawDir% (mkdir %rawDir%)

@REM Info file
set filePathINFO=Info.txt
if not exist "%filePathINFO%" (
fsutil file createnew  "%filePathINFO%" 100
echo =======================================================>>  "%filePathINFO%"
echo =                                                     =>>  "%filePathINFO%"
echo =                   PINGER v 1.9                      =>>  "%filePathINFO%"
echo =                                                     =>>  "%filePathINFO%"
echo =               @:j.samojluk@jasam.eu                 =>>  "%filePathINFO%"
echo =                                                     =>>  "%filePathINFO%"
echo =======================================================>>  "%filePathINFO%"
echo|set /p= "Date: ">>  "%filePathINFO%" &echo %date% >>  "%filePathINFO%"
echo|set /p= "Hostname: ">>  "%filePathINFO%" &echo %COMPUTERNAME%>>  "%filePathINFO%"
ipconfig /all >>  "%filePathINFO%"
echo|set /p= "Start date: " >>  "%filePathINFO%" &echo %DATE% >>  "%filePathINFO%"
)

:CreateNewFile
set fileName=%argumentAddress%
set filePathTXT=%rawDir%\%DATE%%TimestampPrefixDelim%%fileName%%rawFileSuffix%
set "filePathTXT=%filePathTXT: =%"
if not exist %tmpDir%\ mkdir %tmpDir% && echo Creating directory for temporary files

setlocal enableextensions
setlocal enabledelayedexpansion

if %argumentFlag% EQU 0 (goto :CONTINOUS)
if %argumentFlag% EQU 1 (goto :FRAGMENTED)


:CONTINOUS
call :externalIPCheck

ping -n 1 %argumentAddress% > "%tmpDir%\%argumentAddress%%tmpFileSuffix%""

set /a "line - 0"
for /f "usebackq delims=" %%a in ("%tmpDir%\%argumentAddress%%tmpFileSuffix%") do (
    set /a "line = line +1"
    if !line!==2 set pingData=%%a
)

set pingData=%pingData%
echo %pingData%
echo %ExtIP%;%date%;%time%;%pingData% >> "%filePathTXT%"
    timeout /NOBREAK /T %pingTime% > NUL
goto :CONTINOUS

:FRAGMENTED
ping -n 4 %argumentAddress%|cmd /q /v /c "(pause&pause)>nul & for /l %%a in () do (set /p "data=" && echo(!date! !time! !data!)& ping -n 2 localhost>nul" >>  "%filePathTXT%"
goto :FRAGMENTED
exit


:externalIPCheck
for /f "tokens=1* delims=: " %%A in ('nslookup myip.opendns.com. resolver1.opendns.com 2^>NUL^|find "Address:"'
) do set ExtIP=%%B