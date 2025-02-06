import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'uploading_state.g.dart';

@riverpod
class Uploading extends _$Uploading {
  @override
  bool build() {
    return false;
  }

  void setState(bool newState) {
    state = newState;
  }
}