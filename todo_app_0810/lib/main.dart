import 'package:flutter/material.dart';
import 'package:todo_app_0810/todo_inline.dart';

//  앱 진입점: MainApp 위젯 실행
void main() => runApp(const MainApp());

//  앱 전체를 감싸는 MaterialApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO Inline',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.lime),
      home: const TodoInlinePage(),
    );
  }
}
