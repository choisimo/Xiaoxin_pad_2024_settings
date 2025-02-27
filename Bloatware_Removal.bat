@echo off

echo ===============================================
echo Xiaoxin Pad 2024 (TB331FC) Bloatware Removal Script
echo Android 14 / ZUI 16
echo -----------------------------------------------
echo 1) This script sends commands to exactly ONE ADB-connected device.
echo 2) If multiple devices/emulators are connected, you may get a "more than one device" error.
echo    Keep only one device connected via USB or use the -s <serial> option.
echo 3) Edit the package list below as needed.
echo ===============================================
pause

REM ========== 0. Check ADB connection ==========
echo [STEP 0] ADB Devices list:
adb devices
echo --------------------------------------
echo If more than one device is listed, press Ctrl+C to stop this script,
echo and then disconnect other devices or use adb with -s <serial>.
pause

REM ------------------------------------------------------------------
REM Step A) Disable packages (disable-user) first (COMMENT OUT if not needed)
REM ------------------------------------------------------------------
echo [STEP A] Attempting to disable packages (disable-user --user 0):
REM ### Keep only the packages you actually want to disable ###

echo -- Disabling Weibo --
adb shell pm disable-user --user 0 com.sina.weibo

echo -- Disabling QQMusic --
adb shell pm disable-user --user 0 com.tencent.qqmusic

echo -- Disabling WPS Office --
adb shell pm disable-user --user 0 cn.wps.moffice_eng

echo -- Disabling Lenovo Club --
adb shell pm disable-user --user 0 com.lenovo.club.app

echo -- Disabling Lenovo Browser (Chinese) --
adb shell pm disable-user --user 0 com.lenovo.browser.hd

echo -- Disabling Lenovo AppStore (Chinese) --
adb shell pm disable-user --user 0 com.lenovo.leos.appstore

echo -- Disabling Lenovo Weather --
adb shell pm disable-user --user 0 com.lenovo.weathercenter
adb shell pm disable-user --user 0 com.zui.weather

echo -- Disabling Baidu Map Location --
adb shell pm disable-user --user 0 com.baidu.map.location

echo -- Disabling Lenovo DSA --
adb shell pm disable-user --user 0 com.lenovo.dsa

echo -- Disabling LMSA --
adb shell pm disable-user --user 0 com.lmsa.app.lmsapad

echo -- Disabling Lenovo Tianjiao App --
adb shell pm disable-user --user 0 com.lenovo.lfh.tianjiao.tablet

echo -- Disabling Tbsmart Levision --
adb shell pm disable-user --user 0 com.tbsmart.levision

echo -- Disabling Tblenovo Apps (Push/Center) --
adb shell pm disable-user --user 0 com.tblenovo.center
adb shell pm disable-user --user 0 com.tblenovo.tabpushout

echo -- Disabling Lenovo Voice (example) --
REM adb shell pm disable-user --user 0 com.lenovo.levoice.caption
REM adb shell pm disable-user --user 0 com.lenovo.levoice_agent
REM (Add more if needed)

echo --------------------------------------
echo [Done] Disable commands have been executed. After rebooting, use the tablet for a few days to check stability.
pause

REM ------------------------------------------------------------------
REM Step B) If no issues, uninstall packages (uninstall --user 0)
REM ------------------------------------------------------------------
echo [STEP B] Uninstall packages for user 0 (uninstall --user 0)
echo Note: They may be restored after factory reset/OTA update.
echo Reinstalling might not be straightforward. Press Enter to continue.
pause

echo -- Uninstalling Weibo --
adb shell pm uninstall --user 0 com.sina.weibo

echo -- Uninstalling QQMusic --
adb shell pm uninstall --user 0 com.tencent.qqmusic

echo -- Uninstalling WPS Office --
adb shell pm uninstall --user 0 cn.wps.moffice_eng

echo -- Uninstalling Lenovo Club --
adb shell pm uninstall --user 0 com.lenovo.club.app

echo -- Uninstalling Lenovo Browser (Chinese) --
adb shell pm uninstall --user 0 com.lenovo.browser.hd

echo -- Uninstalling Lenovo AppStore (Chinese) --
adb shell pm uninstall --user 0 com.lenovo.leos.appstore

echo -- Uninstalling Lenovo Weather --
adb shell pm uninstall --user 0 com.lenovo.weathercenter
adb shell pm uninstall --user 0 com.zui.weather

echo -- Uninstalling Baidu Map Location --
adb shell pm uninstall --user 0 com.baidu.map.location

echo -- Uninstalling Lenovo DSA --
adb shell pm uninstall --user 0 com.lenovo.dsa

echo -- Uninstalling LMSA --
adb shell pm uninstall --user 0 com.lmsa.app.lmsapad

echo -- Uninstalling Lenovo Tianjiao --
adb shell pm uninstall --user 0 com.lenovo.lfh.tianjiao.tablet

echo -- Uninstalling Tbsmart Levision --
adb shell pm uninstall --user 0 com.tbsmart.levision

echo -- Uninstalling Tblenovo Apps (Push/Center) --
adb shell pm uninstall --user 0 com.tblenovo.center
adb shell pm uninstall --user 0 com.tblenovo.tabpushout

REM echo -- Uninstalling Lenovo Voice (example) --
REM adb shell pm uninstall --user 0 com.lenovo.levoice.caption
REM adb shell pm uninstall --user 0 com.lenovo.levoice_agent

echo --------------------------------------
echo Uninstall commands for selected packages have completed.
echo Reboot the device and verify.
echo --------------------------------------
pause
