/// 문제 모델
/// 
/// 문제의 기본 정보를 담고 있는 모델입니다.
/// id, 문제 내용, 보기, 정답, 해설 등을 포함합니다.
class Question {
  final String id;
  final String question;
  final String type;  // 추가된 필드
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  final String group;

  Question({
    required this.id,
    required this.question,
    required this.type,  // 추가된 필드
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
      type: json["type"] as String, // 추가된 필드
      options: List<String>.from(json["options"]),
      correctAnswer: json["correctAnswer"] as int,
      explanation: json["explanation"] as String,
      group: json["group"] as String, // 변경된 필드
    );
  }

  /// Question 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question": question,
      "type": type, // 추가된 필드
      "options": options,
      "correctAnswer": correctAnswer,
      "explanation": explanation,
      "group": group, // 변경된 필드
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
