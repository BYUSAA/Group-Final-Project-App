# Setup

Install Flutter stable, Android Studio / Android SDK, and Xcode on macOS for iOS. Generate native host runners when they are absent:

```bash
flutter create --platforms=android,ios --org com.studylink --project-name studylink .
flutter pub get
flutter run
```

Without Firebase client config, StudyLink starts in local demo mode. Use any email ending in `@alustudent.com` and a password of at least eight characters.

For Firebase: register Android/iOS apps, enable Email/Password and Google providers, create Firestore, then run `firebase login`, `dart pub global activate flutterfire_cli`, `flutterfire configure`, `firebase use --add`, and `firebase deploy --only firestore:rules,firestore:indexes,storage`. Seed subjects, tutors and tutor slot documents. Do not commit service-account keys or generated project-specific Firebase config.

Run `dart format .`, `flutter analyze`, `flutter test` and `flutter build apk --debug` before submission.
