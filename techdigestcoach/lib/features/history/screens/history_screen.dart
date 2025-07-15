/// 학습 이력 화면
/// 
/// 사용자의 연습문제 및 모의고사 학습 이력을 보여주는 화면입니다.
/// 상단에는 연습문제 통계와 틀린 문제 다시 풀기 기능을,
/// 하단에는 모의고사 응시 이력을 표 형태로 제공합니다.
///
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../providers/app_state.dart';
import '../../../shared/models/question.dart';
import '../../../shared/models/study_history.dart';
import 'wrong_answers_screen.dart';

/// 학습 이력 화면 위젯
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('학습 이력 화면을 구성합니다.');
    final appState = context.watch<AppState>();
    final practiceHistory = appState.studyHistory.where((h) => h.isPracticeMode).toList();
    final examHistory = appState.studyHistory.where((h) => !h.isPracticeMode).toList();

    // 연습문제 통계 계산
    final totalPractice = practiceHistory.length;
    final correctPractice = practiceHistory.where((h) => h.isCorrect).length;
    final wrongPractice = totalPractice - correctPractice;

    // 틀린 연습문제 목록
    final wrongPracticeQuestions = practiceHistory
        .where((h) => !h.isCorrect && h.question != null)
        .map((h) => h.question!)
        .toList();

    // 모의고사 이력을 회차별로 그룹화
    final examGroups = <int, List<StudyHistory>>{};
    for (final history in examHistory) {
      if (history.question != null && history.examRound != null) {
        final round = history.examRound!;
        if (!examGroups.containsKey(round)) {
          examGroups[round] = [];
        }
        examGroups[round]!.add(history);
      }
    }

    // 모의고사 응시 이력 데이터 생성
    final examRecords = examGroups.entries.map((entry) {
      final examQuestions = entry.value;
      final correctCount = examQuestions.where((q) => q.isCorrect).length;
      final score = (correctCount / examQuestions.length * 100).round();
      final wrongQuestions = examQuestions
          .where((h) => !h.isCorrect && h.question != null)
          .map((h) => h.question!)
          .toList();
      
      return ExamRecord(
        date: _formatDate(examQuestions.first.solvedDate),
        round: entry.key,
        score: score,
        wrongQuestions: wrongQuestions,
      );
    }).toList()
      ..sort((a, b) => a.round.compareTo(b.round)); // 회차 순으로 정렬

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 연습문제 이력 섹션
              _buildPracticeHistorySection(
                context: context,
                totalPractice: totalPractice,
                correctPractice: correctPractice,
                wrongPractice: wrongPractice,
                wrongQuestions: wrongPracticeQuestions,
              ),
              const SizedBox(height: 24),
              // 모의고사 이력 섹션
              _buildExamHistorySection(context, examRecords),
            ],
          ),
        ),
      ),
    );
  }

  /// 날짜 포맷팅 메소드
  String _formatDate(DateTime date) {
    print('날짜를 포맷팅합니다: $date');
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// 연습문제 이력 섹션을 구성하는 위젯
  Widget _buildPracticeHistorySection({
    required BuildContext context,
    required int totalPractice,
    required int correctPractice,
    required int wrongPractice,
    required List<Question> wrongQuestions,
  }) {
    print('연습문제 이력 섹션을 구성합니다.');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
          Text(
            '연습문제 학습 현황',
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          // 통계 그리드
          Row(
            children: [
              _buildStatItem('푼 문제', '$totalPractice', AppColors.primary),
              _buildStatItem('정답', '$correctPractice', AppColors.success),
              _buildStatItem('오답', '$wrongPractice', AppColors.error),
            ],
          ),
          const SizedBox(height: 24),
          // 틀린 문제 다시 풀기 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: wrongQuestions.isEmpty ? null : () {
                print('틀린 문제 다시 풀기 버튼이 클릭되었습니다.');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => WrongAnswersScreen(
                      wrongQuestions: wrongQuestions,
                      title: '틀린 연습문제 다시 풀기',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
              ),
              child: Text(
                '틀린 문제 다시 풀기',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 통계 아이템을 구성하는 위젯
  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.heading.copyWith(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
      ),
    );
  }

  /// 모의고사 이력 섹션을 구성하는 위젯
  Widget _buildExamHistorySection(BuildContext context, List<ExamRecord> examRecords) {
    print('모의고사 이력 섹션을 구성합니다.');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
          Text(
            '모의고사 응시 이력',
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (examRecords.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  '아직 모의고사 응시 이력이 없습니다.',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )
          else
            Column(
              children: [
                // 선 그래프
                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            reservedSize: 40, // 30에서 40으로 증가
                            interval: 20,
                            showTitles: true,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            reservedSize: 30,
                            interval: 1,
                            showTitles: true,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minY: 0,
                      maxY: 100,
                      lineBarsData: [
                        LineChartBarData(
                          spots: examRecords.map((record) => FlSpot(record.round.toDouble(), record.score.toDouble())).toList(),
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 5,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.primary.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // 테이블
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1), // 회차
                    1: FlexColumnWidth(1.5), // 점수 (너비 증가)
                    2: FlexColumnWidth(2), // 틀린 문제 보기 버튼
                  },
                  children: [
                    // 테이블 헤더
                    TableRow(
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      children: [
                        _buildTableHeader('회차'),
                        _buildTableHeader('점수'),
                        _buildTableHeader('틀린 문제'),
                      ],
                    ),
                    // 모의고사 이력 데이터
                    ...examRecords.map((record) => _buildTableRow(
                      context: context,
                      round: '${record.round}회',
                      score: '${record.score}/100',
                      onPressed: record.wrongQuestions.isEmpty ? null : () {
                        print('${record.round}회차 틀린 문제 보기 버튼이 클릭되었습니다.');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WrongAnswersScreen(
                              wrongQuestions: record.wrongQuestions,
                              title: '${record.round}회차 틀린 문제',
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// 테이블 헤더를 구성하는 위젯
  Widget _buildTableHeader(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 테이블 행을 구성하는 위젯
  TableRow _buildTableRow({
    required BuildContext context,
    required String round,
    required String score,
    VoidCallback? onPressed,
  }) {
    return TableRow(
      children: [
        // 회차
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            round,
            style: AppTextStyles.body.copyWith(color: AppColors.text),
            textAlign: TextAlign.center,
          ),
        ),
        // 점수
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            score,
            style: AppTextStyles.body.copyWith(color: AppColors.text),
            textAlign: TextAlign.center,
          ),
        ),
        // 틀린 문제 보기 버튼
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '틀린 문제 보기',
              style: AppTextStyles.button.copyWith(
                color: AppColors.primary,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 모의고사 기록을 담는 클래스
class ExamRecord {
  final String date;
  final int round;
  final int score;
  final List<Question> wrongQuestions;

  ExamRecord({
    required this.date,
    required this.round,
    required this.score,
    required this.wrongQuestions,
  });
} 