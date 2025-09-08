# Pinger

## A set of programs to automatize ping data collection in Windows systems. It uses Batch scripting only, to ensure compatibility, without need to install any additional software or services.

###### Its ruimentary, but does the job. Just launch Pinger.bat and follow the instructions. You can choose:
- Ping Gateway only - continously
- Ping Gateway only - with summary every 4 pings
- Custom address pool continously
- Custom address pool with summary every 4 pings

There are helper programs:
- Pinger_parser.bat - does the pinging part (dont run standalone, it is called from Pinger.bat)
- prepareDataForExcel.bat - parse raw data into .csv
- trimFiles.bat - periodically prunes old files, to save on disk space. (CURRENTLY NOT AUTOMATED)
- AppendString.bat - Appends an user-defined string to every row of the file.
- externalAddress.bat - checks and displays WAN external address. 

Within config.cfg you can configure various variables. More info at the end of this readme. 

## Licences
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)  
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://choosealicense.com/licenses/gpl-3.0/)  
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](https://choosealicense.com/licenses/gpl-3.0/)  

I allow for distribution and editing of this repository in any way that may help you. No need for contributions or donations. If you find it and it is of any help to you, great :D
## Changelog
- V 1.0 - Initial commit
  - Scan connection for ping errors in prolonged time. Ping results are written to a file with timestamp
- V 1.1 - Experimental BETA
- V 1.2 - General debug
- V 1.3 - Final
  - Option to scan two addresses simoultainously, with separate files for each dump.
files now contain timestamps
- V 1.4 - Minor cleaning
- V 1.5 - Major release
  - Added PingDump_helper.bat. Main program will collect data and pass it to helper for processing. Each entry spawns separate minimised processes and results files
  - Now in separate repo
- V 1.6 - New features
  - Added timestamp to each ping result
  - Files and variables name adjustment
- V 1.7 - New features
  - Network configuration now outputs to separate files
- V 1.8 - New features
  - Added Date to each ping result
  - Added AppendString.bat. It can add user defined string to textfiles in AppendStringDATA folder
  - Cleaned txt output
- V 1.9 - New features
  - Added config.cfg file. Store and edit configurable variables
  - Added prepareDataForExcel program. It takes output from parser and prepares it for easy editing in spreadsheet software. It outputs a file, wich can be set from cfg file
  - Added trimFiles program. It prunes old files from  either final or working folders
  - Added externalAddress program. It checks and displays external WAN address of current network
  - Pinger_parser
    - Added external WAN address checker
    - Changed data flow structure. Now it outputs a temporary file, wich will be used and updated with each ping.
    - Minor cleanup
  - Pinger
    - Minor cleanup
  - Updated README.md
- V 1.91 - Minor cleanup of repository and README
<br/>
<br/>
<br/>
<br/>
<br/>

## How to use config.cfg

  **programVersion=** Program version

  **TimestampPrefixDelim=** Delimiter between date and time in filename

  **rawDir=** Name of raw files directory

  **finishedOutputFolder=** Name of Final output file directory (used by prepareDataForExcel)

  **tmpDir=** Name of Temporary files directory

  **rawFileSuffix=** Raw file extension (ex. .tmp, .txt)

  **tmpFileSuffix=** Temporary file extension (ex. .tmp, .txt)

  **finalFileSuffix=** Final file extension (ex. .tmp, .txt)

  **automaticFileTrimmingTimeout=** how old (in days) files are flagged for deletion

  **defaultTrimOption=** (final, tmp, both) In automatic mode, wich directories are flagged for pruning

  **PruneClearingMessageTimeout=** After pruning files a message is displayed, this sets its timeout value

  **pingTime=** (in seconds) how long to wait for every ping command repetition