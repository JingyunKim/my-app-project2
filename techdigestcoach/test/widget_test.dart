/// TechDigestCoach 앱의 위젯 테스트 파일
/// 
/// 이 파일은 앱의 기본 위젯들이 올바르게 동작하는지 테스트합니다.
/// 현재는 카운터 앱의 기본 기능을 테스트하며, 향후 학습용 앱 기능으로 확장될 예정입니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:techdigestcoach/main.dart';

/// 위젯 테스트의 메인 진입점
void main() {
  /// 카운터 증가 기능을 테스트하는 메소드
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    print('카운터 증가 테스트가 시작됩니다.');
    
    print('앱을 빌드하고 프레임을 트리거합니다.');
    await tester.pumpWidget(const MyApp());

    print('카운터가 0에서 시작하는지 확인합니다.');
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    print('+ 아이콘을 탭하고 프레임을 트리거합니다.');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    print('카운터가 증가했는지 확인합니다.');
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    
    print('카운터 증가 테스트가 완료되었습니다.');
  });
}
