/// 틀린 문제 다시 풀기 화면
/// 
/// 연습문제나 모의고사에서 틀린 문제들을 다시 풀어볼 수 있는 화면입니다.
/// 문제를 하나씩 보여주고 답을 선택하면 즉시 정답을 확인할 수 있습니다.
///
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../providers/app_state.dart';
import '../../../shared/models/question.dart';

/// 틀린 문제 다시 풀기 화면 위젯
class WrongAnswersScreen extends StatefulWidget {
  final List<Question> wrongQuestions;
  final String title;

  const WrongAnswersScreen({
    super.key,
    required this.wrongQuestions,
    required this.title,
  });

  @override
  State<WrongAnswersScreen> createState() => _WrongAnswersScreenState();
}

class _WrongAnswersScreenState extends State<WrongAnswersScreen> {
  int _currentIndex = 0;
  late List<int?> _answers;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    print('틀린 문제 다시 풀기 화면을 초기화합니다.');
    _answers = List.filled(widget.wrongQuestions.length, null);
  }

  /// 답변 선택 처리 메소드
  void _handleAnswer(int answer) {
    print('답변이 선택되었습니다: $answer');
    setState(() {
      _answers[_currentIndex] = answer;
      _showAnswer = true;
    });
  }

  /// 다음 문제로 이동하는 메소드
  void _nextQuestion() {
    print('다음 문제로 이동합니다.');
    if (_currentIndex < widget.wrongQuestions.length - 1) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    }
  }

  /// 이전 문제로 이동하는 메소드
  void _previousQuestion() {
    print('이전 문제로 이동합니다.');
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _showAnswer = false;
        _answers[_currentIndex] = null; // 이전 문제의 답안 초기화
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.wrongQuestions[_currentIndex];
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.title,
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
              '${_currentIndex + 1}/${widget.wrongQuestions.length}',
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
                value: (_currentIndex + 1) / widget.wrongQuestions.length,
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
                                  text: 'Q${_currentIndex + 1}. ',
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
                          isUserSelected: _answers[_currentIndex] == index && _answers[_currentIndex] != question.correctAnswer,
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
                          color: _answers[_currentIndex] == question.correctAnswer
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _answers[_currentIndex] == question.correctAnswer
                                ? AppColors.success.withOpacity(0.3)
                                : AppColors.error.withOpacity(0.3),
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
                                    color: _answers[_currentIndex] == question.correctAnswer
                                        ? AppColors.success
                                        : AppColors.error,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    _answers[_currentIndex] == question.correctAnswer
                                        ? Icons.check
                                        : Icons.close,
                                    color: AppColors.surface,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _answers[_currentIndex] == question.correctAnswer
                                      ? '정답입니다!'
                                      : '틀렸습니다.',
                                  style: AppTextStyles.subtitle.copyWith(
                                    color: _answers[_currentIndex] == question.correctAnswer
                                        ? AppColors.success
                                        : AppColors.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '정답: ${question.options[question.correctAnswer]}',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.text,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
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
                    // 이전 버튼
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _currentIndex > 0 ? _previousQuestion : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
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
                            Icon(Icons.arrow_back_ios, size: 16),
                            const SizedBox(width: 8),
                            Text('이전', style: AppTextStyles.button),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 다음 버튼
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _currentIndex < widget.wrongQuestions.length - 1 ? _nextQuestion : () {
                          // 마지막 문제에서는 다시 풀기 종료
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentIndex < widget.wrongQuestions.length - 1 
                              ? AppColors.primary 
                              : AppColors.error,
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
                            Text(
                              _currentIndex < widget.wrongQuestions.length - 1 ? '다음' : '다시 풀기 종료',
                              style: AppTextStyles.button,
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              _currentIndex < widget.wrongQuestions.length - 1 
                                  ? Icons.arrow_forward_ios 
                                  : Icons.check,
                              size: 16,
                            ),
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