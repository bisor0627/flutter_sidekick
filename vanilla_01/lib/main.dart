import 'package:flutter/material.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateless vs Stateful',
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(body: Playground()),
    );
  }
}

/// Playground: Stateless 와 Stateful 차이를 한눈에 비교
class Playground extends StatefulWidget {
  const Playground({super.key});

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  int _parentCounter = 0;

  void _incrementParent() => setState(() => _parentCounter++);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ① StatelessCounter – 부모 상태만 표시 가능
              Column(
                children: [
                  const Text('Stateless'),
                  StatelessCounter(value: _parentCounter),
                ],
              ),
              // ② StatefulCounter – 자체 상태를 가짐
              Column(
                children: [const Text('Stateful'), const StatefulCounter()],
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _incrementParent,
            label: const Text('_parentCounter'),
          ),
        ],
      ),
    );
  }
}

/// StatelessCounter: 값만 받아 표시 (자체적으로 변경 불가)
class StatelessCounter extends StatelessWidget {
  final int value;

  const StatelessCounter({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$value', style: Theme.of(context).textTheme.displayLarge),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('value는 final로 선언되어 변경할 수 없습니다.')),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

/// StatefulCounter: 내부 상태를 보유하고 직접 변경
class StatefulCounter extends StatefulWidget {
  const StatefulCounter({super.key});

  @override
  State<StatefulCounter> createState() => _StatefulCounterState();
}

class _StatefulCounterState extends State<StatefulCounter> {
  int _value = 0;

  void _increment() => setState(() => _value++);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_value', style: Theme.of(context).textTheme.displayLarge),
        IconButton(onPressed: _increment, icon: const Icon(Icons.add)),
      ],
    );
  }
}
