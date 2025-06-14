# 1단계 실습 후 코드 생성 명령어 안내

아래 명령어를 터미널에서 실행해 freezed, json_serializable 관련 코드를 자동 생성하세요.

```
flutter pub run build_runner build --delete-conflicting-outputs
```

- 이 명령어는 *.freezed.dart, *.g.dart 파일을 생성합니다.
- 모델/상태 정의가 변경될 때마다 재실행해야 합니다.
