import 'package:record/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:telepatia_ai/components/custom_app_bar.dart';
import 'package:telepatia_ai/l10n/app_localizations.dart';
import 'package:telepatia_ai/services/firebase_service.dart';
import 'package:telepatia_ai/states/recording_state/recording_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:telepatia_ai/states/uploading_state/uploading_state.dart';
import 'package:telepatia_ai/states/voice_notes_state/voice_notes_state.dart';
import 'package:telepatia_ai/utils/device.dart';
import 'package:uuid/uuid.dart';

class RecordScreen extends ConsumerStatefulWidget {
  const RecordScreen({super.key});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends ConsumerState<RecordScreen> {
  final AudioRecorder _recorder = AudioRecorder();
  final firebaseService = FirebaseService();
  final uuid = Uuid();
  String? _audioPath;

  Future<void> startRecord() async {
    try {
      if (await _recorder.hasPermission()) {
        final dir = await getTemporaryDirectory();
        final path = "${dir.path}/recording.m4a";

        await _recorder.start(
          RecordConfig(encoder: AudioEncoder.aacLc),
          path: path,
        );

        ref.read(recordingProvider.notifier).setState(true);
        setState(() => _audioPath = path);
      }
    } catch (e) {
      debugPrint("Error starting the record: $e");
    }
  }

  Future<void> stopRecord(bool isRecording) async {
    try {
      await _recorder.stop();

      if (isRecording) {
        ref.read(recordingProvider.notifier).setState(false);
        ref.read(uploadingProvider.notifier).setState(true);

        final deviceId = await getOrGenerateDeviceId();

        final url = await firebaseService.saveInBucket(
            "$deviceId/${uuid.v4()}", _audioPath!);

        await firebaseService.saveInDatabase("voice-notes", deviceId,
            {"url": url, "deviceId": deviceId, "createdAt": DateTime.now()});

        ref.invalidate(voiceNotesProvider);
        await ref.refresh(voiceNotesProvider.future);
        ref.read(uploadingProvider.notifier).setState(false);
      }
    } catch (e) {
      debugPrint("Error stopping the record: $e");
    }
  }

  void handleRecording(bool isRecording) {
    if (isRecording) {
      stopRecord(isRecording);
    } else {
      startRecord();
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = ref.watch(recordingProvider);
    final isUploading = ref.watch(uploadingProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(),
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => handleRecording(isRecording),
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(36),
                  decoration: BoxDecoration(
                    color: isRecording
                        ? colorScheme.primary
                        : colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    isRecording ? Icons.stop : Icons.mic,
                    size: 120,
                    color: isRecording
                        ? colorScheme.onPrimary
                        : colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                    isRecording
                        ? AppLocalizations.of(context)!
                            .record_button__press_to_stop
                        : AppLocalizations.of(context)!
                            .record_button__press_to_start,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center),
              )
            ],
          )),
        ),
        if (isUploading) _Uploading()
      ],
    );
  }
}

class _Uploading extends ConsumerWidget {
  const _Uploading();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned.fill(
      child: Stack(
        children: [
          ModalBarrier(
            color: Colors.black.withOpacity(0.3),
            dismissible: false,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.record_label__uploading,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: colorScheme.surface),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
