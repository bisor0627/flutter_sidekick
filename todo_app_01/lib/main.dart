// main.dart
// ------------------------------
// 앱 진입점 및 ProviderScope 설정
// ------------------------------
//
// - ProviderScope로 Riverpod 상태 관리의 루트 컨텍스트를 제공합니다.
// - MyApp은 MaterialApp을 감싸고, TodoScreen을 홈으로 지정합니다.
// - CS 관점: 의존성 주입(Dependency Injection)과 상태 공유를 위한 최상위 ProviderScope 구조는
//   대규모 앱에서 테스트 용이성과 확장성을 높입니다.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/todo/presentation/todo_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'TODO App', home: TodoScreen());
  }
}
