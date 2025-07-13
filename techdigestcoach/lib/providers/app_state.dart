/// 앱 상태 관리 Provider
/// 
/// 사용자 정보, 학습 이력, 선택된 과목을 관리합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/foundation.dart';

// 모델 import
import '../shared/models/user.dart';
import '../shared/models/user_group.dart';
import '../shared/models/study_history.dart';

/// 앱 상태 관리 클래스
class AppState extends ChangeNotifier {
  User? _currentUser;
  UserGroup _selectedGroup = UserGroup.bd;
  final List<StudyHistory> _studyHistory = [];

  /// 현재 사용자 getter
  User? get currentUser => _currentUser;

  /// 선택된 과목 getter
  UserGroup get selectedGroup => _selectedGroup;

  /// 학습 이력 getter
  List<StudyHistory> get studyHistory => List.unmodifiable(_studyHistory);

  /// 사용자 로그인 처리 메소드
  void loginUser(String nickname) {
    print("사용자 로그인: $nickname");
    _currentUser = User(
      nickname: nickname,
      group: _selectedGroup,
      lastLoginDate: DateTime.now(),
    );
    notifyListeners();
  }

  /// 과목 선택 처리 메소드
  void selectGroup(UserGroup group) {
    print("과목 선택: $group");
    _selectedGroup = group;
    notifyListeners();
  }

  /// 학습 이력 추가 메소드
  void addHistory(StudyHistory history) {
    print("학습 이력 추가: ${history.questionId}");
    _studyHistory.add(history);
    notifyListeners();
  }

  /// 학습 이력 초기화 메소드
  void clearHistory() {
    print("학습 이력 초기화");
    _studyHistory.clear();
    notifyListeners();
  }

  /// 모든 데이터 초기화 메소드
  void resetData() {
    print("모든 데이터 초기화");
    _currentUser = null;
    _selectedGroup = UserGroup.bd;
    _studyHistory.clear();
    notifyListeners();
  }

  /// 닉네임 변경 메소드
  void updateNickname(String newNickname) {
    print("닉네임 변경: $newNickname");
    if (_currentUser != null) {
      _currentUser = User(
        nickname: newNickname,
        group: _currentUser!.group,
        lastLoginDate: _currentUser!.lastLoginDate,
      );
      notifyListeners();
    }
  }
}
