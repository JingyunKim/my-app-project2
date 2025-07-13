/// 사용자 모델 정의
/// 
/// 사용자 정보를 담는 모델입니다.
/// 닉네임, 과목, 마지막 로그인 날짜를 포함합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'user_group.dart';

/// 사용자 모델 클래스
class User {
  final String nickname;
  final UserGroup group;
  final DateTime lastLoginDate;

  /// 사용자 모델 생성자
  const User({
    required this.nickname,
    required this.group,
    required this.lastLoginDate,
  });
}
