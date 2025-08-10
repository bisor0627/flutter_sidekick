import 'package:flutter/material.dart';
import 'package:todo_app_0810/todo.dart';
import 'package:uuid/uuid.dart';

part 'empty_widget.dart';

//  메인 화면 위젯 (Stateful)
class TodoInlinePage extends StatefulWidget {
  const TodoInlinePage({super.key});
  @override
  State<TodoInlinePage> createState() => _TodoInlinePageState();
}

class _TodoInlinePageState extends State<TodoInlinePage> {
  // uuid 생성기, 입력 컨트롤러, 할 일 리스트
  final _uuid = const Uuid();
  final List<Todo> _todos = [];
  late final TextEditingController _input;

  @override
  void initState() {
    super.initState();
    //  입력 컨트롤러 초기화
    _input = TextEditingController();
  }

  @override
  void dispose() {
    //  입력 컨트롤러 해제
    _input.dispose();
    super.dispose();
  }

  /// 완료 상태 토글 함수
  void _toggle(String id) {
    setState(() {
      final i = _todos.indexWhere((t) => t.id == id);
      if (i >= 0) _todos[i] = _todos[i].copyWith(isDone: !_todos[i].isDone);
    });
  }

  /// 할 일 삭제 함수
  void _remove(String id) {
    setState(() => _todos.removeWhere((t) => t.id == id));
  }

  /// 제목 수정 함수
  void _update(String id, String title) {
    setState(() {
      final i = _todos.indexWhere((t) => t.id == id);
      if (i >= 0) _todos[i] = _todos[i].copyWith(title: title.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    //  화면 UI 빌드: 입력창, 리스트, 빈 상태

    return Scaffold(
      appBar: AppBar(title: const Text('TODO')),
      floatingActionButton: FloatingActionButton(
        tooltip: '할 일 추가',
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return EditPage(input: _input);
            },
          );
          print('모달 결과: $result');
          if (result == null || result.isEmpty) return; // 입력값이 없으면
          //  할 일 추가
          setState(() {
            _todos.add(
              Todo(id: _uuid.v4(), title: _input.text.trim(), isDone: false),
            );
            _input.clear(); // 입력창 비우기
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          //  할 일 리스트 영역
          Expanded(
            child: _todos.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      //  Dismissible: 스와이프 삭제
                      return Dismissible(
                        key: ValueKey('todo-${todo.id}'),
                        background: _swipeBg(left: true),
                        secondaryBackground: _swipeBg(left: false),
                        onDismissed: (_) => _remove(todo.id),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            //  완료 토글 버튼
                            leading: IconButton(
                              tooltip: todo.isDone ? '미완료로 전환' : '완료로 전환',
                              icon: Icon(
                                todo.isDone
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: todo.isDone ? Colors.green : null,
                              ),
                              onPressed: () => _toggle(todo.id),
                            ),
                            title: Text(todo.title),
                            //  제목 수정 버튼
                            trailing: IconButton(
                              tooltip: '할 일 수정',
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final result = await showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    _input.text = todo.title; // 입력창에 현재 제목 설정
                                    return EditPage(input: _input);
                                  },
                                );
                                if (result == null || result.isEmpty) return;
                                // Todo 수정
                                _update(todo.id, result.toString());
                                _input.clear(); // 입력창 비우기
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// Dismissible 배경 위젯 (삭제 아이콘)
  Widget _swipeBg({required bool left}) => Container(
    alignment: left ? Alignment.centerLeft : Alignment.centerRight,
    padding: EdgeInsets.only(left: left ? 16 : 0, right: left ? 0 : 16),
    color: Colors.red,
    child: const Icon(Icons.delete, color: Colors.white),
  );
}

enum PageState { add, update }

///  할 일 추가/수정 모달 페이지
/// Navigation을 통해 모달로 띄워지는 페이지
/// 입력값을 받아서 추가/수정 기능을 수행
/// .pop 으로 결과값을 반환
/// [TextEditingController]에 [value]가 있으면 수정 상태로 간주
class EditPage extends StatelessWidget {
  const EditPage({super.key, required this.input});

  final TextEditingController input;

  PageState get state {
    if (input.text.isEmpty) {
      return PageState.add; // 입력값이 없으면 추가 상태
    } else {
      return PageState.update; // 입력값이 있으면 수정 상태
    }
  }

  Widget get _header {
    switch (state) {
      case PageState.add:
        return const Text('할 일 추가');
      case PageState.update:
        return const Text('할 일 수정');
    }
  }

  Widget get _buttonText {
    switch (state) {
      case PageState.add:
        return const Text('추가');
      case PageState.update:
        return const Text('수정');
    }
  }

  @override
  Widget build(BuildContext context) {
    var children = [
      //  모달 헤더
      _header,
      TextFormField(controller: input),
      TextButton(
        onPressed: () {
          if (input.text.isEmpty) return;
          Navigator.pop(context, input.text); // 모달 닫기
        },
        child: _buttonText,
      ),
    ];
    return Scaffold(body: Column(children: children));
  }
}
