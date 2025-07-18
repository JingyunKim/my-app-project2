/// 모의고사 모드 화면
/// 
/// 사용자가 실제 시험 환경에서 30문제를 45분 안에 풀 수 있는 모의고사 모드 화면입니다.
/// 타이머 기능과 진행률 표시, 답안 선택 기능을 제공합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

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

// 화면 import
import 'exam_result_screen.dart';

/// 모의고사 모드 화면 위젯
class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  static const int totalQuestions = 10;
  static const int timeLimit = 20; // 20분

  late List<Question> _questions;
  int _currentQuestionIndex = 0;
  late List<int?> _userAnswers;
  int _remainingSeconds = timeLimit * 60;
  Timer? _timer;
  bool _isExamFinished = false;

  @override
  void initState() {
    super.initState();
    print('ExamScreen initState 호출');
    _initializeExam();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// 시험 초기화 메소드
  void _initializeExam() {
    print('모의고사 초기화');
    final userGroup = context.read<AppState>().selectedGroup;
    final groupQuestions = sampleQuestions.where((q) => 
      (userGroup == UserGroup.bd && q.group == "bd") || 
      (userGroup == UserGroup.staff && q.group == "staff")
    ).toList()..shuffle();
    _questions = groupQuestions.take(totalQuestions).toList();
    _userAnswers = List.filled(totalQuestions, null);
  }

  /// 타이머 시작 메소드
  void _startTimer() {
    print('타이머 시작');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _finishExam();
        }
      });
    });
  }

  /// 답안 선택 처리 메소드
  void _handleAnswer(int selectedAnswer) {
    print('선택한 답안: $selectedAnswer');
    setState(() {
      _userAnswers[_currentQuestionIndex] = selectedAnswer;
    });
  }

  /// 다음 문제로 이동하는 메소드
  void _nextQuestion() {
    print('다음 문제로 이동');
    setState(() {
      if (_currentQuestionIndex < totalQuestions - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  /// 이전 문제로 이동하는 메소드
  void _previousQuestion() {
    print('이전 문제로 이동');
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  /// 시험 종료 처리 메소드
  void _finishExam() {
    print('시험 종료');
    _timer?.cancel();
    setState(() {
      _isExamFinished = true;
    });

    // 모의고사 이력 생성
    final List<StudyHistory> examHistories = [];
    for (var i = 0; i < _questions.length; i++) {
      if (_userAnswers[i] != null) {
        examHistories.add(StudyHistory(
          id: 'exam_${DateTime.now().millisecondsSinceEpoch}_$i',
          question: _questions[i],
          group: (_questions[i].group == "bd" ? UserGroup.bd : UserGroup.staff).toString(),
          isCorrect: _userAnswers[i] == _questions[i].correctAnswer,
          solvedDate: DateTime.now(),
          isPracticeMode: false,
        ));
      }
    }

    // 모의고사 완료 처리 (회차 정보 포함)
    context.read<AppState>().completeExam(examHistories);

    // 결과 화면으로 이동
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ExamResultScreen(
          questions: _questions,
          userAnswers: _userAnswers,
          timeSpent: timeLimit * 60 - _remainingSeconds,
        ),
      ),
    );
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    print('ExamScreen build 메소드 호출');
    
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
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '시험을 준비하는 중...',
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
    final userAnswer = _userAnswers[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '모의고사',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        actions: [
          // 타이머 표시
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _remainingSeconds < 300 
                  ? AppColors.error.withOpacity(0.1)
                  : AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _remainingSeconds < 300 
                    ? AppColors.error.withOpacity(0.3)
                    : AppColors.secondary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: _remainingSeconds < 300 
                      ? AppColors.error
                      : AppColors.secondary,
                ),
                const SizedBox(width: 6),
                Text(
                  _formattedTime,
                  style: AppTextStyles.caption.copyWith(
                    color: _remainingSeconds < 300 
                        ? AppColors.error
                        : AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '진행률',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${_currentQuestionIndex + 1}/$totalQuestions',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / totalQuestions,
                    backgroundColor: AppColors.divider,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
                    minHeight: 8,
                  ),
                ],
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
                          Row(
                            children: [
                              Text(
                                'Q${_currentQuestionIndex + 1}.',
                                style: AppTextStyles.subtitle.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            question.question,
                            style: AppTextStyles.heading.copyWith(
                              color: AppColors.text,
                              fontSize: 18,
                              height: 1.5,
                            ),
                            maxLines: null,
                            softWrap: true,
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
                          isSelected: userAnswer == index,
                          onTap: () => _handleAnswer(index),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 이전/다음/제출 버튼
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
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('모의고사 종료'),
                              content: const Text('이번 모의고사 기록은 저장되지 않습니다. 정말 종료하시겠습니까?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('아니오'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text('예'),
                                ),
                              ],
                            ),
                          );
                          if (result == true) {
                            Navigator.of(context).pop();
                          }
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
                            Text('모의고사 종료', style: AppTextStyles.button),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (_currentQuestionIndex < totalQuestions - 1)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _userAnswers[_currentQuestionIndex] != null ? _nextQuestion : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _userAnswers[_currentQuestionIndex] != null 
                                ? AppColors.secondary 
                                : AppColors.secondary.withOpacity(0.3),
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
                      )
                    else
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _userAnswers[_currentQuestionIndex] != null ? _finishExam : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _userAnswers[_currentQuestionIndex] != null 
                                ? AppColors.error 
                                : AppColors.error.withOpacity(0.3),
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
                              Icon(Icons.check_circle_outline, size: 16),
                              const SizedBox(width: 8),
                              Text('제출하기', style: AppTextStyles.button),
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
  final VoidCallback onTap;

  const _AnswerOption({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondary.withOpacity(0.1) : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? AppColors.secondary : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected 
                ? AppColors.secondary.withOpacity(0.2)
                : AppColors.text.withOpacity(0.05),
            blurRadius: isSelected ? 10 : 5,
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 선택 표시 원
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.secondary : AppColors.surface,
                    border: Border.all(
                      color: isSelected ? AppColors.secondary : AppColors.border,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: AppColors.surface,
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
                      color: isSelected ? AppColors.secondary : AppColors.text,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
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