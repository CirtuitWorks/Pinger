@REM Author: Jakub Samojluk j.samojluk@jasam.eu
@REM V 1.9
@REM This program appends an user defined string with comma and space to the beginning of every row
@ECHO OFF
chcp 65001
cls 

@REM Header
echo PingDump by CirtuitWorks Jakub Samojluk &echo.
echo AppendString module. &echo.
echo Version: %programVersion%
echo Define a string. This string + comma + space will be added at the beggining of every row of .TXT file
echo _____________________________________________________________________________________________________
echo.

@REM Main
setlocal enabledelayedexpansion
set "inputDirectory=%~dp0AppendStringDATA"
set "outputDirectory=!inputDirectory!\OUTPUT"

@REM Input directory check
if not exist "%inputDirectory%" (
    mkdir "%inputDirectory%"
    echo Created folder: "%inputDirectory%"
    echo. &echo.
)

@REM Output directory check
if not exist "%outputDirectory%" (
    mkdir "%outputDirectory%"
    echo Created folder: "%outputDirectory%" for output files!
    echo. &echo.

)

set /p selected_text="Enter the text string to append: "
echo "Appending requested string. This may take some time!"
for %%F in ("%inputDirectory%\*.txt") do (
    set "outputFile=!outputDirectory!\%%~nF_modified.txt"
    (
        for /f "tokens=* delims=" %%L in (%%F) do (
            echo !selected_text!, %%L
        )
    ) > "!outputFile!"
)

echo. &echo.
echo Text string, a comma, and a space have been appended to all files! Results are located in AppendStringDATA\OUTPUT
pause
