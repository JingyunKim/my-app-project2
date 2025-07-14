/// 과목 선택 화면
/// 
/// 사용자가 소속 과목을 선택하는 화면입니다.
/// BD 과목과 STAFF 과목 중에서 선택할 수 있으며, 과목별로 다른 문제가 제공됩니다.
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
import 'main_menu_screen.dart';
import 'nickname_screen.dart';
import '../../settings/screens/settings_screen.dart';

/// 과목 선택 화면 위젯
class GroupSelectionScreen extends StatelessWidget {
  const GroupSelectionScreen({super.key});

  /// 과목 선택 처리 메소드
  void _handleGroupSelection(BuildContext context, UserGroup group) {
    print('과목 선택: $group');
    context.read<AppState>().selectGroup(group);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainMenuScreen()),
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
          // 설정 버튼
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // 메인 타이틀
                  Text(
                    'TechDigest',
                    style: AppTextStyles.heading.copyWith(
                      color: AppColors.staffAccent,  // 밝은 청록색으로 변경
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '환영합니다!',
                    style: AppTextStyles.heading.copyWith(
                      color: AppColors.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
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
                  // BD 과목 카드
                  _GroupCard(
                    title: 'BD 과목',
                    subtitle: 'BD(Business Development)',
                    description: '비즈니스 관련 문제를 풀어보세요',
                    icon: Icons.business_outlined,
                    color: AppColors.primary,
                    onTap: () => _handleGroupSelection(context, UserGroup.bd),
                  ),
                  const SizedBox(height: 16),
                  // STAFF 과목 카드
                  _GroupCard(
                    title: 'STAFF 과목',
                    subtitle: '스태프(Staff)',
                    description: '일반 업무 관련 문제를 풀어보세요',
                    icon: Icons.people_outline,
                    color: AppColors.staffPrimary,
                    onTap: () => _handleGroupSelection(context, UserGroup.staff),
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
                // 타이틀 행
                Row(
                  children: [
                    Icon(
                      icon,
                      color: AppColors.surface,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: AppTextStyles.heading.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 서브타이틀
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(
                    subtitle,
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.surface.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // 설명
                Padding(
                  padding: const EdgeInsets.only(left: 36, right: 24),
                  child: Text(
                    description,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.surface.withOpacity(0.8),
                      height: 1.3,
                    ),
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