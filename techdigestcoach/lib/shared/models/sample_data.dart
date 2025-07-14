/// 샘플 데이터
/// 
/// 이 파일은 개발 및 테스트용 샘플 데이터를 정의합니다.
/// 실제 앱에서는 서버에서 데이터를 가져옵니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "question.dart";

/// 샘플 문제 데이터
final List<Question> sampleQuestions = [
  // 기존 문제들 (1-17)
  Question(
    id: "1",
    question: "다음 중 BD 관련 질문입니다?",
    type: "기본지식",
    options: [
      "A. 정답 1",
      "B. 오답 1",
      "C. 오답 2",
      "D. 오답 3",
      "E. 오답 4"
    ],
    correctAnswer: 0,
    explanation: "이것은 BD 관련 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "2",
    question: "다음 중 STAFF 관련 질문입니다?",
    type: "실무",
    options: [
      "A. 정답 1",
      "B. 오답 1",
      "C. 오답 2",
      "D. 오답 3",
      "E. 오답 4"
    ],
    correctAnswer: 0,
    explanation: "이것은 STAFF 관련 실무 지식입니다.",
    group: "staff",
  ),
  Question(
    id: "3",
    question: "BD 심화 질문입니다?",
    type: "심화",
    options: [
      "A. 정답 1",
      "B. 오답 1",
      "C. 오답 2",
      "D. 오답 3",
      "E. 오답 4"
    ],
    correctAnswer: 0,
    explanation: "이것은 BD 관련 심화 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "4",
    question: "STAFF 심화 질문입니다?",
    type: "심화",
    options: [
      "A. 정답 1",
      "B. 오답 1",
      "C. 오답 2",
      "D. 오답 3",
      "E. 오답 4"
    ],
    correctAnswer: 0,
    explanation: "이것은 STAFF 관련 심화 지식입니다.",
    group: "staff",
  ),
  Question(
    id: "5",
    question: "BD 실무 질문입니다?",
    type: "실무",
    options: [
      "A. 정답 1",
      "B. 오답 1",
      "C. 오답 2",
      "D. 오답 3",
      "E. 오답 4"
    ],
    correctAnswer: 0,
    explanation: "이것은 BD 관련 실무 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "6",
    question: "STAFF 기본 질문입니다?",
    type: "기본지식",
    options: [
      "A. 정답 1",
      "B. 오답 1",
      "C. 오답 2",
      "D. 오답 3",
      "E. 오답 4"
    ],
    correctAnswer: 0,
    explanation: "이것은 STAFF 관련 기본 지식입니다.",
    group: "staff",
  ),
  Question(
    id: "7",
    question: "임진왜란이 일어난 해는?",
    type: "테스트",
    options: [
      "A. 1592년",
      "B. 1492년",
      "C. 1392년",
      "D. 1692년",
      "E. 1792년"
    ],
    correctAnswer: 0,
    explanation: "정답은 '1592년'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "8",
    question: "세계에서 가장 긴 강은?",
    type: "테스트",
    options: [
      "A. 나일강",
      "B. 아마존강",
      "C. 양쯔강",
      "D. 한강",
      "E. 미시시피강"
    ],
    correctAnswer: 0,
    explanation: "정답은 '나일강'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "9",
    question: "Python의 주요 특징은?",
    type: "테스트",
    options: [
      "A. 인터프리터 언어",
      "B. 정적 타입",
      "C. 저수준 언어",
      "D. 오직 윈도우에서 실행",
      "E. 컴파일 필요"
    ],
    correctAnswer: 0,
    explanation: "정답은 '인터프리터 언어'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "10",
    question: "전자렌지 사용이 금지된 재질은?",
    type: "테스트",
    options: [
      "A. 알루미늄",
      "B. 유리",
      "C. 플라스틱",
      "D. 도자기",
      "E. 실리콘"
    ],
    correctAnswer: 0,
    explanation: "정답은 '알루미늄'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "11",
    question: "세계에서 가장 큰 대륙은?",
    type: "테스트",
    options: [
      "A. 아시아",
      "B. 유럽",
      "C. 아프리카",
      "D. 북아메리카",
      "E. 남아메리카"
    ],
    correctAnswer: 0,
    explanation: "정답은 '아시아'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "12",
    question: "대한민국의 수도는?",
    type: "테스트",
    options: [
      "A. 서울",
      "B. 부산",
      "C. 인천",
      "D. 대구",
      "E. 광주"
    ],
    correctAnswer: 0,
    explanation: "정답은 '서울'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "13",
    question: "HTML의 풀 네임은?",
    type: "테스트",
    options: [
      "A. HyperText Markup Language",
      "B. HighText Machine Language",
      "C. Hyper Transfer Markup Language",
      "D. Home Tool Markup Language",
      "E. Hyperlink Text Modeling Language"
    ],
    correctAnswer: 0,
    explanation: "정답은 'HyperText Markup Language'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "14",
    question: "GDP는 무엇을 측정하나?",
    type: "테스트",
    options: [
      "A. 국내 총생산",
      "B. 인구수",
      "C. 수출입량",
      "D. 실업률",
      "E. 국가 부채"
    ],
    correctAnswer: 0,
    explanation: "정답은 '국내 총생산'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "15",
    question: "빛은 어떤 경로로 움직이나?",
    type: "테스트",
    options: [
      "A. 직선",
      "B. 곡선",
      "C. 무작위",
      "D. 나선형",
      "E. 원형"
    ],
    correctAnswer: 0,
    explanation: "정답은 '직선'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "16",
    question: "축구 경기 한 팀 인원은?",
    type: "테스트",
    options: [
      "A. 11명",
      "B. 10명",
      "C. 12명",
      "D. 9명",
      "E. 13명"
    ],
    correctAnswer: 0,
    explanation: "정답은 '11명'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),
  Question(
    id: "17",
    question: "수요와 공급 법칙에서, 공급이 줄면 가격은?",
    type: "테스트",
    options: [
      "A. 오른다",
      "B. 내린다",
      "C. 변동 없다",
      "D. 사라진다",
      "E. 같다"
    ],
    correctAnswer: 0,
    explanation: "정답은 '오른다'입니다. 해당 분야의 기본 지식입니다.",
    group: "bd",
  ),

  // BD 추가 문제들 (18-50)
  Question(
    id: "18",
    question: "한국의 국화는?",
    type: "기본지식",
    options: [
      "A. 무궁화",
      "B. 장미",
      "C. 튤립",
      "D. 벚꽃",
      "E. 해바라기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '무궁화'입니다.",
    group: "bd",
  ),
  Question(
    id: "19",
    question: "지구의 위성은?",
    type: "기본지식",
    options: [
      "A. 달",
      "B. 화성",
      "C. 금성",
      "D. 목성",
      "E. 토성"
    ],
    correctAnswer: 0,
    explanation: "정답은 '달'입니다.",
    group: "bd",
  ),
  Question(
    id: "20",
    question: "물의 화학식은?",
    type: "기본지식",
    options: [
      "A. H2O",
      "B. CO2",
      "C. O2",
      "D. N2",
      "E. CH4"
    ],
    correctAnswer: 0,
    explanation: "정답은 'H2O'입니다.",
    group: "bd",
  ),
  Question(
    id: "21",
    question: "인간의 심장은 몇 개인가?",
    type: "기본지식",
    options: [
      "A. 1개",
      "B. 2개",
      "C. 3개",
      "D. 4개",
      "E. 5개"
    ],
    correctAnswer: 0,
    explanation: "정답은 '1개'입니다.",
    group: "bd",
  ),
  Question(
    id: "22",
    question: "태양계에서 가장 큰 행성은?",
    type: "기본지식",
    options: [
      "A. 목성",
      "B. 토성",
      "C. 천왕성",
      "D. 해왕성",
      "E. 지구"
    ],
    correctAnswer: 0,
    explanation: "정답은 '목성'입니다.",
    group: "bd",
  ),
  Question(
    id: "23",
    question: "DNA의 이중나선 구조를 발견한 사람은?",
    type: "기본지식",
    options: [
      "A. 왓슨과 크릭",
      "B. 아인슈타인",
      "C. 뉴턴",
      "D. 다윈",
      "E. 멘델"
    ],
    correctAnswer: 0,
    explanation: "정답은 '왓슨과 크릭'입니다.",
    group: "bd",
  ),
  Question(
    id: "24",
    question: "세계에서 가장 인구가 많은 나라는?",
    type: "기본지식",
    options: [
      "A. 중국",
      "B. 인도",
      "C. 미국",
      "D. 인도네시아",
      "E. 브라질"
    ],
    correctAnswer: 0,
    explanation: "정답은 '중국'입니다.",
    group: "bd",
  ),
  Question(
    id: "25",
    question: "지구의 대기 중 가장 많은 기체는?",
    type: "기본지식",
    options: [
      "A. 질소",
      "B. 산소",
      "C. 이산화탄소",
      "D. 수소",
      "E. 헬륨"
    ],
    correctAnswer: 0,
    explanation: "정답은 '질소'입니다.",
    group: "bd",
  ),
  Question(
    id: "26",
    question: "인간의 뼈는 몇 개인가?",
    type: "기본지식",
    options: [
      "A. 206개",
      "B. 200개",
      "C. 210개",
      "D. 195개",
      "E. 220개"
    ],
    correctAnswer: 0,
    explanation: "정답은 '206개'입니다.",
    group: "bd",
  ),
  Question(
    id: "27",
    question: "세계에서 가장 높은 산은?",
    type: "기본지식",
    options: [
      "A. 에베레스트",
      "B. K2",
      "C. 칸첸중가",
      "D. 로체",
      "E. 마칼루"
    ],
    correctAnswer: 0,
    explanation: "정답은 '에베레스트'입니다.",
    group: "bd",
  ),
  Question(
    id: "28",
    question: "지구의 자전축은 몇 도 기울어져 있나?",
    type: "기본지식",
    options: [
      "A. 23.5도",
      "B. 30도",
      "C. 45도",
      "D. 60도",
      "E. 90도"
    ],
    correctAnswer: 0,
    explanation: "정답은 '23.5도'입니다.",
    group: "bd",
  ),
  Question(
    id: "29",
    question: "인간의 혈액형 중 가장 많은 것은?",
    type: "기본지식",
    options: [
      "A. O형",
      "B. A형",
      "C. B형",
      "D. AB형",
      "E. Rh-형"
    ],
    correctAnswer: 0,
    explanation: "정답은 'O형'입니다.",
    group: "bd",
  ),
  Question(
    id: "30",
    question: "세계에서 가장 큰 바다는?",
    type: "기본지식",
    options: [
      "A. 태평양",
      "B. 대서양",
      "C. 인도양",
      "D. 북극해",
      "E. 남극해"
    ],
    correctAnswer: 0,
    explanation: "정답은 '태평양'입니다.",
    group: "bd",
  ),
  Question(
    id: "31",
    question: "지구의 표면적 중 육지의 비율은 약?",
    type: "기본지식",
    options: [
      "A. 30%",
      "B. 50%",
      "C. 70%",
      "D. 20%",
      "E. 40%"
    ],
    correctAnswer: 0,
    explanation: "정답은 '30%'입니다.",
    group: "bd",
  ),
  Question(
    id: "32",
    question: "인간의 뇌 무게는 평균 몇 kg인가?",
    type: "기본지식",
    options: [
      "A. 1.4kg",
      "B. 2kg",
      "C. 0.8kg",
      "D. 3kg",
      "E. 1kg"
    ],
    correctAnswer: 0,
    explanation: "정답은 '1.4kg'입니다.",
    group: "bd",
  ),
  Question(
    id: "33",
    question: "세계에서 가장 긴 산맥은?",
    type: "기본지식",
    options: [
      "A. 안데스산맥",
      "B. 히말라야산맥",
      "C. 알프스산맥",
      "D. 로키산맥",
      "E. 우랄산맥"
    ],
    correctAnswer: 0,
    explanation: "정답은 '안데스산맥'입니다.",
    group: "bd",
  ),
  Question(
    id: "34",
    question: "지구의 자전 주기는?",
    type: "기본지식",
    options: [
      "A. 24시간",
      "B. 12시간",
      "C. 48시간",
      "D. 36시간",
      "E. 6시간"
    ],
    correctAnswer: 0,
    explanation: "정답은 '24시간'입니다.",
    group: "bd",
  ),
  Question(
    id: "35",
    question: "인간의 근육은 몇 개인가?",
    type: "기본지식",
    options: [
      "A. 600개",
      "B. 500개",
      "C. 700개",
      "D. 400개",
      "E. 800개"
    ],
    correctAnswer: 0,
    explanation: "정답은 '600개'입니다.",
    group: "bd",
  ),
  Question(
    id: "36",
    question: "세계에서 가장 큰 섬은?",
    type: "기본지식",
    options: [
      "A. 그린란드",
      "B. 뉴기니",
      "C. 보르네오",
      "D. 마다가스카르",
      "E. 바핀섬"
    ],
    correctAnswer: 0,
    explanation: "정답은 '그린란드'입니다.",
    group: "bd",
  ),
  Question(
    id: "37",
    question: "지구의 공전 주기는?",
    type: "기본지식",
    options: [
      "A. 365일",
      "B. 360일",
      "C. 370일",
      "D. 355일",
      "E. 375일"
    ],
    correctAnswer: 0,
    explanation: "정답은 '365일'입니다.",
    group: "bd",
  ),
  Question(
    id: "38",
    question: "인간의 심장은 하루에 몇 번 뛰나?",
    type: "기본지식",
    options: [
      "A. 10만번",
      "B. 5만번",
      "C. 15만번",
      "D. 20만번",
      "E. 8만번"
    ],
    correctAnswer: 0,
    explanation: "정답은 '10만번'입니다.",
    group: "bd",
  ),
  Question(
    id: "39",
    question: "세계에서 가장 깊은 바다는?",
    type: "기본지식",
    options: [
      "A. 태평양",
      "B. 대서양",
      "C. 인도양",
      "D. 북극해",
      "E. 남극해"
    ],
    correctAnswer: 0,
    explanation: "정답은 '태평양'입니다.",
    group: "bd",
  ),
  Question(
    id: "40",
    question: "지구의 대기압은 평균 몇 기압인가?",
    type: "기본지식",
    options: [
      "A. 1기압",
      "B. 2기압",
      "C. 0.5기압",
      "D. 1.5기압",
      "E. 0.8기압"
    ],
    correctAnswer: 0,
    explanation: "정답은 '1기압'입니다.",
    group: "bd",
  ),
  Question(
    id: "41",
    question: "인간의 키는 몇 개의 뼈로 구성되어 있나?",
    type: "기본지식",
    options: [
      "A. 26개",
      "B. 24개",
      "C. 28개",
      "D. 22개",
      "E. 30개"
    ],
    correctAnswer: 0,
    explanation: "정답은 '26개'입니다.",
    group: "bd",
  ),
  Question(
    id: "42",
    question: "세계에서 가장 큰 사막은?",
    type: "기본지식",
    options: [
      "A. 사하라사막",
      "B. 고비사막",
      "C. 아라비아사막",
      "D. 칼라하리사막",
      "E. 파타고니아사막"
    ],
    correctAnswer: 0,
    explanation: "정답은 '사하라사막'입니다.",
    group: "bd",
  ),
  Question(
    id: "43",
    question: "지구의 중력은 달의 몇 배인가?",
    type: "기본지식",
    options: [
      "A. 6배",
      "B. 4배",
      "C. 8배",
      "D. 2배",
      "E. 10배"
    ],
    correctAnswer: 0,
    explanation: "정답은 '6배'입니다.",
    group: "bd",
  ),
  Question(
    id: "44",
    question: "인간의 피부는 몇 층으로 구성되어 있나?",
    type: "기본지식",
    options: [
      "A. 3층",
      "B. 2층",
      "C. 4층",
      "D. 5층",
      "E. 1층"
    ],
    correctAnswer: 0,
    explanation: "정답은 '3층'입니다.",
    group: "bd",
  ),
  Question(
    id: "45",
    question: "세계에서 가장 큰 호수는?",
    type: "기본지식",
    options: [
      "A. 카스피해",
      "B. 수피리어호",
      "C. 빅토리아호",
      "D. 훌론호",
      "E. 탕가니카호"
    ],
    correctAnswer: 0,
    explanation: "정답은 '카스피해'입니다.",
    group: "bd",
  ),
  Question(
    id: "46",
    question: "지구의 평균 온도는 섭씨 몇 도인가?",
    type: "기본지식",
    options: [
      "A. 15도",
      "B. 20도",
      "C. 10도",
      "D. 25도",
      "E. 5도"
    ],
    correctAnswer: 0,
    explanation: "정답은 '15도'입니다.",
    group: "bd",
  ),
  Question(
    id: "47",
    question: "인간의 치아는 평균 몇 개인가?",
    type: "기본지식",
    options: [
      "A. 32개",
      "B. 28개",
      "C. 30개",
      "D. 26개",
      "E. 34개"
    ],
    correctAnswer: 0,
    explanation: "정답은 '32개'입니다.",
    group: "bd",
  ),
  Question(
    id: "48",
    question: "세계에서 가장 긴 강은?",
    type: "기본지식",
    options: [
      "A. 나일강",
      "B. 아마존강",
      "C. 양쯔강",
      "D. 미시시피강",
      "E. 옐로우강"
    ],
    correctAnswer: 0,
    explanation: "정답은 '나일강'입니다.",
    group: "bd",
  ),
  Question(
    id: "49",
    question: "지구의 대기 중 산소 비율은?",
    type: "기본지식",
    options: [
      "A. 21%",
      "B. 15%",
      "C. 25%",
      "D. 30%",
      "E. 18%"
    ],
    correctAnswer: 0,
    explanation: "정답은 '21%'입니다.",
    group: "bd",
  ),
  Question(
    id: "50",
    question: "인간의 뇌는 체중의 몇 %를 차지하나?",
    type: "기본지식",
    options: [
      "A. 2%",
      "B. 5%",
      "C. 1%",
      "D. 3%",
      "E. 4%"
    ],
    correctAnswer: 0,
    explanation: "정답은 '2%'입니다.",
    group: "bd",
  ),

  // STAFF 추가 문제들 (51-83)
  Question(
    id: "51",
    question: "사무실에서 가장 중요한 것은?",
    type: "실무",
    options: [
      "A. 협력",
      "B. 경쟁",
      "C. 독립",
      "D. 고립",
      "E. 무관심"
    ],
    correctAnswer: 0,
    explanation: "정답은 '협력'입니다.",
    group: "staff",
  ),
  Question(
    id: "52",
    question: "업무 효율성을 높이는 방법은?",
    type: "실무",
    options: [
      "A. 계획 수립",
      "B. 즉흥적 처리",
      "C. 미루기",
      "D. 무시하기",
      "E. 포기하기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '계획 수립'입니다.",
    group: "staff",
  ),
  Question(
    id: "53",
    question: "동료와의 소통에서 중요한 것은?",
    type: "실무",
    options: [
      "A. 경청",
      "B. 독백",
      "C. 무시",
      "D. 중단",
      "E. 회피"
    ],
    correctAnswer: 0,
    explanation: "정답은 '경청'입니다.",
    group: "staff",
  ),
  Question(
    id: "54",
    question: "업무 스트레스 해소법은?",
    type: "실무",
    options: [
      "A. 휴식",
      "B. 과로",
      "C. 무시",
      "D. 포기",
      "E. 회피"
    ],
    correctAnswer: 0,
    explanation: "정답은 '휴식'입니다.",
    group: "staff",
  ),
  Question(
    id: "55",
    question: "회의에서 중요한 것은?",
    type: "실무",
    options: [
      "A. 준비",
      "B. 즉흥",
      "C. 무시",
      "D. 지연",
      "E. 취소"
    ],
    correctAnswer: 0,
    explanation: "정답은 '준비'입니다.",
    group: "staff",
  ),
  Question(
    id: "56",
    question: "업무 마감 시간을 지키는 것은?",
    type: "실무",
    options: [
      "A. 중요",
      "B. 불필요",
      "C. 선택사항",
      "D. 무시해도됨",
      "E. 상관없음"
    ],
    correctAnswer: 0,
    explanation: "정답은 '중요'입니다.",
    group: "staff",
  ),
  Question(
    id: "57",
    question: "동료의 실수를 발견했을 때?",
    type: "실무",
    options: [
      "A. 친절히 알려주기",
      "B. 비난하기",
      "C. 무시하기",
      "D. 고발하기",
      "E. 회피하기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '친절히 알려주기'입니다.",
    group: "staff",
  ),
  Question(
    id: "58",
    question: "업무 환경에서 가장 중요한 것은?",
    type: "실무",
    options: [
      "A. 안전",
      "B. 속도",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '안전'입니다.",
    group: "staff",
  ),
  Question(
    id: "59",
    question: "업무 보고서 작성 시 중요한 것은?",
    type: "실무",
    options: [
      "A. 정확성",
      "B. 속도",
      "C. 추측",
      "D. 무시",
      "E. 회피"
    ],
    correctAnswer: 0,
    explanation: "정답은 '정확성'입니다.",
    group: "staff",
  ),
  Question(
    id: "60",
    question: "동료와의 갈등 해결 방법은?",
    type: "실무",
    options: [
      "A. 대화",
      "B. 회피",
      "C. 무시",
      "D. 고발",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '대화'입니다.",
    group: "staff",
  ),
  Question(
    id: "61",
    question: "업무 시간 관리에서 중요한 것은?",
    type: "실무",
    options: [
      "A. 우선순위",
      "B. 즉흥",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '우선순위'입니다.",
    group: "staff",
  ),
  Question(
    id: "62",
    question: "업무 성과 향상을 위한 방법은?",
    type: "실무",
    options: [
      "A. 학습",
      "B. 무시",
      "C. 회피",
      "D. 포기",
      "E. 중단"
    ],
    correctAnswer: 0,
    explanation: "정답은 '학습'입니다.",
    group: "staff",
  ),
  Question(
    id: "63",
    question: "동료와의 신뢰 구축 방법은?",
    type: "실무",
    options: [
      "A. 약속 지키기",
      "B. 무시하기",
      "C. 회피하기",
      "D. 포기하기",
      "E. 중단하기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '약속 지키기'입니다.",
    group: "staff",
  ),
  Question(
    id: "64",
    question: "업무 중 실수를 했을 때?",
    type: "실무",
    options: [
      "A. 인정하고 수정",
      "B. 숨기기",
      "C. 무시하기",
      "D. 회피하기",
      "E. 포기하기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '인정하고 수정'입니다.",
    group: "staff",
  ),
  Question(
    id: "65",
    question: "업무 환경 개선을 위해 필요한 것은?",
    type: "실무",
    options: [
      "A. 의견 제시",
      "B. 무시",
      "C. 회피",
      "D. 포기",
      "E. 중단"
    ],
    correctAnswer: 0,
    explanation: "정답은 '의견 제시'입니다.",
    group: "staff",
  ),
  Question(
    id: "66",
    question: "동료와의 업무 분담 시 중요한 것은?",
    type: "실무",
    options: [
      "A. 공정성",
      "B. 편애",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '공정성'입니다.",
    group: "staff",
  ),
  Question(
    id: "67",
    question: "업무 중 집중력을 높이는 방법은?",
    type: "실무",
    options: [
      "A. 휴식",
      "B. 과로",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '휴식'입니다.",
    group: "staff",
  ),
  Question(
    id: "68",
    question: "업무 스킬 향상을 위한 방법은?",
    type: "실무",
    options: [
      "A. 연습",
      "B. 무시",
      "C. 회피",
      "D. 포기",
      "E. 중단"
    ],
    correctAnswer: 0,
    explanation: "정답은 '연습'입니다.",
    group: "staff",
  ),
  Question(
    id: "69",
    question: "동료와의 정보 공유 시 중요한 것은?",
    type: "실무",
    options: [
      "A. 정확성",
      "B. 추측",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '정확성'입니다.",
    group: "staff",
  ),
  Question(
    id: "70",
    question: "업무 중 문제 해결 방법은?",
    type: "실무",
    options: [
      "A. 분석",
      "B. 추측",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '분석'입니다.",
    group: "staff",
  ),
  Question(
    id: "71",
    question: "업무 환경에서의 예의는?",
    type: "실무",
    options: [
      "A. 중요",
      "B. 불필요",
      "C. 선택사항",
      "D. 무시해도됨",
      "E. 상관없음"
    ],
    correctAnswer: 0,
    explanation: "정답은 '중요'입니다.",
    group: "staff",
  ),
  Question(
    id: "72",
    question: "동료와의 업무 협력 시 중요한 것은?",
    type: "실무",
    options: [
      "A. 소통",
      "B. 독립",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '소통'입니다.",
    group: "staff",
  ),
  Question(
    id: "73",
    question: "업무 중 스트레스 관리 방법은?",
    type: "실무",
    options: [
      "A. 운동",
      "B. 과식",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '운동'입니다.",
    group: "staff",
  ),
  Question(
    id: "74",
    question: "업무 성과 평가에서 중요한 것은?",
    type: "실무",
    options: [
      "A. 객관성",
      "B. 주관성",
      "C. 편애",
      "D. 무시",
      "E. 회피"
    ],
    correctAnswer: 0,
    explanation: "정답은 '객관성'입니다.",
    group: "staff",
  ),
  Question(
    id: "75",
    question: "동료와의 업무 분쟁 해결 방법은?",
    type: "실무",
    options: [
      "A. 중재",
      "B. 편들기",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '중재'입니다.",
    group: "staff",
  ),
  Question(
    id: "76",
    question: "업무 중 안전 수칙은?",
    type: "실무",
    options: [
      "A. 필수",
      "B. 선택",
      "C. 불필요",
      "D. 무시해도됨",
      "E. 상관없음"
    ],
    correctAnswer: 0,
    explanation: "정답은 '필수'입니다.",
    group: "staff",
  ),
  Question(
    id: "77",
    question: "업무 환경 개선을 위한 제안은?",
    type: "실무",
    options: [
      "A. 환영",
      "B. 거부",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '환영'입니다.",
    group: "staff",
  ),
  Question(
    id: "78",
    question: "동료와의 업무 공유 시 중요한 것은?",
    type: "실무",
    options: [
      "A. 투명성",
      "B. 은폐",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '투명성'입니다.",
    group: "staff",
  ),
  Question(
    id: "79",
    question: "업무 중 혁신을 위한 자세는?",
    type: "실무",
    options: [
      "A. 개방적",
      "B. 보수적",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '개방적'입니다.",
    group: "staff",
  ),
  Question(
    id: "80",
    question: "업무 환경에서의 리더십은?",
    type: "실무",
    options: [
      "A. 중요",
      "B. 불필요",
      "C. 선택사항",
      "D. 무시해도됨",
      "E. 상관없음"
    ],
    correctAnswer: 0,
    explanation: "정답은 '중요'입니다.",
    group: "staff",
  ),
  Question(
    id: "81",
    question: "동료와의 업무 협조 시 중요한 것은?",
    type: "실무",
    options: [
      "A. 상호존중",
      "B. 지배",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '상호존중'입니다.",
    group: "staff",
  ),
  Question(
    id: "82",
    question: "업무 중 전문성 향상 방법은?",
    type: "실무",
    options: [
      "A. 지속학습",
      "B. 정체",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '지속학습'입니다.",
    group: "staff",
  ),
  Question(
    id: "83",
    question: "업무 환경에서의 변화 대응은?",
    type: "실무",
    options: [
      "A. 적응",
      "B. 저항",
      "C. 무시",
      "D. 회피",
      "E. 포기"
    ],
    correctAnswer: 0,
    explanation: "정답은 '적응'입니다.",
    group: "staff",
  ),
];
