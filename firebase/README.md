# StudyLink Firebase setup

The application uses Firebase Authentication and Cloud Firestore. No Firebase project credentials are included in this repository.

## Required project setup

1. Create or select the team's Firebase project.
2. Enable Email/Password sign-in in Firebase Authentication.
3. Create the Cloud Firestore database.
4. Seed the `subjects` collection and tutor profiles according to `docs/firestore_schema.md`.
5. Deploy the rules and indexes from this directory.
6. Provide the Firebase client configuration values to the Flutter build with the `--dart-define` options documented in the root README.

Do not commit service-account JSON, private keys, or real-user credentials. The public client configuration values are supplied through the build environment.

Without those project values, the application remains buildable but Firebase authentication and live Firestore operations are unavailable. The local sample records are only for UI previews and automated widget tests.
