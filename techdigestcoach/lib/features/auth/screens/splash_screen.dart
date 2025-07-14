/// 스플래시 화면
/// 
/// 이 파일은 앱 작 시 표시되는 스플래시 화면을 정의합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../../core/theme/app_colors.dart";
import "../../../core/theme/app_text_styles.dart";
import "../../../providers/app_state.dart";
import "nickname_screen.dart";
import "main_menu_screen.dart";

/// 스플래시 화면 위젯
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("SplashScreen initState 호출");
    _navigateToNextScreen();
  }

  /// 다음 화면으로 자동 전환하는 메소드
  Future<void> _navigateToNextScreen() async {
    print("3초 후 다음 화면으로 전환합니다.");
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      final appState = context.read<AppState>();
      final user = appState.currentUser;
      
      if (user != null) {
        // 이미 로그인된 경우 메인 메뉴로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainMenuScreen()),
        );
      } else {
        // 로그인이 필요한 경우 닉네임 입력 화면으로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NicknameScreen()),
        );
      }
    }
  }

  /// 스플래시 화면 UI를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print("SplashScreen build 메소드가 호출되었습니다.");
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.secondary.withOpacity(0.1),
              AppColors.accent.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 로고 영역
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.school_outlined,
                      size: 60,
                      color: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 앱 제목
                  Text(
                    "TechDigestCoach",
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // 부제목
                  Text(
                    "사내 시험 학습 플랫폼",
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  // 로딩 인디케이터
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 버전 정보
                  Text(
                    "Version 1.0.0",
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
