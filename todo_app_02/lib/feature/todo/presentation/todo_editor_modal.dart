import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodoEditorResult {
  const TodoEditorResult.create(this.title) : id = null;
  const TodoEditorResult.update(this.id, this.title);
  final String? id;
  final String title;
}

Future<TodoEditorResult?> showTodoEditorModal(
  BuildContext context, {
  Todo? initial,
}) {
  return showModalBottomSheet<TodoEditorResult>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _TodoEditorSheet(initial: initial),
  );
}

class _TodoEditorSheet extends StatefulWidget {
  const _TodoEditorSheet({required this.initial});
  final Todo? initial;

  @override
  State<_TodoEditorSheet> createState() => _TodoEditorSheetState();
}

class _TodoEditorSheetState extends State<_TodoEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title = TextEditingController(
    text: widget.initial?.title ?? '',
  );

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit ? 'TODO 수정' : '새 TODO',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _title,
                  autofocus: true,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: '제목',
                    hintText: '할 일을 입력하세요',
                  ),
                  validator: (v) {
                    final s = (v ?? '').trim();
                    if (s.isEmpty) return '제목을 입력하세요';
                    if (s.length < 2) return '2자 이상 입력하세요';
                    return null;
                  },
                  onFieldSubmitted: (_) => _submit(isEdit),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('취소'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () => _submit(isEdit),
                      child: Text(isEdit ? '저장' : '추가'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(bool isEdit) {
    if (_formKey.currentState?.validate() != true) return;
    final title = _title.text.trim();
    if (isEdit) {
      Navigator.pop(
        context,
        TodoEditorResult.update(widget.initial!.id, title),
      );
    } else {
      Navigator.pop(context, TodoEditorResult.create(title));
    }
  }
}
