/// 사용자 모델
/// 
/// 이 파일은 사용자 정보를 정의합니다.
/// 닉네임, 그룹, 마지막 로그인 날짜를 포함합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "user_group.dart";

/// 사용자 모델
class User {
  final String nickname;
  final UserGroup group;
  final DateTime lastLoginDate;

  const User({
    required this.nickname,
    required this.group,
    required this.lastLoginDate,
  });

  /// JSON에서 User 객체 생성
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nickname: json["nickname"] as String,
      group: UserGroup.values.firstWhere(
        (e) => e.toString() == "UserGroup.${json["group"]}",
      ),
      lastLoginDate: DateTime.parse(json["lastLoginDate"] as String),
    );
  }

  /// User 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "nickname": nickname,
      "group": group.toString().split(".").last,
      "lastLoginDate": lastLoginDate.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "User(nickname: $nickname, group: $group, lastLoginDate: $lastLoginDate)";
  }
}
