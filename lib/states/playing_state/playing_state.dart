import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playing_state.g.dart';

@riverpod
class Playing extends _$Playing {
  @override
  String? build() {
    return null;
  }

  void setPlayingId(String? id) {
    state = id;
  }
}

@riverpod
class Player extends _$Player {
  @override
  AudioPlayer build() {
    final player = AudioPlayer();

    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        ref.read(playingProvider.notifier).setPlayingId(null);
      }
    });

    return player;
  }

  void play(String id, String audioUrl, WidgetRef ref) async {
    final playingId = ref.read(playingProvider);

    if (playingId != id) {
      state.pause();
      ref.read(playingProvider.notifier).setPlayingId(null);
      return;
    }

    state.pause();

    if (audioUrl.isNotEmpty) {
      try {
        await state.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
        state.play();
        ref.read(playingProvider.notifier).setPlayingId(id);
      } catch (e) {
        debugPrint("Error al reproducir el audio: $e");
      }
    }
  }
}
