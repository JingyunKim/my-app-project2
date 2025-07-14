/// 학습 유형 선택 화면
/// 
/// 사용자가 학습 모드를 선택할 수 있는 화면입니다.
/// 연습 모드, 모의고사 모드, 학습 이력을 선택할 수 있으며,
/// 사용자 정보와 과목 정보를 표시합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 스타일 import
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

// 모델 import
import '../../../shared/models/user_group.dart';

// Provider import
import '../../../providers/app_state.dart';

// 화면 import
import '../../practice/screens/practice_screen.dart';
import '../../exam/screens/exam_screen.dart';
import '../../history/screens/history_screen.dart';
import 'group_selection_screen.dart';
import '../../settings/screens/settings_screen.dart';

/// 학습 유형 선택 화면 위젯
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  /// 닉네임 변경 다이얼로그 표시 메소드
  void _showNicknameChangeDialog(BuildContext context) {
    final currentUser = context.read<AppState>().currentUser;
    final nicknameController = TextEditingController(text: currentUser?.nickname ?? '');
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '닉네임 변경',
            style: AppTextStyles.heading.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '새로운 닉네임을 입력해주세요',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nicknameController,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: '닉네임을 입력하세요',
                  hintStyle: AppTextStyles.body.copyWith(
                    color: AppColors.textLight,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                style: AppTextStyles.body,
              ),
            ],
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
            ElevatedButton(
              onPressed: () {
                final newNickname = nicknameController.text.trim();
                if (newNickname.isNotEmpty) {
                  context.read<AppState>().updateNickname(newNickname);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('닉네임이 변경되었습니다.'),
                      backgroundColor: AppColors.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '변경',
                style: AppTextStyles.button.copyWith(
                  color: AppColors.surface,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 학습 유형 선택 화면 UI를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('학습 유형 선택 화면 build 메소드가 호출되었습니다.');
    final user = context.watch<AppState>().currentUser;
    final group = context.watch<AppState>().selectedGroup;
    
    // 과목별 색상 설정
    final isStaffGroup = group == UserGroup.staff;
    final primaryColor = isStaffGroup ? AppColors.staffPrimary : AppColors.primary;
    final secondaryColor = isStaffGroup ? AppColors.staffSecondary : AppColors.secondary;
    final accentColor = isStaffGroup ? AppColors.staffAccent : AppColors.accent;
    final accent2Color = isStaffGroup ? AppColors.staffAccent2 : AppColors.accent2;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '학습 유형 선택',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textSecondary),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const GroupSelectionScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: AppColors.textSecondary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
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
                // 과목 표시
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    group == UserGroup.bd ? 'BD 과목' : 'STAFF 과목',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 환영 메시지
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${user?.nickname ?? ''}님,\n학습을 시작해볼까요?',
                        style: AppTextStyles.heading.copyWith(
                          color: AppColors.text,
                          fontSize: 24,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: () => _showNicknameChangeDialog(context),
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // 학습 모드 섹션
                Text(
                  '학습 모드',
                  style: AppTextStyles.heading.copyWith(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '원하시는 학습 모드를 선택해주세요.',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                // 학습 모드 선택 버튼들
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          children: [
                            // 연습 모드 버튼
                            Expanded(
                              child: _MenuButton(
                                title: '연습 모드',
                                subtitle: '원하는 만큼 천천히 학습하세요',
                                features: '해설 제공 · 진도 저장',
                                icon: Icons.edit_note_outlined,
                                color: primaryColor,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const PracticeScreen()),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            // 모의고사 모드 버튼
                            Expanded(
                              child: _MenuButton(
                                title: '모의고사 모드',
                                subtitle: '실전과 동일한 환경에서 테스트하세요',
                                features: '20분 · 10문항 · 성적 분석',
                                icon: Icons.timer_outlined,
                                color: secondaryColor,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const ExamScreen()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 학습 관리 섹션
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: AppColors.border,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _ManagementButton(
                                title: '학습 이력',
                                icon: Icons.history_outlined,
                                color: accentColor,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _ManagementButton(
                                title: '틀린 문제',
                                icon: Icons.refresh_outlined,
                                color: accent2Color,
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('준비 중인 기능입니다.'),
                                      backgroundColor: AppColors.warning,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  );
                                },
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

/// 학습 모드 메뉴 버튼 위젯
class _MenuButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String features;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuButton({
    required this.title,
    required this.subtitle,
    required this.features,
    required this.icon,
    required this.color,
    required this.onTap,
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
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: AppColors.surface,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      title,
                      style: AppTextStyles.heading.copyWith(
                        color: AppColors.surface,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Text(
                    subtitle,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.surface,
                      fontSize: 16,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.surface.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          features,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.surface.withOpacity(0.9),
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.surface.withOpacity(0.7),
                        size: 20,
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

/// 학습 관리 버튼 위젯
class _ManagementButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ManagementButton({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.button.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 