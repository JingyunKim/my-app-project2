/// 학습 이력 모델
/// 
/// 이 파일은 학습 이력을 정의합니다.
/// 문제 ID, 정답 여부, 해결 날짜, 모드를 포함합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'user_group.dart';

/// 학습 이력 모델
class StudyHistory {
  final String questionId;
  final bool isCorrect;
  final DateTime solvedDate;
  final bool isPracticeMode;
  final UserGroup group;

  const StudyHistory({
    required this.questionId,
    required this.isCorrect,
    required this.solvedDate,
    required this.isPracticeMode,
    required this.group,
  });

  /// JSON에서 StudyHistory 객체 생성
  factory StudyHistory.fromJson(Map<String, dynamic> json) {
    return StudyHistory(
      questionId: json["questionId"] as String,
      isCorrect: json["isCorrect"] as bool,
      solvedDate: DateTime.parse(json["solvedDate"] as String),
      isPracticeMode: json["isPracticeMode"] as bool,
      group: UserGroup.values.firstWhere((e) => e.toString() == json["group"]),
    );
  }

  /// StudyHistory 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "isCorrect": isCorrect,
      "solvedDate": solvedDate.toIso8601String(),
      "isPracticeMode": isPracticeMode,
      "group": group.toString(),
    };
  }

  @override
  String toString() {
    return "StudyHistory(questionId: $questionId, isCorrect: $isCorrect, solvedDate: $solvedDate, isPracticeMode: $isPracticeMode, group: $group)";
  }
}
