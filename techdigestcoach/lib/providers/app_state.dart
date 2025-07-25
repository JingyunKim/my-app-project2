/// 앱 상태 관리 Provider
/// 
/// 사용자 정보, 학습 이력, 선택된 과목을 관리합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 모델 import
import '../shared/models/user.dart';
import '../shared/models/user_group.dart';
import '../shared/models/study_history.dart';
import '../shared/models/question.dart';

/// 앱 상태 관리 클래스
class AppState extends ChangeNotifier {
  static const String _userKey = 'user';
  static const String _groupKey = 'group';
  static const String _historyKey = 'history';
  static const String _examRoundKey = 'examRound';

  User? _currentUser;
  UserGroup _selectedGroup = UserGroup.bd;
  final List<StudyHistory> _studyHistory = [];
  int _examRound = 0;

  AppState() {
    _loadState();
  }

  /// 상태 로드 메소드
  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 사용자 정보 로드
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      _currentUser = User(
        nickname: userMap['nickname'],
        group: UserGroup.values[userMap['group']],
        lastLoginDate: DateTime.parse(userMap['lastLoginDate']),
      );
    }

    // 선택된 과목 로드
    final groupIndex = prefs.getInt(_groupKey);
    if (groupIndex != null) {
      _selectedGroup = UserGroup.values[groupIndex];
    }

    // 모의고사 회차 로드
    _examRound = prefs.getInt(_examRoundKey) ?? 0;

    // 학습 이력 로드
    final historyJson = prefs.getString(_historyKey);
    if (historyJson != null) {
      try {
        final List<dynamic> historyList = json.decode(historyJson);
        _studyHistory.clear();
        for (final item in historyList) {
          try {
            final questionData = item['question'] as Map<String, dynamic>?;
            if (questionData != null) {
              final question = Question.fromJson(questionData);
              _studyHistory.add(StudyHistory(
                id: item['id'] ?? 'legacy_${DateTime.now().millisecondsSinceEpoch}',
                question: question,
                group: item['group'] ?? 'bd',
                isCorrect: item['isCorrect'] ?? false,
                solvedDate: DateTime.parse(item['solvedDate']),
                isPracticeMode: item['isPracticeMode'] ?? false,
                examRound: item['examRound'],
              ));
            }
          } catch (e) {
            print('잘못된 학습 이력 데이터를 건너뜁니다: $e');
            // 잘못된 데이터는 건너뛰고 계속 진행
          }
        }
      } catch (e) {
        print('학습 이력 로드 중 오류 발생: $e');
        // 전체 로드 실패 시 빈 리스트로 초기화
        _studyHistory.clear();
      }
    }

    notifyListeners();
  }

  /// 상태 저장 메소드
  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 사용자 정보 저장
    if (_currentUser != null) {
      final userMap = {
        'nickname': _currentUser!.nickname,
        'group': _currentUser!.group.index,
        'lastLoginDate': _currentUser!.lastLoginDate.toIso8601String(),
      };
      await prefs.setString(_userKey, json.encode(userMap));
    } else {
      await prefs.remove(_userKey);
    }

    // 선택된 과목 저장
    await prefs.setInt(_groupKey, _selectedGroup.index);

    // 모의고사 회차 저장
    await prefs.setInt(_examRoundKey, _examRound);

    // 학습 이력 저장
    final historyList = _studyHistory.map((history) => {
      'id': history.id,
      'question': history.question.toJson(),
      'group': history.group,
      'isCorrect': history.isCorrect,
      'solvedDate': history.solvedDate.toIso8601String(),
      'isPracticeMode': history.isPracticeMode,
      'examRound': history.examRound,
    }).toList();
    await prefs.setString(_historyKey, json.encode(historyList));
  }

  /// 현재 사용자 getter
  User? get currentUser => _currentUser;

  /// 선택된 과목 getter
  UserGroup get selectedGroup => _selectedGroup;

  /// 학습 이력 getter
  List<StudyHistory> get studyHistory => List.unmodifiable(_studyHistory);

  /// 모의고사 회차 getter
  int get examRound => _examRound;

  /// 사용자 로그인 처리 메소드
  Future<void> loginUser(String nickname) async {
    print("사용자 로그인: $nickname");
    _currentUser = User(
      nickname: nickname,
      group: _selectedGroup,
      lastLoginDate: DateTime.now(),
    );
    await _saveState();
    notifyListeners();
  }

  /// 과목 선택 처리 메소드
  Future<void> selectGroup(UserGroup group) async {
    print("과목 선택: $group");
    _selectedGroup = group;
    if (_currentUser != null) {
      _currentUser = User(
        nickname: _currentUser!.nickname,
        group: group,
        lastLoginDate: DateTime.now(),
      );
    }
    await _saveState();
    notifyListeners();
  }

  /// 학습 이력 추가 메소드
  Future<void> addHistory(StudyHistory history) async {
    print("학습 이력 추가: ${history.question.question}");
    _studyHistory.add(history);
    await _saveState();
    notifyListeners();
  }

  /// 모의고사 완료 처리 메소드
  Future<void> completeExam(List<StudyHistory> examHistories) async {
    print("모의고사 완료: ${_examRound + 1}회차");
    _examRound++;
    
    // 모의고사 회차 정보를 각 문제에 추가
    for (final history in examHistories) {
      history.examRound = _examRound;
      _studyHistory.add(history);
    }
    
    await _saveState();
    notifyListeners();
  }

  /// 학습 이력 초기화 메소드
  Future<void> clearHistory() async {
    print("학습 이력 초기화");
    _studyHistory.clear();
    _examRound = 0;
    await _saveState();
    notifyListeners();
  }

  /// 모든 데이터 초기화 메소드
  Future<void> resetData() async {
    print("모든 데이터 초기화");
    _currentUser = null;
    _selectedGroup = UserGroup.bd;
    _studyHistory.clear();
    _examRound = 0;
    await _saveState();
    notifyListeners();
  }

  /// 닉네임 변경 메소드
  Future<void> updateNickname(String newNickname) async {
    print("닉네임 변경: $newNickname");
    if (_currentUser != null) {
      _currentUser = User(
        nickname: newNickname,
        group: _currentUser!.group,
        lastLoginDate: DateTime.now(),
      );
      await _saveState();
      notifyListeners();
    }
  }
}
