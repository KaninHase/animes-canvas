@echo off

SET CHROMEDIR=%SYSTEMDRIVE%\Progra~2\Google\Chrome\Application
REM Note salted folder name
SET EDGEDIR_TRIDENT=%WINDIR%\SystemApps\Microsoft.MicrosoftEdge_*\MicrosoftEdge.exe
REM i.e., Chromium-derived
SET EDGEDIR_ANAHEIM=%SYSTEMDRIVE%\Progra~2\Microsoft\Edge\Application
IF EXIST %CHROMEDIR%\nul GOTO chrome
IF EXIST %EDGEDIR_ANAHEIM%\nul GOTO anaheim

ECHO Cannot find an installation of Google Chrome or latest Microsoft Edge (79+).
ECHO These are required to view a Mental Canvas scene locally, without uploading to
ECHO the web.
PAUSE
GOTO end

:chrome
SET BINDIR=%CHROMEDIR%
SET BIN=chrome.exe
REM Purpose of user-data-dir: launch a new instance of chrome, don't just add a tab to an
REM existing instance
SET FLAGS=--allow-file-access-from-files --user-data-dir=%TEMP%\chrome-file
GOTO run

:anaheim
SET BINDIR=%EDGEDIR_ANAHEIM%
SET BIN=msedge.exe
SET FLAGS=--allow-file-access-from-files --user-data-dir=%TEMP%\chrome-file
GOTO run

:run
REM Note that - because we rewrite paths via the BASE html tag - we have to provide an
REM absolute path to the scene
%BINDIR%\%BIN% %FLAGS% "file:///%CD%/index.html?path=%CD%"

:end
