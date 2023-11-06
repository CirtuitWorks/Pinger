# Pinger
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