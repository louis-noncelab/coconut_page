# Coconut Flutter App

비트코인 셀프커스터디 솔루션 Coconut의 Flutter 웹 애플리케이션입니다.

## 기능

- 🏠 **홈페이지**: Coconut Wallet과 Vault 소개
- 💳 **Wallet 페이지**: 와치온리 지갑 기능 소개
- 🔒 **Vault 페이지**: 오프라인 하드월렛 솔루션 소개
- 🌐 **다국어 지원**: 한국어/영어 지원
- 📱 **반응형 디자인**: 모바일과 데스크톱 모두 지원

## 기술 스택

- **Flutter**: 크로스 플랫폼 UI 프레임워크
- **Provider**: 상태 관리
- **Go Router**: 네비게이션
- **Lucide Icons**: 아이콘
- **Material Design 3**: 디자인 시스템

## 실행 방법

```bash
# 의존성 설치
flutter pub get

# 웹에서 실행
flutter run -d chrome

# 또는 특정 포트에서 실행
flutter run -d chrome --web-port=3000
```

## 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── theme/
│   └── app_theme.dart       # 테마 설정
├── providers/
│   └── language_provider.dart # 언어 설정 관리
├── models/
│   └── app_localizations.dart # 다국어 지원
├── widgets/
│   ├── coconut_button.dart  # 커스텀 버튼
│   ├── coconut_card.dart    # 커스텀 카드
│   └── coconut_badge.dart   # 커스텀 배지
├── pages/
│   ├── home_page.dart       # 홈페이지
│   ├── wallet_page.dart     # Wallet 페이지
│   ├── vault_page.dart      # Vault 페이지
│   └── not_found_page.dart  # 404 페이지
└── utils/
    └── app_router.dart      # 라우팅 설정
```

## 주요 특징

### 🎨 디자인
- Coconut 브랜드 색상 사용
- Material Design 3 기반
- 반응형 레이아웃
- 커스텀 컴포넌트

### 🌍 다국어 지원
- 한국어/영어 지원
- 실시간 언어 전환
- Provider 기반 상태 관리

### 🧭 네비게이션
- Go Router 사용
- 깔끔한 URL 구조
- 404 페이지 처리

### 📱 반응형
- 모바일 우선 디자인
- 데스크톱 최적화
- 유연한 그리드 시스템

## 원본 웹사이트와의 차이점

Flutter 버전은 원본 React 웹사이트의 모든 기능을 포함하면서도 다음과 같은 개선사항을 제공합니다:

- 더 나은 성능
- 네이티브 앱으로 빌드 가능
- 일관된 UI/UX
- 크로스 플랫폼 지원

## 개발 가이드

### 새로운 페이지 추가
1. `lib/pages/`에 새 페이지 파일 생성
2. `lib/utils/app_router.dart`에 라우트 추가
3. 다국어 지원이 필요한 경우 `lib/models/app_localizations.dart`에 텍스트 추가

### 새로운 컴포넌트 추가
1. `lib/widgets/`에 새 위젯 파일 생성
2. 테마 색상은 `lib/theme/app_theme.dart`에서 관리
3. 아이콘은 Lucide Icons 사용

### 다국어 텍스트 추가
1. `lib/models/app_localizations.dart`의 `_localizedValues`에 새 텍스트 추가
2. getter 메서드 추가
3. UI에서 `l10n.newText`로 사용

## 라이선스

이 프로젝트는 원본 Coconut 프로젝트와 동일한 라이선스를 따릅니다.