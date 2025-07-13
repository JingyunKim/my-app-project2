/// TechDigestCoach 앱의 메인 진입점
/// 
/// 이 파일은 Flutter 앱의 시작점으로, 앱의 기본 구조와 테마를 정의합니다.
/// 현재는 기본 카운터 앱 구조를 가지고 있으며, 향후 학습용 앱으로 확장될 예정입니다.
/// 
/// 작성자: 개발팀
/// 작성일: 2024
/// 버전: 1.0.0

import 'package:flutter/material.dart';

/// 앱의 메인 진입점
void main() {
  print('TechDigestCoach 앱이 시작됩니다.');
  runApp(const MyApp());
}

/// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// 앱의 기본 구조와 테마를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('MyApp build 메소드가 호출되었습니다.');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/// 홈페이지 위젯
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  /// 상태 객체를 생성하는 메소드
  @override
  State<MyHomePage> createState() {
    print('MyHomePage createState 메소드가 호출되었습니다.');
    return _MyHomePageState();
  }
}

/// 홈페이지의 상태를 관리하는 클래스
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  /// 카운터 값을 증가시키는 메소드
  void _incrementCounter() {
    print('카운터가 증가됩니다. 현재 값: $_counter');
    setState(() {
      _counter++;
    });
    print('카운터 증가 완료. 새로운 값: $_counter');
  }

  /// 홈페이지 UI를 구성하는 메소드
  @override
  Widget build(BuildContext context) {
    print('MyHomePage build 메소드가 호출되었습니다. 카운터 값: $_counter');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
