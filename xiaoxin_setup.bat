@echo off

REM ================================
REM Xiaoxin Pad 2024 Quick Setup
REM Android 14 / ZUI 16
REM ================================

echo *******************************************
echo * 1) Ensure your tablet is in Developer Mode
echo * 2) USB Debugging is enabled
echo * 3) Connect via USB
echo * 4) ADB installed on PC
echo *******************************************
pause

REM Step 0: Check ADB connection
echo [STEP 0] Checking ADB devices...
adb devices
echo -------------------------------------------
echo If more than one device is listed, use -s <serial> or remove extra devices.
pause

REM Step 1: APK Installation - Alternative Method
echo [STEP 1] APK Installation Options:

echo 1. Manual APK installation (recommended)
echo 2. Try direct download from Google Drive (may fail)
choice /C 12 /M "Select option"

if errorlevel 2 goto TryDownload
if errorlevel 1 goto ManualInstall

:TryDownload
echo [OPTION 2] Attempting to download APKs via PowerShell...

set PLAYSTORE_URL=https://docs.google.com/uc?export=download&id=1Wqrf8qK_1Rg5uRU9MKOPbUxsaN5Wc7yH
set SETEDIT_URL=https://docs.google.com/uc?export=download&id=112hxb1h8KAdR1DdAExtyGdS2pMnVgE0e
set PLAYSERVICES_URL=https://docs.google.com/uc?export=download&id=1OV6x9WFw1sje9w2vtWM1JLEoSq8Fgl4S
set GBOARD_URL=https://docs.google.com/uc?export=download&id=1n6CrGQL0zCsWOyKgbJVy3iZyhQQrrDmQ

REM Create a temp directory for downloads
mkdir temp_apks 2>nul
cd temp_apks

REM Download them with better error handling:
echo Downloading PlayStore.apk...
powershell -Command "try { Invoke-WebRequest -Uri '%PLAYSTORE_URL%' -OutFile 'PlayStore.apk' } catch { Write-Output 'Download failed!' }"

echo Downloading SetEdit.apk...
powershell -Command "try { Invoke-WebRequest -Uri '%SETEDIT_URL%' -OutFile 'SetEdit.apk' } catch { Write-Output 'Download failed!' }"

echo Downloading PlayServices.apk...
powershell -Command "try { Invoke-WebRequest -Uri '%PLAYSERVICES_URL%' -OutFile 'PlayServices.apk' } catch { Write-Output 'Download failed!' }"

echo Downloading Gboard.apk...
powershell -Command "try { Invoke-WebRequest -Uri '%GBOARD_URL%' -OutFile 'Gboard.apk' } catch { Write-Output 'Download failed!' }"

echo --------------------------------------------------
echo Checking downloaded APK files...
powershell -Command "Get-ChildItem -Filter *.apk | ForEach-Object { Write-Output ($_.Name + ' - ' + [math]::Round($_.Length/1KB, 2) + ' KB') }"

echo --------------------------------------------------
echo IMPORTANT: Google Drive often blocks complete APK downloads.
echo If files are small (under 100KB) or HTML files, use manual installation.
choice /C YN /M "Continue with installation anyway"
if errorlevel 2 goto ManualInstall
goto InstallAPKs

:ManualInstall
echo [OPTION 1] Manual APK Installation
echo --------------------------------------------------
echo Please download these APKs manually and place them in a folder:
echo - Google Play Store
echo - Google Play Services
echo - SetEdit
echo - Gboard
echo --------------------------------------------------
echo Enter the full path to the folder containing your APKs:
set /p APK_FOLDER=

cd /d "%APK_FOLDER%"
if %errorlevel% neq 0 (
    echo Invalid folder path! Please try again.
    goto ManualInstall
)

:InstallAPKs
echo [STEP 2] Installing APKs...
for %%f in (*.apk) do (
    echo Installing %%f...
    adb install "%%f"
    if %errorlevel% neq 0 (
        echo WARNING: Failed to install %%f
    ) else (
        echo Successfully installed %%f
    )
)

