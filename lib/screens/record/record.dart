import 'package:record/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:telepatia_ai/components/custom_app_bar.dart';
import 'package:telepatia_ai/l10n/app_localizations.dart';
import 'package:telepatia_ai/states/recording_state/recording_state.dart';
import 'package:path_provider/path_provider.dart';

class RecordScreen extends ConsumerStatefulWidget {
  const RecordScreen({super.key});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends ConsumerState<RecordScreen> {
  final AudioRecorder _recorder = AudioRecorder();
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

  Future<void> stopRecord() async {
    try {
      await _recorder.stop();
      ref.read(recordingProvider.notifier).setState(false);
    } catch (e) {
      debugPrint("Error stopping the record: $e");
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onLongPressDown: (_) => startRecord(),
            onLongPressUp: () => stopRecord(),
            onLongPressCancel: () => stopRecord(),
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
                Icons.mic,
                size: isRecording ? 150 : 120,
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
                AppLocalizations.of(context)!.record_button__press_and_hold,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
          )
        ],
      )),
    );
  }
}
