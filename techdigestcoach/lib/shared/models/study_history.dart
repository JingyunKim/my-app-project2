/// 학습 이력 모델
/// 
/// 사용자의 학습 이력을 저장하는 모델입니다.
/// 문제 풀이 결과, 날짜, 모드 등의 정보를 포함합니다.
///
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'question.dart';

/// 학습 이력 모델 클래스
class StudyHistory {
  final String id;
  final Question question;
  final bool isCorrect;
  final DateTime solvedDate;
  final bool isPracticeMode;
  final String group;
  int? examRound; // 모의고사 회차 (연습문제는 null)

  StudyHistory({
    required this.id,
    required this.question,
    required this.isCorrect,
    required this.solvedDate,
    required this.isPracticeMode,
    required this.group,
    this.examRound,
  });

  /// JSON에서 StudyHistory 객체 생성
  factory StudyHistory.fromJson(Map<String, dynamic> json) {
    print('StudyHistory 객체를 JSON에서 생성합니다.');
    return StudyHistory(
      id: json['id'] as String,
      question: Question.fromJson(json['question'] as Map<String, dynamic>),
      isCorrect: json['isCorrect'] as bool,
      solvedDate: DateTime.parse(json['solvedDate'] as String),
      isPracticeMode: json['isPracticeMode'] as bool,
      group: json['group'] as String,
      examRound: json['examRound'] as int?,
    );
  }

  /// StudyHistory 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    print('StudyHistory 객체를 JSON으로 변환합니다.');
    return {
      'id': id,
      'question': question.toJson(),
      'isCorrect': isCorrect,
      'solvedDate': solvedDate.toIso8601String(),
      'isPracticeMode': isPracticeMode,
      'group': group,
      'examRound': examRound,
    };
  }
}
