# THIS PROJECT IS OUTDATED. USE 2.0 INSTEAD

# Changelog

## [2.1.0] - 2022-10-11

### Fixed
- Fixed breaking change with search changing to slash commands


## [2.0.2] - 2022-08-21

### Added
- Added launcher

### Changed
- (not) good to check message can no longer be error
- Checking if good to check message contains right variables
- Autospiker will now go through first time setup if INI does not contain valid variable

### Removed
- Self compiler

## [2.0.1] - 2022-08-19

### Changed

- Bug fix in autospiker script
- Bug fix in staffcheck script

## [2.0.0] - 2022-08-19

### Added

- Autospiker
- Added Auto Port Spiker
- Enter multiple Requiem entries at once in add to ban list
- Added confirm option to post ban to AoA for ashen bans
- Added stephmode to add to ban list.ahk (who knows what it does)
- Added add notes.ahk. Replaces the old script with more and better functionality
- Added add warnings.ahk. Replaces the old script with more and better functionality
- Added check for updates button in staffchecking script

### Changed

- Completely overhauled staffchecking script. it should be a few seconds faster now.
- Fixed save your changes to this site error
- Fixed Steph's weird bug where it would send separate messages for good to check in on-duty-chat by formatting good to check message beforehand and pasting it instead of typing it out
- Now actually using functions in the staffcheck script
- Customize good to check message is now embedded in the staffchecking script (you will have to remake your messages. but trust me, its easier)
- Fixed issue in add to ban list where requiem ban userIDs would sometimes swap with the discord name

### Removed
- Customize good to check.ahk (obsolete)
- Mass add notes.ahk
- Mass add notes dont check captains.ahk
- Mass add warnings.ahk
- enter5min.ahk
- rule 5 warning.ahk

## [1.10.0] - 2022-07-27


### Added

- Added a macro to turn IDs into mentions

### Changed

- Added support for discord's new 19 char snowflakes
- GREATLY increased the speed of the staffcheck macro by making use of elementals new loghistory report and removing some obsolete code
- Fixed an issue where it lost its mind and banned someone (rip rustygamer)

## [1.9.3] - 2022-07-07


### Changed

- Fixed an issue where the reason for a ban would go into column F instead of column E

## [1.9.2] - 2022-07-04


### Changed

- Fixed where windows would look for logclass.ahk in a different directory

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
- Added GUI to staffchecking script so you can separate the entire process if you want to
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

### Removed
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
