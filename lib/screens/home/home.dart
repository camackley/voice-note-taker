import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telepatia_ai/components/custom_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: CustomAppBar(),
        body: Text('Home Screen', style: Theme.of(context).textTheme.displayLarge),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.mic),
          onPressed: () => context.push('/record'),
        )
    );
  }
}
