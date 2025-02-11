import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:telepatia_ai/config/config.dart';
import 'package:telepatia_ai/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  return runApp(
    const ProviderScope(
      child: SafeArea(child: MyApp()),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'VoiceNote Taker',
      debugShowCheckedModeBanner: false,
      locale: defaultLocale,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      routerConfig: appRouter,
      theme: AppTheme(context: context, isDarkMode: false).getTheme(),
    );
  }
}
