/// 닉네임 입력 화면
/// 
/// 사용자가 학습을 시작하기 위해 닉네임을 입력하는 화면입니다.
/// 파스텔톤 색상과 현대적인 UI를 적용하여 사용자 친화적인 인터페이스를 제공합니다.
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
import 'group_selection_screen.dart';

/// 닉네임 입력 화면 위젯
class NicknameScreen extends StatefulWidget {
  const NicknameScreen({super.key});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final _nicknameController = TextEditingController();
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _nicknameController.dispose();
    // 화면이 사라질 때 푸시 알림도 제거
    _overlayEntry?.remove();
    super.dispose();
  }

  /// 닉네임 제출 처리 메소드
  Future<void> _handleSubmit() async {
    print('닉네임 제출: ${_nicknameController.text}');
    if (_nicknameController.text.trim().isEmpty) {
      // 닉네임이 비어있을 때 푸시 알림 표시
      _showToastMessage('닉네임을 입력해주세요.');
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      context.read<AppState>().loginUser(_nicknameController.text.trim());
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const GroupSelectionScreen()),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// 푸시 알림 표시 메소드
  void _showToastMessage(String message) {
    // 기존 푸시 알림이 있다면 제거
    _overlayEntry?.remove();
    
    final overlay = Overlay.of(context);
    
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 100,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.textSecondary,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.surface,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    message,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
    overlay.insert(_overlayEntry!);
    
    // 1.5초 후 자동으로 제거
    Future.delayed(const Duration(milliseconds: 1500), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  /// 닉네임 입력 화면 UI를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('NicknameScreen build 메소드가 호출되었습니다.');
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '시작하기',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
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
                  const SizedBox(height: 40),
                  // 환영 메시지
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                color: AppColors.surface,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                '환영합니다!',
                                style: AppTextStyles.heading.copyWith(
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '학습을 시작하기 위해\n닉네임을 입력해주세요.',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // 입력 필드
                  Text(
                    '닉네임',
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.border,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.text.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _nicknameController,
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintText: '닉네임을 입력하세요',
                            hintStyle: AppTextStyles.body.copyWith(
                              color: AppColors.textLight,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: AppColors.textSecondary,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            counterText: '',
                          ),
                          style: AppTextStyles.body,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _handleSubmit(),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Text(
                            '${_nicknameController.text.length}/10',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textLight,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // 안내사항
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'LG CNS의 TechDigest 교재 기반 학습 APP입니다.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textLight,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 시작 버튼
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.surface,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              '학습 시작하기',
                              style: AppTextStyles.button.copyWith(
                                fontSize: 18,
                              ),
                            ),
                    ),
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