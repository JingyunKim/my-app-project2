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
  // 파스텔톤 메인 컬러
  static const Color primary = Color(0xFFB8E6B8);      // 파스텔 그린
  static const Color secondary = Color(0xFFE6B8E6);    // 파스텔 퍼플
  static const Color accent = Color(0xFFE6E6B8);       // 파스텔 옐로우
  static const Color accent2 = Color(0xFFB8E6E6);      // 파스텔 블루
  
  // 배경 및 표면 색상
  static const Color background = Color(0xFFF8F9FA);   // 연한 그레이
  static const Color surface = Color(0xFFFFFFFF);      // 화이트
  static const Color cardBackground = Color(0xFFF0F4F8); // 연한 블루 그레이
  
  // 텍스트 색상
  static const Color text = Color(0xFF2D3748);         // 다크 그레이
  static const Color textSecondary = Color(0xFF718096); // 미디엄 그레이
  static const Color textLight = Color(0xFFA0AEC0);    // 라이트 그레이
  
  // 구분선 및 보더
  static const Color divider = Color(0xFFE2E8F0);      // 연한 그레이
  static const Color border = Color(0xFFCBD5E0);       // 미디엄 그레이
  
  // 상태 색상
  static const Color success = Color(0xFF9AE6B4);      // 파스텔 그린
  static const Color error = Color(0xFFFEB2B2);        // 파스텔 레드
  static const Color warning = Color(0xFFFEEBC8);      // 파스텔 오렌지
  static const Color info = Color(0xFFBEE3F8);         // 파스텔 블루
}