cd /d "%~dp0"

echo -------------------------------------------
echo APK installation completed.
pause

REM Step 3: Bloatware disable
echo [STEP 3] Disabling Chinese bloatware packages...
adb shell pm disable-user --user 0 com.sina.weibo
adb shell pm disable-user --user 0 com.tencent.qqmusic
adb shell pm disable-user --user 0 cn.wps.moffice_eng
adb shell pm disable-user --user 0 com.lenovo.club.app
adb shell pm disable-user --user 0 com.lenovo.browser.hd
adb shell pm disable-user --user 0 com.lenovo.leos.appstore
adb shell pm disable-user --user 0 com.lenovo.weathercenter
adb shell pm disable-user --user 0 com.zui.weather
adb shell pm disable-user --user 0 com.baidu.map.location
adb shell pm disable-user --user 0 com.lenovo.dsa
adb shell pm disable-user --user 0 com.lmsa.app.lmsapad
adb shell pm disable-user --user 0 com.lenovo.lfh.tianjiao.tablet
adb shell pm disable-user --user 0 com.tbsmart.levision
adb shell pm disable-user --user 0 com.tblenovo.center
adb shell pm disable-user --user 0 com.tblenovo.tabpushout

echo --------------------------------------------------
echo Disabled packages. Reboot and test for a few days.
pause

REM Step 4: Uninstall if no issues
echo [STEP 4] If stable, uninstall them. Press Enter to proceed.
pause

adb shell pm uninstall --user 0 com.sina.weibo
adb shell pm uninstall --user 0 com.tencent.qqmusic
adb shell pm uninstall --user 0 cn.wps.moffice_eng
adb shell pm uninstall --user 0 com.lenovo.club.app
adb shell pm uninstall --user 0 com.lenovo.browser.hd
adb shell pm uninstall --user 0 com.lenovo.leos.appstore
adb shell pm uninstall --user 0 com.lenovo.weathercenter
adb shell pm uninstall --user 0 com.zui.weather
adb shell pm uninstall --user 0 com.baidu.map.location
adb shell pm uninstall --user 0 com.lenovo.dsa
adb shell pm uninstall --user 0 com.lmsa.app.lmsapad
adb shell pm uninstall --user 0 com.lenovo.lfh.tianjiao.tablet
adb shell pm uninstall --user 0 com.tbsmart.levision
adb shell pm uninstall --user 0 com.tblenovo.center
adb shell pm uninstall --user 0 com.tblenovo.tabpushout

echo --------------------------------------------------
echo Uninstall done. Reboot your tablet and verify.
echo --------------------------------------------------
pause

REM Step 5: Grant SetEdit permission and set system language to ko-KR
echo [STEP 5] Setting up Korean locale and default Gboard...

REM 5.1) Check if SetEdit is installed
adb shell pm list packages | findstr "by4a.setedit22"
if %errorlevel% neq 0 (
    echo WARNING: SetEdit not found! Please install it first.
    pause
) else (
    REM 5.2) Grant SetEdit permission for WRITE_SECURE_SETTINGS
    adb shell pm grant by4a.setedit22 android.permission.WRITE_SECURE_SETTINGS
    echo SetEdit permissions granted.
)

REM 5.3) Attempt to set system locale to Korean (ko-KR)
adb shell settings put system system_locales ko-KR
echo System locale set to Korean.

REM 5.4) Check if Gboard is installed
adb shell pm list packages | findstr "com.google.android.inputmethod.latin"
if %errorlevel% neq 0 (
    echo WARNING: Gboard not found! Please install it first.
    pause
) else (
    REM Set Gboard as default IME
    echo Enabling Gboard IME...
    adb shell ime enable com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME
    
    echo Setting Gboard as default IME...
    adb shell ime set com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME
    echo Gboard set as default keyboard.
)

echo --------------------------------------------------
echo Setup completed. Please reboot your tablet.
echo If changes do not take effect, check installation status.
pause
