# Changelog

## [1.9.1] - 2022-07-04

### Changed

- Fixed a crash when pressing no in a message box

## [1.9.0] - 2022-07-04

### Added

- Added extra channel switch to on-duty-commands after doing elemental commands just in case
- Select channel to do commands in (default = on-duty-commands)
- Added a check for userid length
- Added an option to check userID and Gamertag before doing the macro to see if the user has been checked before
- Added logs to staffcheck script


## [1.8.1] - 2022-06-25

### Changed
- Fixed XLR's OCD problem


## [1.8.0] - 2022-06-24

### Added
- Added GUI to staffchecking script so you can seperate the entire process if you want to
- Added how to use for staffchecking script
- Added how to use for add to ban list
- Added GUI for add to ban list script

### Removed
- Removed good to check.ahk because it is embedded in staffcheck.ahk now


## [1.7.1] - 2022-06-22

### Changed
- Hopefully fixed the issues steph is having for the last time
- add aoa bans script fixed so it should actually work (more often)
- good to check message box in staffcheck script now has a cancel option

## [1.7.0] - 2022-06-20

### Added
- Rule 5 warning macro
- add AoA bans macro

### Changed
- Changed mass add warnings/notes to patch it sometimes opening snipping tool!?
- Fixed add notes/warnings not adding special characters like # to reasons
- Fixed some grammar errors
- Changed warning message to be more detailed


## [1.6.0] - 2022-06-18

### Changed
- Changed file structure again


## [1.5.1] - 2022-06-17

### Added
- Added extra warnings in staffcheck.exe
- Added script compiling tutorial

### Changed
- Changed Mass add warnings to work with .csv file format
- Changed Mass add notes to work with .csv file format
- Changed change channel delay from 8 sec > 2 sec


## [1.5.0] - 2022-06-17

### Added
- Added check for if staffcheck.ini doesn't exist
- Added support for multiple pages of notes
- Added readme
- Added Mass add warnings

### Changed
- Delay fine tuning
- Fixed mass add notes to point to correct channel

## Removed
- readme.txt


## [1.4.1] - 2022-06-17

### Added
- Changelog added
- Customization for good to check messages
- Customization.exe
- staffcheck.ini

### Changed
- Changed delays between switching channels 10sec > 8sec
- Changed delays in between commands to allow for discord to catch up

### Removed
- Gitignore file removed
