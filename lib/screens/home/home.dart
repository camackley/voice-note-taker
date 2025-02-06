import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:telepatia_ai/components/custom_app_bar.dart';
import 'package:telepatia_ai/states/playing_state/playing_state.dart';
import 'package:telepatia_ai/states/voice_notes_state/voice_notes_state.dart';

import '../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void handlePlaying(Map<String, dynamic> item, WidgetRef ref) async {
    final url = item['url'];
    final id = item['id'];

    ref.read(playingProvider.notifier).setPlayingId(id);
    ref.read(playerProvider.notifier).play(id, url, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final voiceNotes = ref.watch(voiceNotesProvider);
    final playingItem = ref.watch(playingProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: voiceNotes.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
          data: (items) => items.isEmpty
              ? Center(
                  child: Text(AppLocalizations.of(context)!.home__empty_stage))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: IconButton(
                            icon: Icon(item['id'] == playingItem
                                ? Icons.pause
                                : Icons.play_arrow),
                            onPressed: () => handlePlaying(item, ref)),
                        title: Text(DateFormat('yyyy-MM-dd HH:mm')
                            .format((item['createdAt'] as Timestamp).toDate())),
                        onTap: () => handlePlaying(item, ref),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.mic),
        onPressed: () => context.push('/record'),
      ),
    );
  }
}
