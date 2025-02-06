import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recording_state.g.dart';

@riverpod
class Recording extends _$Recording {
  @override
  bool build() {
    return false;
  }

  void setState(bool newState) {
    state = newState;
  }
}