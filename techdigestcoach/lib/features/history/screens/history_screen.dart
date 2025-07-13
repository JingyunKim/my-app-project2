/// 학습 이력 화면
/// 
/// 사용자의 학습 이력을 확인할 수 있는 화면입니다.
/// 전체 통계와 날짜별 학습 이력을 표시하며, 정답률과 문제 수를 확인할 수 있습니다.
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
import '../../../shared/models/study_history.dart';
import '../../../shared/models/user_group.dart';

// Provider import
import '../../../providers/app_state.dart';

/// 학습 이력 화면 위젯
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  /// 정답률 계산 메소드
  double _calculateAccuracy(List<StudyHistory> history) {
    print('정답률 계산');
    if (history.isEmpty) return 0;
    final correctCount = history.where((h) => h.isCorrect).length;
    return correctCount / history.length * 100;
  }

  /// 과목별 통계 계산 메소드
  Map<String, dynamic> _calculateGroupStats(List<StudyHistory> history) {
    print('과목별 통계 계산');
    final bdHistory = history.where((h) => h.group == UserGroup.bd).toList();
    final staffHistory = history.where((h) => h.group == UserGroup.staff).toList();
    
    return {
      'bd': {
        'total': bdHistory.length,
        'correct': bdHistory.where((h) => h.isCorrect).length,
        'accuracy': bdHistory.isEmpty ? 0 : bdHistory.where((h) => h.isCorrect).length / bdHistory.length * 100,
      },
      'staff': {
        'total': staffHistory.length,
        'correct': staffHistory.where((h) => h.isCorrect).length,
        'accuracy': staffHistory.isEmpty ? 0 : staffHistory.where((h) => h.isCorrect).length / staffHistory.length * 100,
      },
    };
  }

  /// 모의고사 점수 계산 메소드
  Map<String, List<double>> _calculateExamScores(List<StudyHistory> history) {
    print('모의고사 점수 계산');
    final examHistory = history.where((h) => !h.isPracticeMode).toList();
    final bdScores = <double>[];
    final staffScores = <double>[];
    
    // 모의고사 점수 계산 (30문제 기준, 1문제당 3.33점)
    for (final item in examHistory) {
      final score = item.isCorrect ? 3.33 : 0.0;
      if (item.group == UserGroup.bd) {
        bdScores.add(score);
      } else {
        staffScores.add(score);
      }
    }
    
    return {
      'bd': bdScores,
      'staff': staffScores,
    };
  }

  /// 날짜별 학습 이력 그룹화 메소드
  Map<String, List<StudyHistory>> _groupHistoryByDate(List<StudyHistory> history) {
    print('날짜별 학습 이력 그룹화');
    final grouped = <String, List<StudyHistory>>{};
    for (final item in history) {
      final date = _formatDate(item.solvedDate);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(item);
    }
    return grouped;
  }

  /// 날짜 포맷팅 메소드
  String _formatDate(DateTime date) {
    print('날짜 포맷팅: $date');
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

  @override
  Widget build(BuildContext context) {
    print('HistoryScreen build 메소드 호출');
    final history = context.watch<AppState>().studyHistory;
    final accuracy = _calculateAccuracy(history);
    final groupStats = _calculateGroupStats(history);
    final examScores = _calculateExamScores(history);
    final groupedHistory = _groupHistoryByDate(history ?? []);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '학습 이력',
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
        child: Column(
          children: [
            // 통계 카드
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.2),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.analytics_outlined,
                          color: AppColors.surface,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '전체 통계',
                        style: AppTextStyles.heading.copyWith(
                          color: AppColors.text,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // 전체 통계
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${history.length}',
                                style: AppTextStyles.title.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '총 문제 수',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.success.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${accuracy.toStringAsFixed(1)}%',
                                style: AppTextStyles.title.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '정답률',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 과목별 통계
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'BD 과목',
                                style: AppTextStyles.subtitle.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${groupStats['bd']['total']}문제',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${groupStats['bd']['accuracy'].toStringAsFixed(1)}%',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.staffPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.staffPrimary.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'STAFF 과목',
                                style: AppTextStyles.subtitle.copyWith(
                                  color: AppColors.staffPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${groupStats['staff']['total']}문제',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${groupStats['staff']['accuracy'].toStringAsFixed(1)}%',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 모의고사 점수
                  if ((examScores['bd']?.isNotEmpty ?? false) || (examScores['staff']?.isNotEmpty ?? false))
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.accent.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '모의고사 점수',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              if (examScores['bd']?.isNotEmpty ?? false)
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'BD 과목',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${(examScores['bd'] ?? []).isNotEmpty ? examScores['bd']!.reduce((a, b) => a + b).toStringAsFixed(1) : '0.0'}점',
                                        style: AppTextStyles.body.copyWith(
                                          color: AppColors.text,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if ((examScores['bd']?.isNotEmpty ?? false) && (examScores['staff']?.isNotEmpty ?? false))
                                const SizedBox(width: 20),
                              if (examScores['staff']?.isNotEmpty ?? false)
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'STAFF 과목',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${(examScores['staff'] ?? []).isNotEmpty ? examScores['staff']!.reduce((a, b) => a + b).toStringAsFixed(1) : '0.0'}점',
                                        style: AppTextStyles.body.copyWith(
                                          color: AppColors.text,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // 날짜별 학습 이력
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: groupedHistory.length,
                itemBuilder: (context, index) {
                  final date = groupedHistory.keys.elementAt(index);
                  final items = groupedHistory[date]!;
                  final correctCount = items.where((item) => item.isCorrect).length;
                  final accuracy = (correctCount / items.length * 100).toStringAsFixed(1);
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.accent,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              date,
                              style: AppTextStyles.subtitle.copyWith(
                                color: AppColors.text,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.success.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                '$accuracy%',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _StatItem(
                                label: '푼 문제',
                                value: '${items.length}문제',
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _StatItem(
                                label: '정답',
                                value: '$correctCount문제',
                                color: AppColors.success,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _StatItem(
                                label: '오답',
                                value: '${items.length - correctCount}문제',
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 통계 아이템 위젯
class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.subtitle.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
} 