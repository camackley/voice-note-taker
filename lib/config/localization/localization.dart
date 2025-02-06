import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../l10n/app_localizations.dart';

final defaultLocale = Locale('en');
final supportedLocales = AppLocalizations.supportedLocales;
final localizationsDelegates = <LocalizationsDelegate<dynamic>>[
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
