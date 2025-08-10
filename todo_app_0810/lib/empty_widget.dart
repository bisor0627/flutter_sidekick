//  빈 리스트 상태 위젯
part of 'todo_inline.dart';

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('할 일이 없습니다.\n상단 입력칸에서 추가해 보세요.', textAlign: TextAlign.center),
    );
  }
}
