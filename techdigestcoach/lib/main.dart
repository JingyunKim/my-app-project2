/// TechDigestCoach 앱의 메인 진입점
/// 
/// 이 파일은 Flutter 앱의 시작점으로, 앱의 기본 구조와 테마를 정의합니다.
/// Apple 스타일의 디자인 시스템을 적용하여 미니멀하고 직관적인 UI를 제공합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Apple 스타일 색상 정의
class AppColors {
  static const Color primary = Color(0xFF007AFF);
  static const Color secondary = Color(0xFF5856D6);
  static const Color background = Color(0xFFF2F2F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color divider = Color(0xFFC6C6C8);
}

/// Apple 스타일 텍스트 스타일 정의
class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );
}

/// 앱의 메인 진입점
void main() {
  print('TechDigestCoach 앱이 시작됩니다.');
  runApp(const MyApp());
}

/// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// 앱의 기본 구조와 테마를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('MyApp build 메소드가 호출되었습니다.');
    return MaterialApp(
      title: 'TechDigestCoach',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          background: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.text,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.title,
          headlineMedium: AppTextStyles.heading,
          bodyLarge: AppTextStyles.body,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

/// 스플래시 화면 위젯
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  /// 스플래시 화면 UI를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('SplashScreen build 메소드가 호출되었습니다.');
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TechDigestCoach',
              style: AppTextStyles.title.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '사내 시험 학습용 앱',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
