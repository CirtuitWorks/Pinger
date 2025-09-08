@REM Author: Jakub Samojluk j.samojluk@jasam.eu
@REM V 1.9
@REM This program trims old files
@ECHO OFF
chcp 65001
cls 

@REM load config file and environment
for /f "delims=" %%x in (TOOLS\config.cfg) do (set "%%x")
set varFinal=final
set varTMP=tmp
set varBoth=both

:header
cls
echo PingDump by CirtuitWorks Jakub Samojluk &echo.
echo File trimmer
echo Version: %programVersion%
echo Data processing module
echo _____________________________________________________________________________________________________
echo.
echo  "Passed argument - Trim files older than (days): %trimOlderThan%"
echo.
echo.
@REM pause

@REM set trimOlderThan=0
set trimOlderThan=%1
if "%~1"=="" goto :setArgument
goto :defaults


:options
@REM call :header @REM BAD RECURSION
echo Options:
echo [1] Clear FINAL
echo [2] Clear RAW
echo [3] Clear ALL
echo [4] Set number of days
echo [5] DEFAULTS
echo.
choice /C 12345 /M "Mode:" 
echo. &echo. Chosen mode: %ERRORLEVEL% 
if %ERRORLEVEL% EQU 1 (echo clearing FINAL &goto :clearFinal)
if %ERRORLEVEL% EQU 2 (echo Clearing TMP &goto :clearRAW)
if %ERRORLEVEL% EQU 3 (echo Clear &goto :clearALL)
if %ERRORLEVEL% EQU 4 (echo Enter no. of days &goto :setArgument)
if %ERRORLEVEL% EQU 5 (echo DEAFULTS &goto :defaults)

:clearFinal
@REM call :header
echo PRUNING FINAL FOLDER!
echo. && echo FINAL:
forfiles /p %finishedOutputFolder% /s /m *.* /D -%trimOlderThan% /C "cmd /c del @path"
echo All done!
timeout -T %PruneClearingMessageTimeout%
exit

:clearRAW
@REM call :header
echo PRUNING TMP FOLDER!
echo. && echo RAW:
forfiles /p %rawDir% /s /m *.* /D -%trimOlderThan% /C "cmd /c del @path"
echo All done!
timeout -T %PruneClearingMessageTimeout%
exit

:clearALL
@REM call :header
echo PRUNING BOTH FINAL AND WORKING FOLDERS!
echo. && echo RAW:
forfiles /p %rawDir% /s /m *.* /D -%trimOlderThan% /C "cmd /c del @path"
echo. && echo FINAL:
forfiles /p %finishedOutputFolder% /s /m *.* /D -%trimOlderThan% /C "cmd /c del @path"
echo All done!
timeout -T %PruneClearingMessageTimeout%
exit

:setArgument
@REM call :header
echo You need to specify wich files to delete. Enter number of days, wich will indicate wich files to trim
set /p trimOlderThan=delete files older than (days):
goto :options

:defaults
echo Selected option: Defaults
echo Selected prune mode: %defaultTrimOption%
if %trimOlderThan% =="" goto :setArgument
echo %defaultTrimOption%
if "%defaultTrimOption%"=="%varFinal%" (
    goto :clearFinal
) else if "%defaultTrimOption%"=="%varTMP%" (
    goto :clearTMP
) else if "%defaultTrimOption%"=="%varBoth%" (
    goto :clearBoth
)
