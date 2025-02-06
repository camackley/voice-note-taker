import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'VoiceNote Tacker';

  @override
  String get home__empty_stage => 'Record your first Voice Note';

  @override
  String get record_button__press_to_start => 'Press to record the voice note';

  @override
  String get record_button__press_to_stop => 'Press to stop the voice note';

  @override
  String get record_label__uploading => 'Saving voice note';
}
