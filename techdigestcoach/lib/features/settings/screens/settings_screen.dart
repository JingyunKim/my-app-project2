/// 설정 화면
/// 
/// 사용자가 앱 설정을 관리할 수 있는 화면입니다.
/// 앱 정보 확인과 데이터 초기화 기능을 제공합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 스타일 import
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

// Provider import
import '../../../providers/app_state.dart';

// 화면 import
import '../../auth/screens/group_selection_screen.dart';

/// 설정 화면 위젯
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// 데이터 초기화 처리 메소드
  void _handleDataReset(BuildContext context) {
    print('데이터 초기화 요청');
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
            ElevatedButton(
              onPressed: () {
                context.read<AppState>().resetData();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const GroupSelectionScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '초기화',
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

  /// 앱 정보 표시 메소드
  void _showAppInfo(BuildContext context) {
    print('앱 정보 표시');
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '버전: 1.0.0',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '개발자 정보',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '만든이: 김진균',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Email: wlsrbs321@naver.com',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
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

  /// 설정 화면 UI를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('SettingsScreen build 메소드가 호출되었습니다.');
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '설정',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                // 설정 메뉴
                _SettingsCard(
                  title: '앱 정보',
                  subtitle: '앱 버전 및 개발자 정보',
                  icon: Icons.info_outline,
                  color: AppColors.info,
                  onTap: () => _showAppInfo(context),
                ),
                const SizedBox(height: 16),
                _SettingsCard(
                  title: '데이터 초기화',
                  subtitle: '모든 학습 데이터를 삭제합니다',
                  icon: Icons.delete_outline,
                  color: AppColors.error,
                  onTap: () => _handleDataReset(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 설정 카드 위젯
class _SettingsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SettingsCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.text,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textLight,
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

/// 앱 설명 아이템 위젯
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 문의하기 아이템 위젯
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textLight,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
} 