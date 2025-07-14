/// TechDigestCoach 앱의 색상 정의
/// 
/// 이 파일은 앱에서 사용하는 모든 색상을 정의합니다.
/// 파스텔톤 기반의 현대적인 색상 시스템을 제공합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "package:flutter/material.dart";

/// 앱의 색상 정의
class AppColors {
  // BD 과목용 파스텔 블루 계열 메인 컬러
  static const Color primary = Color(0xFF3B82F6);      // 파스텔 파란색
  static const Color secondary = Color(0xFF1E40AF);    // 파스텔 진한 파란색
  static const Color accent = Color(0xFF60A5FA);       // 파스텔 밝은 파란색
  static const Color accent2 = Color(0xFF93C5FD);      // 파스텔 연한 파란색
  
  // STAFF 과목용 파스텔 초록색 계열 컬러
  static const Color staffPrimary = Color(0xFF10B981);    // 파스텔 초록색
  static const Color staffSecondary = Color(0xFF059669);  // 파스텔 진한 초록색
  static const Color staffAccent = Color(0xFF34D399);     // 파스텔 밝은 초록색
  static const Color staffAccent2 = Color(0xFF6EE7B7);    // 파스텔 연한 초록색
  
  // 배경 및 표면 색상 (회색 계열)
  static const Color background = Color(0xFFECEFF4);   // 조금 더 짙은 연회색
  static const Color surface = Color(0xFFF3F4F8);      // 살짝 더 진한 회색
  static const Color cardBackground = Color(0xFFF1F5F9); // 연한 회색
  
  // 텍스트 색상 (회색 계열)
  static const Color text = Color(0xFF1E293B);         // 진한 회색
  static const Color textSecondary = Color(0xFF64748B); // 중간 회색
  static const Color textLight = Color(0xFF94A3B8);    // 연한 회색
  
  // 구분선 및 보더 (회색 계열)
  static const Color divider = Color(0xFFE2E8F0);      // 연한 회색
  static const Color border = Color(0xFFCBD5E1);       // 중간 회색
  
  // 상태 색상 (블루 계열 기반)
  static const Color success = Color(0xFF10B981);      // 초록색
  static const Color error = Color(0xFFEF4444);        // 빨간색
  static const Color warning = Color(0xFFF59E0B);      // 주황색
  static const Color info = Color(0xFF3B82F6);         // 파란색
}
