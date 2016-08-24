@echo off
setlocal

rem Copyright (c) 1999, 2006 Tanuki Software Inc.
rem
rem Java Service Wrapper general NT service stop script
rem
if "%1"=="" goto enter_service_name
set _SERVICE_NAME=%1
goto :start

:enter_service_name
echo Enter Service Name as First Paramenter (e.g. StopNTService hub or StopNTService chrome or StopNTService firefox or StopNTService iexplorer)
goto :eof

:start
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
rem Stop the Wrapper NT service.
rem
:startup
"%_WRAPPER_EXE%" -p %_WRAPPER_CONF%
if not errorlevel 1 goto :eof
pause
