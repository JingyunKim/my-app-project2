# TechDigestCoach

IT 기술 학습을 위한 맞춤형 학습 코칭 앱

## App Store 정보

### 프로모션 텍스트
> "IT 기술의 핵심을 쉽고 체계적으로, TechDigestCoach와 함께 학습하세요!"

### 앱 설명
TechDigestCoach는 IT 기술 학습을 위한 맞춤형 학습 코칭 앱입니다. BD와 STAFF 두 가지 과목에 대한 전문적인 기술 지식을 체계적으로 학습할 수 있습니다.

주요 기능:
- 맞춤형 연습 문제: 각 과목별 전문 IT 지식 학습
- 모의고사 모드: 실전과 같은 환경에서 기술 역량 점검
- 학습 이력 관리: 개인별 학습 진행 상황 추적
- 오답 노트: 취약한 부분 복습 및 이해도 향상

TechDigestCoach와 함께라면:
- IT 기술 지식의 체계적인 학습
- 실전 문제를 통한 실력 향상
- 개인별 학습 진도 관리
- 효율적인 복습 시스템

### 키워드
IT기술, 기술학습, 개발자교육, BD, STAFF, 학습코칭, 모의고사, 문제풀이, 학습관리, 오답노트, IT교육, 기술교육, 학습도우미

## 프로젝트 구조

```
techdigestcoach/
├── lib/
│   ├── core/                 # 핵심 유틸리티 및 테마
│   │   └── theme/
│   │       ├── app_colors.dart
│   │       └── app_text_styles.dart
│   │
│   ├── features/            # 주요 기능별 모듈
│   │   ├── auth/           # 인증 및 사용자 관리
│   │   │   └── screens/
│   │   │       ├── group_selection_screen.dart
│   │   │       ├── main_menu_screen.dart
│   │   │       ├── nickname_screen.dart
│   │   │       └── splash_screen.dart
│   │   │
│   │   ├── exam/           # 모의고사 기능
│   │   │   └── screens/
│   │   │       ├── exam_result_screen.dart
│   │   │       └── exam_screen.dart
│   │   │
│   │   ├── history/        # 학습 이력 관리
│   │   │   └── screens/
│   │   │       ├── history_screen.dart
│   │   │       └── wrong_answers_screen.dart
│   │   │
│   │   └── practice/       # 연습 문제 기능
│   │       └── screens/
│   │           └── practice_screen.dart
│   │
│   ├── providers/          # 상태 관리
│   │   └── app_state.dart
│   │
│   ├── shared/            # 공유 리소스
│   │   └── models/
│   │       ├── question.dart
│   │       ├── sample_data.dart
│   │       ├── study_history.dart
│   │       ├── user_group.dart
│   │       └── user.dart
│   │
│   └── main.dart          # 앱 진입점
│
├── assets/               # 리소스 파일
│   └── fonts/
│       └── baemin/
│           ├── BMDOHYEON.ttf
│           └── BMJUA.ttf
│
├── test/                # 테스트 코드
│   └── widget_test.dart
│
└── pubspec.yaml        # 프로젝트 설정 및 의존성
```

## 개발 정보

- 개발자: chim
- 이메일: wlsrbs321@naver.com
- 버전: 1.0.0

## 라이선스

이 프로젝트는 교육 목적으로 개발되었으며, 모든 문제는 교재를 기반으로 작성되었습니다.
실제 시험 유형과는 차이가 있을 수 있습니다.
