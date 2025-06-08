import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [MyWidget(), MyWidget2()],
        ),
      ),
    );
  }
}

final textProvider = StateProvider((ref) => 'Hello, World!');

class MyWidget2 extends StatelessWidget {
  MyWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var text = ref.watch(textProvider);

        return Center(
          child: Column(
            children: [
              Text(text),
              ElevatedButton(
                onPressed: () {
                  ref.read(textProvider.notifier).state = 'Hello, Riverpod!';
                },
                child: const Text('Press me'),
              ),
            ],
          ),
        );
      },
    );
  }
}

//---
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String foo = 'Hello, World!';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(foo),
          ElevatedButton(onPressed: test, child: const Text('Press me')),
        ],
      ),
    );
  }

  void test() {
    setState(() {
      foo = 'Hello, Riverpod!';
    });
  }
}
