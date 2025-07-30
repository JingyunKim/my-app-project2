/// 연습 모드 화면
/// 
/// 사용자가 시간 제한 없이 문제를 풀 수 있는 연습 모드 화면입니다.
/// 문제를 선택하고 답안을 확인할 수 있으며, 이전/다음 문제로 이동할 수 있습니다.
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
import '../../../shared/models/question.dart';
import '../../../shared/models/study_history.dart';
import '../../../shared/models/sample_data.dart';
import '../../../shared/models/user_group.dart';

// Provider import
import '../../../providers/app_state.dart';

/// 연습 모드 화면 위젯
class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late List<Question> _questions;
  int _currentQuestionIndex = 0;
  bool _showAnswer = false;
  int? _selectedAnswer; // 사용자가 선택한 답안을 저장하는 변수 추가

  @override
  void initState() {
    super.initState();
    print('PracticeScreen initState 호출');
    _initializeQuestions();
  }

  /// 문제 초기화 메소드
  void _initializeQuestions() {
    print('문제 초기화');
    final userGroup = context.read<AppState>().selectedGroup;
    _questions = sampleQuestions.where((q) => 
      (userGroup == UserGroup.bd && q.group.toLowerCase() == "bd") || 
      (userGroup == UserGroup.staff && q.group.toLowerCase() == "staff")
    ).toList()..shuffle();
    print('필터링된 문제 수: ${_questions.length}');
    setState(() {});
  }

  /// 다음 문제로 이동하는 메소드
  void _nextQuestion() {
    print('다음 문제로 이동');
    setState(() {
      _showAnswer = false;
      _selectedAnswer = null; // 선택한 답안 초기화
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  /// 이전 문제로 이동하는 메소드
  void _previousQuestion() {
    print('이전 문제로 이동');
    setState(() {
      _showAnswer = false;
      _selectedAnswer = null; // 선택한 답안 초기화
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  /// 정답 확인 메소드
  void _toggleAnswer() {
    print('정답 확인: ${_showAnswer ? '숨기기' : '보기'}');
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  /// 문제 선택 처리 메소드
  void _handleAnswer(int selectedAnswer) {
    print('선택한 답안: $selectedAnswer');
    final question = _questions[_currentQuestionIndex];
    final isCorrect = selectedAnswer == question.correctAnswer;
    
    // 학습 이력 저장
    context.read<AppState>().addHistory(
      StudyHistory(
        id: 'practice_${DateTime.now().millisecondsSinceEpoch}_${_currentQuestionIndex}',
        question: question,
        group: (question.group == "bd" ? UserGroup.bd : UserGroup.staff).toString(),
        isCorrect: isCorrect,
        solvedDate: DateTime.now(),
        isPracticeMode: true,
      ),
    );

    setState(() {
      _selectedAnswer = selectedAnswer; // 사용자가 선택한 답안 저장
      _showAnswer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('PracticeScreen build 메소드 호출');
    
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '문제를 불러오는 중...',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '연습 모드',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              '${_currentQuestionIndex + 1}/${_questions.length}',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
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
        child: Column(
          children: [
            // 진행 상황 표시
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 8,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 문제 카드
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.12),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 문제 카드 Q. 표기 개선
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Q${_currentQuestionIndex + 1}. ',
                                  style: AppTextStyles.subtitle.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text: question.question,
                                  style: AppTextStyles.heading.copyWith(
                                    color: AppColors.text,
                                    fontSize: 18,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 보기 목록
                    ...List.generate(
                      question.options.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _AnswerOption(
                          option: question.options[index],
                          isSelected: _showAnswer && index == question.correctAnswer,
                          isUserSelected: _selectedAnswer == index,
                          onTap: _showAnswer ? null : () => _handleAnswer(index), // 답안 선택 후에는 더 이상 선택 불가
                        ),
                      ),
                    ),
                    if (_showAnswer) ...[
                      const SizedBox(height: 24),
                      // 해설 카드
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.success.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.success,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.lightbulb_outline,
                                    color: AppColors.surface,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '해설',
                                  style: AppTextStyles.subtitle.copyWith(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              question.explanation,
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.text,
                                height: 1.5,
                              ),
                              maxLines: null,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // 추가 정보 카드
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.border,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '추가 정보',
                              style: AppTextStyles.subtitle.copyWith(
                                color: AppColors.text,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // 난이도와 주제
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '난이도: ${question.difficulty}',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '주제: ${question.topic}',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // 학습 의도
                            Text(
                              '학습 의도',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              question.intent,
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.text,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // 참조
                            Text(
                              '참조',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              question.reference,
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.text,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // 하단 버튼 영역 개선
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.divider,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // 이전 버튼 제거
                    // 연습모드 종료 버튼 추가
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // 메인 메뉴 등으로 이동
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: AppColors.surface,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.exit_to_app, size: 16),
                            const SizedBox(width: 8),
                            Text('연습모드 종료', style: AppTextStyles.button),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (_currentQuestionIndex < _questions.length - 1 && _selectedAnswer != null) ? _nextQuestion : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (_currentQuestionIndex < _questions.length - 1 && _selectedAnswer != null) 
                              ? AppColors.primary 
                              : AppColors.divider,
                          foregroundColor: AppColors.surface,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('다음', style: AppTextStyles.button),
                            const SizedBox(width: 8),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 답안 선택 옵션 위젯
class _AnswerOption extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isUserSelected; // 사용자가 선택한 답안인지 여부
  final VoidCallback? onTap; // null일 수 있도록 수정

  const _AnswerOption({
    required this.option,
    required this.isSelected,
    required this.isUserSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 색상 결정 로직
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Color circleColor;
    IconData? iconData;
    Color iconColor = AppColors.surface;

    if (isSelected) {
      // 정답인 경우 (초록색)
      backgroundColor = AppColors.success.withOpacity(0.1);
      borderColor = AppColors.success;
      textColor = AppColors.success;
      circleColor = AppColors.success;
      iconData = Icons.check;
    } else if (isUserSelected) {
      // 사용자가 선택한 오답인 경우 (붉은색)
      backgroundColor = AppColors.error.withOpacity(0.1);
      borderColor = AppColors.error;
      textColor = AppColors.error;
      circleColor = AppColors.error;
      iconData = Icons.close;
    } else {
      // 선택되지 않은 경우
      backgroundColor = AppColors.surface;
      borderColor = AppColors.border;
      textColor = AppColors.text;
      circleColor = AppColors.surface;
      iconData = null;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: (isSelected || isUserSelected) ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (isSelected || isUserSelected)
                ? (isSelected ? AppColors.success : AppColors.error).withOpacity(0.2)
                : AppColors.text.withOpacity(0.05),
            blurRadius: (isSelected || isUserSelected) ? 10 : 5,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                // 선택 표시 원
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: circleColor,
                    border: Border.all(
                      color: borderColor,
                      width: 2,
                    ),
                  ),
                  child: iconData != null
                      ? Icon(
                          iconData,
                          color: iconColor,
                          size: 16,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                // 옵션 텍스트
                Expanded(
                  child: Text(
                    option,
                    style: AppTextStyles.body.copyWith(
                      color: textColor,
                      fontWeight: (isSelected || isUserSelected) ? FontWeight.w600 : FontWeight.w400,
                      height: 1.3,
                      fontSize: 14,
                    ),
                    maxLines: null,
                    softWrap: true,
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