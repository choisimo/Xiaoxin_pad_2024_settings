# Xiaoxin Pad 2024 빠른 설정 안내

이 문서는 Lenovo Xiaoxin Pad 2024 (TB331FC, ZUI 16, Android 14) 기기에서 다음 작업을 빠르게 진행할 수 있도록 도와줍니다.

1. **개발자 모드 활성화** 및 ADB 사용 준비  
2. **구글 플레이 스토어**, **구글 플레이 서비스**, **SetEdit** 설치  
3. **중국어 기본 앱(블로트웨어) 비활성화/삭제**를 통한 기기 최적화  
4. (선택) **로케일 변경**(예: `SetEdit`을 통한 반한글화 등)

## 1. 사전 요구사항

- **Windows PC**에 [ADB 툴(platform-tools)](https://developer.android.com/tools/releases/platform-tools) 설치  
- **USB 케이블**로 Xiaoxin Pad와 PC를 연결  
- 태블릿 개발자 옵션 및 USB 디버깅 모드 활성화

### 개발자 옵션 및 USB 디버깅 활성화 방법

1. 태블릿에서 **설정 → 태블릿 정보(About tablet)** 진입  
2. **빌드 번호(ZUI 버전 정보)** 항목을 7회 이상 연속 탭 → “개발자가 되었습니다” 메시지 확인  
3. 설정 메뉴로 돌아가면 **개발자 옵션** 항목이 생성됨  
4. **설정 → 시스템 → 개발자 옵션 → USB 디버깅** 켜기 (다른 옵션은 기본값)

### 스크립트 동작

- `xiaoxin_setup.bat` 스크립트가 다음을 수행합니다:
  1. Google Drive 링크에서 필요한 APK를 다운로드 시도 (Play Store, Play Services, SetEdit)  
  2. `adb install`로 각 APK 설치  
  3. 원치 않는 중국 앱(Weibo, QQMusic, Lenovo Browser 등)을 비활성화 후 (원하면) 삭제  
- 다운로드가 실패한다면, 수동으로 APK를 받아서 스크립트와 같은 폴더에 배치 후, 다운로드 명령을 주석 처리한 뒤 설치만 진행하세요.

## 2. 사용 방법

1. **xiaoxin_setup.bat** 파일을 PC에 다운로드  
2. (선택) **수동 다운로드**: 만약 스크립트의 다운로드가 안 될 시, 아래 링크에서 직접 APK를 받으세요.  
   https://docs.google.com/uc?export=download&id=1Wqrf8qK_1Rg5uRU9MKOPbUxsaN5Wc7yH
  https://docs.google.com/uc?export=download&id=112hxb1h8KAdR1DdAExtyGdS2pMnVgE0e
  https://docs.google.com/uc?export=download&id=1OV6x9WFw1sje9w2vtWM1JLEoSq8Fgl4S
  https://docs.google.com/uc?export=download&id=1n6CrGQL0zCsWOyKgbJVy3iZyhQQrrDmQ
3. **Xiaoxin Pad**를 USB로 연결한 뒤, **CMD**(명령 프롬프트)에서 `xiaoxin_setup.bat` 실행  
4. 안내에 따라 **Pause** 시 멈출 때마다 Enter 키로 진행  
5. 설치/제거 완료 후, 태블릿을 재부팅하고 Google Play 로그인이 정상 동작하는지, 불필요 앱이 제거되었는지 확인  
6. **SetEdit**을 통한 로케일 변경은 (예: `pm grant by4a.setedit22 android.permission.WRITE_SECURE_SETTINGS`) 명령으로 권한 부여 후 수동 설정하거나, 필요하면 추가 스크립트를 작성합니다.

## 3. 주의사항

- 이 스크립트는 불필요 앱을 일괄 처리하지만, 일부 앱을 제거하면 특정 기능(OTA 업데이트, 날씨, 위치 등)이 정상 작동하지 않을 수 있습니다.  
- **Disable(비활성화)** 후 문제가 없으면 **Uninstall(삭제)** 하는 순서로 진행하세요.  
- 언제든지 문제가 생기면 `pm enable --user 0 <패키지>`로 되돌리거나, 공장초기화를 통해 원복할 수 있습니다.  
- Google Drive 링크가 직접 다운로드를 허용하지 않을 수 있으니, 필요 시 브라우저에서 수동 다운로드 후 `adb install <파일명>.apk`로 설치하세요.

----
