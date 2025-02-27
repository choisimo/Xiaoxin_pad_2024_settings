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

REM Step 1: Download APKs from Google Drive (may fail)
echo [STEP 1] Attempting to download APKs via PowerShell...

set PLAYSTORE_URL=https://docs.google.com/uc?export=download&id=1Wqrf8qK_1Rg5uRU9MKOPbUxsaN5Wc7yH
set SETEDIT_URL=https://docs.google.com/uc?export=download&id=112hxb1h8KAdR1DdAExtyGdS2pMnVgE0e
set PLAYSERVICES_URL=https://docs.google.com/uc?export=download&id=1OV6x9WFw1sje9w2vtWM1JLEoSq8Fgl4S
set GBOARD_URL=https://docs.google.com/uc?export=download&id=1n6CrGQL0zCsWOyKgbJVy3iZyhQQrrDmQ

REM Download them (if direct link fails, the result may be HTML):
powershell -Command "Invoke-WebRequest -Uri %PLAYSTORE_URL% -OutFile PlayStore.apk"
powershell -Command "Invoke-WebRequest -Uri %SETEDIT_URL% -OutFile SetEdit.apk"
powershell -Command "Invoke-WebRequest -Uri %PLAYSERVICES_URL% -OutFile PlayServices.apk"
powershell -Command "Invoke-WebRequest -Uri %GBOARD_URL% -OutFile Gboard.apk"

echo --------------------------------------------------
echo Check if the downloaded files are real APK files.
echo If they are HTML or 0KB, please manually download.
pause

REM Step 2: Install each APK
echo [STEP 2] Installing PlayStore, PlayServices, SetEdit, Gboard...
adb install PlayStore.apk
adb install PlayServices.apk
adb install SetEdit.apk
adb install Gboard.apk

echo -------------------------------------------
echo Make sure installation succeeded. If any fails:
echo  - Possibly rename or re-download the actual .apk

echo  - Then run 'adb install <filename>' manually
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

REM Optional Lenovo Voice apps example:
REM adb shell pm disable-user --user 0 com.lenovo.levoice.caption
REM adb shell pm disable-user --user 0 com.lenovo.levoice_agent

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

REM Optional Lenovo Voice apps example:
REM adb shell pm uninstall --user 0 com.lenovo.levoice.caption
REM adb shell pm uninstall --user 0 com.lenovo.levoice_agent

echo --------------------------------------------------
echo Uninstall done. Reboot your tablet and verify.
echo --------------------------------------------------
pause

REM Step 5: Grant SetEdit permission and set system language to ko-KR

echo [STEP 5] Setting up Korean locale and default Gboard...

REM 5.2) Grant SetEdit permission for WRITE_SECURE_SETTINGS
adb shell pm grant by4a.setedit22 android.permission.WRITE_SECURE_SETTINGS

REM 5.3) Attempt to set system locale to Korean (ko-KR)
adb shell settings put system system_locales ko-KR

REM 5.4) Set Gboard as default IME
REM Gboard package name is typically com.google.android.inputmethod.latin

echo Enabling Gboard IME...
adb shell ime enable com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME

echo Setting Gboard as default IME...
adb shell ime set com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME

echo --------------------------------------------------
echo Locale set to ko-KR (via SetEdit) and Gboard set as default.
echo If changes do not take effect, reboot your tablet.

echo Script completed.
pause
