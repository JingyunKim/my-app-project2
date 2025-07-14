/// TechDigestCoach 앱의 텍스트 스타일 정의
/// 
/// 이 파일은 앱에서 사용하는 모든 텍스트 스타일을 정의합니다.
/// 일관된 타이포그래피 시스템을 제공합니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import "package:flutter/material.dart";
import "app_colors.dart";

/// 앱의 텍스트 스타일 정의
class AppTextStyles {
  // 배민체 폰트 패밀리
  static const String _fontFamily = 'BMDOHYEON';
  
  static TextStyle get title => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    letterSpacing: -0.5,
  );
  
  static TextStyle get heading => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    letterSpacing: -0.3,
  );
  
  static TextStyle get subtitle => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  
  static TextStyle get body => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.5,
  );
  
  static TextStyle get caption => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get button => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.surface,
    letterSpacing: 0.5,
  );
}
