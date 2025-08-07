/// 스플래시 화면
/// 
/// 이 파일은 앱 시작 시 표시되는 스플래시 화면을 정의합니다.
/// 사용자 정보를 확인하여 적절한 화면으로 자동 전환합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.1

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../../core/theme/app_colors.dart";
import "../../../core/theme/app_text_styles.dart";
import "../../../providers/app_state.dart";
import "nickname_screen.dart";
import "group_selection_screen.dart";

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
    print("스플래시 화면에서 다음 화면으로 전환을 준비합니다.");
    
    // 최소 2초 대기 (스플래시 화면 표시 시간)
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      try {
        // AppState가 완전히 로드될 때까지 대기
        final appState = context.read<AppState>();
        
        // 로딩이 완료될 때까지 대기
        while (appState.isLoading) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (!mounted) return;
        }
        
        final user = appState.currentUser;
        print("현재 사용자 정보: ${user?.nickname ?? '없음'}");
        
        if (user != null && user.nickname.isNotEmpty) {
          // 이미 로그인된 경우 과목 선택 화면으로 이동
          print("기존 사용자 발견: ${user.nickname}, 과목 선택 화면으로 이동합니다.");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const GroupSelectionScreen()),
          );
        } else {
          // 로그인이 필요한 경우 닉네임 입력 화면으로 이동
          print("새로운 사용자이거나 닉네임이 없습니다. 닉네임 입력 화면으로 이동합니다.");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const NicknameScreen()),
          );
        }
      } catch (e) {
        print("화면 전환 중 오류 발생: $e");
        // 오류 발생 시 닉네임 입력 화면으로 이동
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
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/images/splash12.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
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
                    "Version 1.0.1",
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
