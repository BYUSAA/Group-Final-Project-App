import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  const AppSettings({
    this.themeMode = 'light',
    this.language = 'English',
    this.notificationsEnabled = true,
  });
  final String themeMode;
  final String language;
  final bool notificationsEnabled;

  AppSettings copyWith({String? themeMode, String? language, bool? notificationsEnabled}) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    language: language ?? this.language,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
  );

  @override
  List<Object?> get props => [themeMode, language, notificationsEnabled];
}
