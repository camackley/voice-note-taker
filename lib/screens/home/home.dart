import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telepatia_ai/components/recording_button.dart';
import 'package:telepatia_ai/l10n/app_localizations.dart';
import 'package:telepatia_ai/states/recording_state/recording_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isRecording = ref.watch(recordingProvider); 

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.appName,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ),
          backgroundColor: colorScheme.surface,
        ),
        body: Text('Home Screen', style: Theme.of(context).textTheme.displayLarge),
        floatingActionButtonLocation: isRecording
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
        floatingActionButton: RecordButton() 
      ),
    );
  }
}
