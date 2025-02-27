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
echo [STEP 1] Attempting to download 3 APKs via PowerShell...
set PLAYSTORE_URL=https://drive.google.com/file/d/1Wqrf8qK_1Rg5uRU9MKOPbUxsaN5Wc7yH/view?usp=sharing
set PLAYSERVICES_URL=https://drive.google.com/file/d/1OV6x9WFw1sje9w2vtWM1JLEoSq8Fgl4S/view?usp=sharing
set SETEDIT_URL=https://drive.google.com/file/d/112hxb1h8KAdR1DdAExtyGdS2pMnVgE0e/view?usp=sharing

REM Downloading (may end up with .html if Google blocks direct link)
powershell -Command "Invoke-WebRequest -Uri %PLAYSTORE_URL% -OutFile PlayStore.apk"
powershell -Command "Invoke-WebRequest -Uri %PLAYSERVICES_URL% -OutFile PlayServices.apk"
powershell -Command "Invoke-WebRequest -Uri %SETEDIT_URL% -OutFile SetEdit.apk"

echo --------------------------------------------------
echo Check if the downloaded files are actual APK files.
echo If they are HTML or 0KB, please manually download.
pause

REM Step 2: Install each APK
echo [STEP 2] Installing PlayStore, PlayServices, SetEdit...
adb install PlayStore.apk
adb install PlayServices.apk
adb install SetEdit.apk

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

REM 5.1) If you want Gboard, you could do:
echo Checking if Gboard is installed. (Optional step)
REM adb install Gboard.apk   REM (Manually place Gboard.apk if you have it)

REM 5.2) Grant SetEdit permission for WRITE_SECURE_SETTINGS
adb shell pm grant by4a.setedit22 android.permission.WRITE_SECURE_SETTINGS

REM 5.3) Attempt to set system locale to Korean (ko-KR)
REM Note: Some devices may require a reboot to reflect changes.

adb shell settings put system system_locales ko-KR

REM 5.4) Set Gboard as default IME (if installed). For example:
REM Gboard package name is typically com.google.android.inputmethod.latin

REM Enable Gboard IME
adb shell ime enable com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME

REM Set Gboard as default
adb shell ime set com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME

echo --------------------------------------------------
echo Locale set to ko-KR (via SetEdit) and Gboard set as default.
echo If changes do not take effect, reboot your tablet.

echo Script completed.
pause
