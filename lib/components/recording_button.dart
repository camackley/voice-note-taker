import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telepatia_ai/l10n/app_localizations.dart';

import 'package:telepatia_ai/states/recording_state/recording_state.dart';

class RecordButton extends ConsumerWidget {
  const RecordButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording = ref.watch(recordingProvider);

    Widget recordingButton() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Recording...'),
          Text(
            AppLocalizations.of(context)!.record_button__slide_to_cancel,
            style: Theme.of(context).textTheme.titleMedium
          ),
          Icon(Icons.mic),
        ],
      );
    }

    return GestureDetector(
      onTap: () => ref.read(recordingProvider.notifier).setState(true),
      child: Container(
        height: 60,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFE9D5FF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: isRecording ? recordingButton() : Icon(Icons.mic),
      ),
    );
  }
}
