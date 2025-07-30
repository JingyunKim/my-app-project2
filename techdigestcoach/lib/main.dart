/// TechDigestCoach 앱의 메인 진입점
/// 
/// 이 파일은 Flutter 앱의 시작점으로, 앱의 기본 구조와 테마를 정의합니다.
/// 분리된 모듈들을 import하여 앱을 구성합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";

// 스타일 import
import "core/theme/app_colors.dart";
import "core/theme/app_text_styles.dart";

// Provider import
import "providers/app_state.dart";

// 화면 import
import "features/auth/screens/splash_screen.dart";

/// 앱의 메인 진입점
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("TechDigestCoach 앱이 시작됩니다.");
  
  // 화면 세로 고정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

/// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// 앱의 기본 구조와 테마를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print("MyApp build 메소드가 호출되었습니다.");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TechDigestCoach",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'BMDOHYEON', // 배민도현체를 기본 폰트로 설정
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          background: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.text,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontFamily: 'BMDOHYEON',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'BMDOHYEON'),
          displayMedium: TextStyle(fontFamily: 'BMDOHYEON'),
          displaySmall: TextStyle(fontFamily: 'BMDOHYEON'),
          headlineLarge: TextStyle(fontFamily: 'BMDOHYEON'),
          headlineMedium: TextStyle(fontFamily: 'BMDOHYEON'),
          headlineSmall: TextStyle(fontFamily: 'BMDOHYEON'),
          titleLarge: TextStyle(fontFamily: 'BMDOHYEON'),
          titleMedium: TextStyle(fontFamily: 'BMDOHYEON'),
          titleSmall: TextStyle(fontFamily: 'BMDOHYEON'),
          bodyLarge: TextStyle(fontFamily: 'BMDOHYEON'),
          bodyMedium: TextStyle(fontFamily: 'BMDOHYEON'),
          bodySmall: TextStyle(fontFamily: 'BMDOHYEON'),
          labelLarge: TextStyle(fontFamily: 'BMDOHYEON'),
          labelMedium: TextStyle(fontFamily: 'BMDOHYEON'),
          labelSmall: TextStyle(fontFamily: 'BMDOHYEON'),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
