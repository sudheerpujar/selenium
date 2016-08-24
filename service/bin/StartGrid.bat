@echo off
setlocal

rem Copyright (c) 1999, 2006 Tanuki Software Inc.
rem
rem Java Service Wrapper general startup script
rem
if "%1"=="" goto enter_service_name
set _SERVICE_NAME=%1
goto :start

:enter_service_name
echo Enter Service Name as First Paramenter (e.g. StartGrid hub or StartGrid chrome or StartGrid firefox or StartGrid iexplorer)
goto :eof

:start
rem
rem Resolve the real path of the wrapper.exe
rem  For non NT systems, the _REALPATH and _WRAPPER_CONF values
rem  can be hard-coded below and the following test removed.
rem
if "%OS%"=="Windows_NT" goto nt
echo This script only works with NT-based versions of Windows.
goto :eof

:nt
rem
rem Find the application home.
rem
rem %~dp0 is location of current script under NT
set _REALPATH=%~dp0

rem Decide on the wrapper binary.
set _WRAPPER_BASE=wrapper
set _WRAPPER_EXE=%_REALPATH%%_WRAPPER_BASE%-windows-x86-32.exe
if exist "%_WRAPPER_EXE%" goto conf
set _WRAPPER_EXE=%_REALPATH%%_WRAPPER_BASE%-windows-x86-64.exe
if exist "%_WRAPPER_EXE%" goto conf
set _WRAPPER_EXE=%_REALPATH%%_WRAPPER_BASE%.exe
if exist "%_WRAPPER_EXE%" goto conf
echo Unable to locate a Wrapper executable using any of the following names:
echo %_REALPATH%%_WRAPPER_BASE%-windows-x86-32.exe
echo %_REALPATH%%_WRAPPER_BASE%-windows-x86-64.exe
echo %_REALPATH%%_WRAPPER_BASE%.exe
pause
goto :eof

rem
rem Find the wrapper.conf
rem
:conf
set _WRAPPER_CONF="%_REALPATH%..\%_SERVICE_NAME%\conf\wrapper.conf"

rem
rem Start the Wrapper
rem
:startup
"%_WRAPPER_EXE%" -c %_WRAPPER_CONF%
if not errorlevel 1 goto :eof
pause
