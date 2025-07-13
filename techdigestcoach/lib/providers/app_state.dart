/// 앱 상태 관리
/// 
/// 이 파일은 앱의 전역 상태를 관리합니다.
/// 사용자 정보, 학습 이력, 선택된 그룹을 관리합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../shared/models/user.dart";
import "../shared/models/study_history.dart";
import "../shared/models/user_group.dart";

/// 앱의 상태를 관리하는 클래스
class AppState extends ChangeNotifier {
  User? _currentUser;
  List<StudyHistory> _history = [];
  UserGroup? _selectedGroup;

  User? get currentUser => _currentUser;
  List<StudyHistory> get history => _history;
  UserGroup? get selectedGroup => _selectedGroup;

  /// 사용자 로그인 처리 메소드
  Future<void> login(String nickname) async {
    print("사용자 로그인: $nickname");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nickname", nickname);
    _currentUser = User(
      nickname: nickname,
      group: UserGroup.bd, // 초기값, 나중에 선택
      lastLoginDate: DateTime.now(),
    );
    notifyListeners();
  }

  /// 그룹 선택 처리 메소드
  void selectGroup(UserGroup group) {
    print("그룹 선택: $group");
    _selectedGroup = group;
    notifyListeners();
  }

  /// 학습 이력 추가 메소드
  void addHistory(StudyHistory history) {
    print("학습 이력 추가: ${history.questionId}");
    _history.add(history);
    notifyListeners();
  }
}
