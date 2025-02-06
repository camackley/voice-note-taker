import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telepatia_ai/screens/record/record.dart';
import 'package:telepatia_ai/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) => MaterialPage(child: const HomeScreen()),
  ),
  GoRoute(
    path: '/record',
    pageBuilder: (context, state) => MaterialPage(child: const RecordScreen()),
  )
]);
