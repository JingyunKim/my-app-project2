/// 샘플 데이터
/// 
/// 이 파일은 개발 및 테스트용 샘플 데이터를 정의합니다.
/// 실제 앱에서는 서버에서 데이터를 가져옵니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "question.dart";
import "user_group.dart";

/// 임시 문제 데이터
final List<Question> sampleQuestions = [
  Question(
    id: "1",
    question: "다음 중 올바른 설명은?",
    options: [
      "A. 임시 보기 1",
      "B. 임시 보기 2",
      "C. 임시 보기 3",
      "D. 임시 보기 4",
      "E. 임시 보기 5",
    ],
    correctAnswer: 2,
    explanation: "정답은 C입니다. 임시 해설입니다.",
    group: UserGroup.bd,
  ),
  Question(
    id: "2",
    question: "다음 설명 중 틀린 것은?",
    options: [
      "A. 임시 보기 1",
      "B. 임시 보기 2",
      "C. 임시 보기 3",
      "D. 임시 보기 4",
      "E. 임시 보기 5",
    ],
    correctAnswer: 4,
    explanation: "정답은 D입니다. 임시 해설입니다.",
    group: UserGroup.staff,
  ),
];
