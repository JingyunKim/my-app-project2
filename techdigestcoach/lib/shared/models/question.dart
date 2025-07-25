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
  final String question;
  final String type;
  final List<String> options;
  final int correctAnswer;
  final bool answer;
  final String explanation;
  final DateTime createdAt;
  final String group;
  final String difficulty;
  final int score;
  final String topic;
  final String title;
  final String intent;
  final String reference;

  Question({
    required this.id,
    required this.question,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.answer,
    required this.explanation,
    required this.createdAt,
    required this.group,
    required this.difficulty,
    required this.score,
    required this.topic,
    required this.title,
    required this.intent,
    required this.reference,
  });

  /// JSON에서 Question 객체 생성
  factory Question.fromJson(Map<String, dynamic> json) {
    print('Question 객체를 JSON에서 생성합니다.');
    return Question(
      id: json['id'] as String,
      question: json['question'] as String,
      type: json['type'] as String,
      options: (json['options'] as List<dynamic>).cast<String>(),
      correctAnswer: json['correctAnswer'] as int,
      answer: json['answer'] as bool,
      explanation: json['explanation'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      group: json['group'] as String,
      difficulty: json['difficulty'] as String,
      score: json['score'] as int,
      topic: json['topic'] as String,
      title: json['title'] as String,
      intent: json['intent'] as String,
      reference: json['reference'] as String,
    );
  }

  /// Question 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    print('Question 객체를 JSON으로 변환합니다.');
    return {
      'id': id,
      'question': question,
      'type': type,
      'options': options,
      'correctAnswer': correctAnswer,
      'answer': answer,
      'explanation': explanation,
      'createdAt': createdAt.toIso8601String(),
      'group': group,
      'difficulty': difficulty,
      'score': score,
      'topic': topic,
      'title': title,
      'intent': intent,
      'reference': reference,
    };
  }
}
