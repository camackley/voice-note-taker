import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telepatia_ai/services/firebase_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telepatia_ai/utils/device.dart';

part 'voice_notes_state.g.dart';

@riverpod
Future<List<Map<String, dynamic>>> voiceNotes(Ref ref) async {
  final firebaseService = FirebaseService();
  final docId = await getOrGenerateDeviceId();

  return await firebaseService.readSubCollection(
      'voice-notes', docId, 'files');
}
