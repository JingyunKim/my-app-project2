/// 메인 메뉴 화면
/// 
/// 사용자가 학습 모드를 선택할 수 있는 메인 화면입니다.
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

/// 메인 메뉴 화면 위젯
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  /// 메인 메뉴 화면 UI를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('MainMenuScreen build 메소드가 호출되었습니다.');
    final user = context.watch<AppState>().currentUser;
    final group = context.watch<AppState>().selectedGroup;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '메인 메뉴',
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
            // 과목 선택 화면으로 이동
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const GroupSelectionScreen()),
            );
          },
        ),
        actions: [
          // 과목 변경 버튼
          IconButton(
            icon: Icon(Icons.group_outlined, color: AppColors.textSecondary),
            onPressed: () {
              // 과목 선택 화면으로 이동
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const GroupSelectionScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined, color: AppColors.textSecondary),
            onPressed: () {
              // 설정 화면으로 이동 (추후 구현)
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
                // 사용자 정보 카드 (학습 이력 포함)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary.withOpacity(0.1), AppColors.secondary.withOpacity(0.1)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.primary, AppColors.secondary],
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.surface,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '안녕하세요, ${user?.nickname ?? ''}님',
                                  style: AppTextStyles.heading.copyWith(
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: group == UserGroup.bd ? AppColors.primary : AppColors.secondary,
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
                              ],
                            ),
                          ),
                          // 과목 변경 버튼 (카드 내부)
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => const GroupSelectionScreen()),
                              );
                            },
                            icon: Icon(
                              Icons.edit_outlined,
                              color: AppColors.textSecondary.withOpacity(0.6),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // 학습 이력 요약
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppColors.accent, AppColors.accent.withOpacity(0.7)],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.history_outlined,
                                color: AppColors.surface,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '학습 이력',
                                    style: AppTextStyles.subtitle.copyWith(
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '나의 학습 현황을 확인해보세요',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.accent.withOpacity(0.6),
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '학습 모드 선택',
                  style: AppTextStyles.heading.copyWith(
                    color: AppColors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                // 학습 모드 카드들을 Flexible로 배치
                Flexible(
                  child: Column(
                    children: [
                      // 연습 모드 카드
                      Flexible(
                        flex: 1,
                        child: _MenuCard(
                          title: '연습 모드',
                          subtitle: '무제한 학습',
                          description: '시간 제한 없이 문제를 풀어보세요',
                          icon: Icons.book_outlined,
                          color: AppColors.primary,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const PracticeScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      // 모의고사 모드 카드
                      Flexible(
                        flex: 1,
                        child: _MenuCard(
                          title: '모의고사 모드',
                          subtitle: '실제 시험 환경',
                          description: '30문제를 45분 안에 풀어보세요',
                          icon: Icons.timer_outlined,
                          color: AppColors.secondary,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 메인 메뉴 카드 위젯
class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // 아이콘 영역
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.surface,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // 텍스트 영역
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.heading.copyWith(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textLight,
                          height: 1.3,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // 화살표 아이콘
                Icon(
                  Icons.arrow_forward_ios,
                  color: color.withOpacity(0.6),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 