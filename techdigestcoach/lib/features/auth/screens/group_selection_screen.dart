/// 과목 선택 화면
/// 
/// 사용자가 소속 과목을 선택하는 화면입니다.
/// BD 과목과 STAFF 과목 중에서 선택할 수 있으며, 과목별로 다른 문제가 제공됩니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.1

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // Timer 사용을 위한 import

// 스타일 import
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

// 모델 import
import '../../../shared/models/user_group.dart';

// Provider import
import '../../../providers/app_state.dart';

// 화면 import
import 'main_menu_screen.dart';
import 'nickname_screen.dart';

/// 과목 선택 화면 위젯
class GroupSelectionScreen extends StatefulWidget {
  const GroupSelectionScreen({super.key});

  @override
  State<GroupSelectionScreen> createState() => _GroupSelectionScreenState();
}

class _GroupSelectionScreenState extends State<GroupSelectionScreen> {
  Timer? _longPressTimer;

  @override
  void dispose() {
    _longPressTimer?.cancel();
    super.dispose();
  }

  /// 과목 선택 처리 메소드
  void _handleGroupSelection(BuildContext context, UserGroup group) {
    print('과목 선택: $group');
    context.read<AppState>().selectGroup(group);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainMenuScreen()),
    );
  }

  /// 앱 정보 표시 메소드
  void _showAppInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '앱 정보',
            style: AppTextStyles.heading.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TechDigestCoach',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '버전: 1.0.1',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '만든이: chim\nEmail: wlsrbs321@naver.com',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                '확인',
                style: AppTextStyles.button.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 데이터 초기화 확인 다이얼로그 표시 메소드
  void _showDataResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '데이터 초기화',
            style: AppTextStyles.heading.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            '모든 학습 데이터가 삭제됩니다.\n계속하시겠습니까?',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                '취소',
                style: AppTextStyles.button.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // 데이터 초기화
                context.read<AppState>().resetData();
                // 현재 다이얼로그 닫기
                Navigator.of(context).pop();
                // 닉네임 입력 화면으로 이동
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const NicknameScreen()),
                );
              },
              child: Text(
                '초기화',
                style: AppTextStyles.button.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 과목 선택 화면 UI를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('GroupSelectionScreen build 메소드가 호출되었습니다.');
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '과목 선택',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () => _showAppInfo(context),
            onLongPressStart: (_) {
              // 길게 누르기 시작 시 타이머 시작
              _longPressTimer = Timer(const Duration(seconds: 3), () {
                _showDataResetDialog(context);
              });
            },
            onLongPressEnd: (_) {
              // 길게 누르기 종료 시 타이머 취소
              _longPressTimer?.cancel();
            },
            child: IconButton(
              icon: Icon(Icons.info_outline, color: AppColors.textSecondary),
              onPressed: () => _showAppInfo(context),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.surface,
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // 메인 타이틀
                Text(
                  'TechDigestCoach',
                  style: AppTextStyles.heading.copyWith(
                    color: AppColors.text,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // 안내 텍스트
                Text(
                  '학습하고자 하는 TechDigest 과목을\n선택해주세요.',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                // 과목 선택 카드들
                Expanded(
                  child: Column(
                    children: [
                      // BD 과목 카드
                      Expanded(
                        child: _GroupCard(
                          title: 'BD 과목',
                          subtitle: '',
                          description: '',
                          icon: Icons.business_outlined,
                          color: AppColors.primary,
                          onTap: () => _handleGroupSelection(context, UserGroup.bd),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // STAFF 과목 카드
                      Expanded(
                        child: _GroupCard(
                          title: 'STAFF 과목',
                          subtitle: '',
                          description: '',
                          icon: Icons.people_outline,
                          color: AppColors.staffPrimary,
                          onTap: () => _handleGroupSelection(context, UserGroup.staff),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // 참고사항
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.border,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '참고사항: 본 앱의 문제는 교재를 기반으로 제작되었으며, 실제 시험 유형과는 차이가 있을 수 있습니다.',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 과목 선택 카드 위젯
class _GroupCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _GroupCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // 배경 아이콘
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  icon,
                  size: 180,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              // 컨텐츠
              Padding(
                padding: const EdgeInsets.all(28),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 44,  // 아이콘 크기 증가
                      color: Colors.white,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      title,
                      style: AppTextStyles.heading.copyWith(
                        color: Colors.white,
                        fontSize: 38,  // 제목 크기 증가
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 