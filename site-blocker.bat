@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Site-Blocker
echo -----------------
echo 1. List all blocked sites
echo 2. Add a site to block
echo 3. Remove a blocked site
echo 4. Backup hosts file (Highly Recommended)
echo 5. Restore hosts file
echo 6. Exit
echo -----------------
set /p choice=Enter your choice (1/2/3/4/5/6): 

if "%choice%"=="" goto menu
if "%choice%"=="1" goto list_all
if "%choice%"=="2" goto add_site
if "%choice%"=="3" goto remove_site
if "%choice%"=="4" goto backup_file
if "%choice%"=="5" goto restore_ogfile
if "%choice%"=="6" goto end

goto menu

:list_all
cls
echo.
echo List of blocked sites in the hosts file:
type C:\Windows\System32\drivers\etc\hosts | findstr /i "127.0.0.1"
pause 
goto menu

:add_site
cls
echo.
set /p site=Enter the site to block (e.g: sitename.com without www):
echo 127.0.0.1    %site% >> C:\Windows\System32\drivers\etc\hosts
echo Site '%site%' added to the blocklist successfully.
pause
goto menu

:remove_site
cls
echo.
set /p site=Enter the site to unblock (e.g., www.sitename.com):
type C:\Windows\System32\drivers\etc\hosts | findstr /i /v "%site%" > tempfile.txt
copy /Y tempfile.txt C:\Windows\System32\drivers\etc\hosts
del tempfile.txt
echo Site '%site%' removed from the blocklist successfully.
pause
goto menu

:backup_file
cls
echo.
echo Creating a backup of the hosts file...
xcopy /Y C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts_backup
echo Hosts file backed up successfully.
pause
goto menu

:restore_ogfile
cls
echo.
echo Restoring hosts file from backup...
copy /Y C:\Windows\System32\drivers\etc\hosts_backup C:\Windows\System32\drivers\etc\hosts
echo Hosts file restored successfully.
pause
goto menu

:end
exit