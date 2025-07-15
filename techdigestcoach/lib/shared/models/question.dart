/// 문제 모델
/// 
/// 연습문제와 모의고사에서 사용되는 문제의 데이터 모델입니다.
/// 문제 내용, 정답, 해설 등의 정보를 포함합니다.
///
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

/// 문제 모델 클래스
class Question {
  final String id;
  final String content;
  final String question;
  final String type;
  final List<String> options;
  final int correctAnswer;
  final bool answer;
  final String explanation;
  final DateTime createdAt;
  final String group;
  final bool isExamQuestion;

  Question({
    required this.id,
    required this.content,
    this.question = '',
    this.type = '',
    this.options = const [],
    this.correctAnswer = -1,
    required this.answer,
    required this.explanation,
    required this.createdAt,
    required this.group,
    this.isExamQuestion = false,
  });

  /// JSON에서 Question 객체 생성
  factory Question.fromJson(Map<String, dynamic> json) {
    print('Question 객체를 JSON에서 생성합니다.');
    return Question(
      id: json['id'] as String,
      content: json['content'] as String,
      question: json['question'] as String? ?? '',
      type: json['type'] as String? ?? '',
      options: (json['options'] as List<dynamic>?)?.cast<String>() ?? [],
      correctAnswer: json['correctAnswer'] as int? ?? -1,
      answer: json['answer'] as bool,
      explanation: json['explanation'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      group: json['group'] as String,
      isExamQuestion: json['isExamQuestion'] as bool? ?? false,
    );
  }

  /// Question 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    print('Question 객체를 JSON으로 변환합니다.');
    return {
      'id': id,
      'content': content,
      'question': question,
      'type': type,
      'options': options,
      'correctAnswer': correctAnswer,
      'answer': answer,
      'explanation': explanation,
      'createdAt': createdAt.toIso8601String(),
      'group': group,
      'isExamQuestion': isExamQuestion,
    };
  }
}
