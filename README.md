# StudyLink — Peer Tutoring Booking App

StudyLink is a Flutter mobile application that helps ALU students find peer tutors, choose an available 45-minute session, book a time and rate a completed session.

The active implementation uses **Riverpod** for shared application state, **GoRouter** for navigation, **Firebase Authentication** for accounts and **Cloud Firestore** for subjects, tutor profiles, availability, bookings and ratings. There is no BLoC/Cubit implementation in the active app.

## Implemented screens

- Sign In and Sign Up
- Home
- Search Subjects
- Tutor Results and no-results state
- Tutor Profile
- Available Time Slots
- Booking Confirmation
- My Sessions
- Session Details
- Rate Session
- Cancel Session confirmation sheet

The screen layout and colour tokens continue to follow the supplied StudyLink Figma prototype. Navigation keeps the selected tutor and session IDs so details, cancellation and rating actions target the correct records.

## Main user flow

1. Sign in or create an account.
2. Search active subjects.
3. Choose a tutor matching the subject.
4. View available time slots and select a meeting mode.
5. Confirm the booking. A Firestore transaction checks and reserves the slot while creating the session record.
6. View upcoming and past sessions.
7. Open the exact session, cancel it if it is still confirmed, or rate it once it is completed.

## Requirements

- Flutter stable with Dart 3.6+
- Android Studio and Android SDK for Android builds
- A Firebase project for live authentication and Firestore data

## Local setup

```bash
flutter pub get
flutter run
```

If a generated Android project is missing:

```bash
flutter create --platforms=android --org com.studylink --project-name studylink .
```

## Firebase setup

The repository intentionally does not contain Firebase credentials. Configure a Firebase project, enable Email/Password sign-in, create Firestore, seed the required collections and deploy the security rules/indexes.

Run the app with the Firebase client values supplied from the team's project:

```bash
flutter run \
  --dart-define=FIREBASE_API_KEY=YOUR_API_KEY \
  --dart-define=FIREBASE_APP_ID=YOUR_APP_ID \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=YOUR_SENDER_ID \
  --dart-define=FIREBASE_PROJECT_ID=YOUR_PROJECT_ID \
  --dart-define=FIREBASE_STORAGE_BUCKET=YOUR_STORAGE_BUCKET
```

These are Firebase client configuration values, not service-account credentials. Do not commit service-account JSON or private keys. With no Firebase values, the application remains buildable and uses sample records for UI previews/tests, but live sign-in and remote data operations are unavailable.

See [Firebase setup](firebase/README.md) and [Firestore schema](docs/firestore_schema.md).

## Quality checks

```bash
dart format .
flutter analyze
flutter test --coverage
flutter build apk --debug
```

GitHub Actions runs formatting verification, analysis, tests and an Android debug build. A successful CI run uploads `studylink-debug-apk` as a workflow artifact.

## Repository structure

```text
lib/
  app/
    app.dart
    data/study_link_repository.dart
    router/app_router.dart
    state/study_link_controller.dart
  core/
    config/firebase_config.dart
    models/study_link_models.dart
    theme/
  features/
    auth/
      data/auth_repository.dart
      presentation/pages/
    home/
      presentation/pages/
      presentation/widgets/
    tutors/
      presentation/pages/
      presentation/widgets/
    booking/
      presentation/pages/
    sessions/
      presentation/pages/
  shared/widgets/
test/
integration_test/
docs/
firebase/
```

## Known limitations

- The team must provide its Firebase project configuration before live authentication and Firestore operations can be used.
- Production Firestore data must be seeded using the documented schema, and the backend team must validate the security rules against its final schema.
- Tutor availability, sessions and ratings depend on the backend records being populated with the required fields.
- The repository's Figma source could not be loaded in the current review environment. Final pixel-by-pixel verification must be completed against the team's accessible Figma file on target devices.
- A device-recorded demo video and screenshots must be captured from the running app for final submission.

## Future work

- Add Google sign-in if required by the project brief.
- Add tutor-side availability management and session completion workflows.
- Add live updates for availability and session status.
- Add profile editing, notifications and rescheduling.
- Add automated screenshot comparisons against approved Figma frames.

## Contribution

See [CONTRIBUTING.md](CONTRIBUTING.md) for branch and review conventions.
