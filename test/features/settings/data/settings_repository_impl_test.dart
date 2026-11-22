import 'package:flutter_test/flutter_test.dart';
import 'package:studylink/features/settings/domain/entities/app_settings.dart';

void main() {
  test('default settings start in light English mode with reminders enabled', () {
    const settings = AppSettings();
    expect(settings.themeMode, 'light');
    expect(settings.language, 'English');
    expect(settings.notificationsEnabled, isTrue);
  });
}
