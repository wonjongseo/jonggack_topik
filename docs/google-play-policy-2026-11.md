# Google Play 정책 경고 대응 (2026-11-19)

첨부된 Console 경고: Billing Library 8.0.0 이상, targetSdk 36 이상.

## 변경 내용

- 기존 작업의 compileSdk/targetSdk 36 설정 유지.
- in_app_purchase 3.3.x 및 in_app_purchase_android 0.5.0: Billing 8.0.0 사용.
- Flutter >=3.38.0 / Dart >=3.10.0 필요. 검증 SDK: Flutter 3.38.9.
- AGP 8.10.1 / Gradle 8.12로 API 36 지원.
- 업로드 버전: 1.1.3+2026111901. Console에 더 큰 versionCode가 있다면 추가 증가 필요.
- 기존 결제 서비스와 iOS의 미커밋 수정은 유지.

## 빌드

Flutter 3.38.9를 설치하거나 FVM 등으로 선택한 뒤 실행:

```sh
flutter --version
flutter pub get
flutter build appbundle --release
```

결과: `build/app/outputs/bundle/release/app-release.aab`.
기존 `android/keystore` 서명 설정을 사용한다. 키/비밀번호는 저장소나 문서에 추가하지 않는다.
이번 검증에 사용하는 별도 SDK는 `/tmp/topik-flutter-3.38.9`이며 임시 경로다.
전역 `/Applications/flutter`는 3.35.0이므로 이후 빌드 전에 반드시 호환 SDK를 선택해야 한다.

## Play Console 제출

1. 내부 테스트 트랙에 새 AAB 업로드. App Bundle Explorer에서 target API 36 및 Billing 버전을 확인.
2. 라이선스 테스트 계정으로 premium_upgrade 상품 표시, 구매 성공/취소, 구매 복원 및 재실행 후 프리미엄 유지를 확인.
3. Android 16에서 하단 탐색/시스템 바 겹침, 키보드 표시, 뒤로 가기, 태블릿 화면을 확인.
4. 확인 후 프로덕션 릴리스 제출. 소스만 변경해서는 Console 경고가 해소되지 않으며 새 번들의 제출/심사 반영이 필요.

## 참고

- https://pub.dev/packages/in_app_purchase/changelog
- https://github.com/flutter/packages/blob/main/packages/in_app_purchase/in_app_purchase_android/migration_guide.md
- https://developer.android.com/build/releases/agp-8-10-0-release-notes

## 검증 결과

- 릴리스 AAB 빌드 성공 (109,568,727 bytes).
- bundletool 1.18.1 구조 검증 통과, jarsigner 서명 검증 통과.
- 최종 AAB 매니페스트: package=com.wonjongseo.numberone_topik, targetSdk=36, Billing=8.0.0, versionName=1.1.3, versionCode=2026111901.
- SHA-256: `c4e70528a9f5294e81e6539a79b812d0a0eaf131379be6463df3fece1ef096f9`
- flutter analyze: 오류 0건, 경고·권고 154건. 분석 명령은 경고로 인해 종료 코드 1.
- flutter test: 기존 기본 카운터 테스트 실패. 실제 앱에 없는 텍스트 `0`과 카운터 버튼을 기대하는 테스트이며, 결제 회귀 검증으로 사용할 수 없음.
- 실기기 결제/복원 테스트 및 Play Console 업로드/심사는 아직 수행하지 않음.
