/// 문제 데이터 모델
/// 
/// 이 파일은 문제와 관련된 데이터 구조를 정의합니다.
/// 각 문제는 ID, 질문, 선택지, 정답, 해설, 그룹 정보를 포함합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "user_group.dart";

/// 문제 데이터 모델
class Question {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  final UserGroup group;

  const Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.group,
  });

  /// JSON에서 Question 객체 생성
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["id"] as String,
      question: json["question"] as String,
      options: List<String>.from(json["options"]),
      correctAnswer: json["correctAnswer"] as int,
      explanation: json["explanation"] as String,
      group: UserGroup.values.firstWhere(
        (e) => e.toString() == "UserGroup.${json["group"]}",
      ),
    );
  }

  /// Question 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question": question,
      "options": options,
      "correctAnswer": correctAnswer,
      "explanation": explanation,
      "group": group.toString().split(".").last,
    };
  }

  @override
  String toString() {
    return "Question(id: $id, question: $question, correctAnswer: $correctAnswer, group: $group)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Question && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
