# StudyLink — UI and Navigation Implementation Report

**Role:** Member 3 — UI and Navigation  
**Application:** StudyLink peer tutoring booking app  
**Framework:** Flutter / Dart  
**State management:** Riverpod  
**Navigation:** GoRouter  
**Backend integration:** Firebase Authentication and Cloud Firestore

## 1. Project overview

StudyLink supports ALU students who need help with course topics by enabling them to discover peer tutors, select available time slots, book a 45-minute session and provide feedback after a completed session. The Member 3 implementation focuses on the mobile user interface, reusable widgets, navigation, selected-record state and the presentation of loading and error states.

## 2. Implemented functionality

The user journey begins with Sign In or Sign Up. Authentication is handled through Firebase Email/Password when the team's Firebase project values are configured. A student can search the active subject catalogue, view matching tutors, open a tutor profile and inspect open availability. The booking operation reserves the selected slot and creates a session document through a Firestore transaction.

The My Sessions page separates upcoming from past sessions. Each session opens its own details route using a session ID. Cancellation updates only the selected confirmed session and releases its linked slot. Rating is submitted against the selected completed session and is limited to one rating per session.

The interface retains the approved StudyLink design direction: warm neutral surfaces, deep green primary actions, mint selection states, beige avatars and gold rating accents. Shared components reduce repeated button, card, avatar, loading, empty-state and navigation styling.

## 3. Architecture and navigation

Riverpod manages shared application state. GoRouter handles screen navigation and short fade/slide transitions. The active UI does not use BLoC, Cubit or `setState()` for shared application state. Firebase services are kept behind repositories so page widgets do not write directly to Firestore.

The main route sequence is:

1. Sign In / Sign Up
2. Home
3. Search Subjects
4. Tutor Results
5. Tutor Profile
6. Available Time Slots
7. Booking Confirmation
8. My Sessions
9. Session Details
10. Rate Session

## 4. Error handling

The interface provides a no-tutors empty state, no-open-slots message, loading indicators and readable messages for authentication and data errors. Booking failures preserve the current tutor and booking selection. If a slot is unavailable at confirmation time, the Firestore transaction aborts and the student is asked to choose another slot.

## 5. Testing and verification

Automated tests cover the booking controller, unavailable-slot state preservation, session-specific cancellation, session-specific rating, sign-in navigation and compact screen layout. GitHub Actions runs Dart formatting verification, Flutter analysis, tests and an Android debug build.

GitHub Actions run 44971975951 passed Dart formatting verification, `flutter analyze`, `flutter test --coverage` (9 tests), `flutter build apk --debug`, and APK artifact upload. The uploaded artifact is named `studylink-debug-apk` and is available from the run page: https://github.com/BYUSAA/Group-Final-Project-App/actions/runs/44971975951. Manual device testing remains necessary for all screens, large and small phone dimensions, landscape rotation, accessibility and exact Figma comparison.

## 6. Known limitations

- The team's real Firebase client configuration values are not stored in this repository. They must be supplied through the documented Dart defines.
- Firestore must be seeded with subjects, tutor profiles and availability records before live search and booking can return real data.
- The backend team must verify that its deployed collection names and field names match the schema in `docs/firestore_schema.md`.
- The Figma prototype did not load in the automated review environment, so pixel-by-pixel visual verification is not yet certified.
- The Android runner, Gradle wrapper JAR and wrapper scripts have been generated and committed to the `byusa-work` branch. A release-signed APK still requires team-managed signing configuration.
- Device screenshots and the required demonstration video must be captured from a running Android build.

## 7. Future work

Recommended improvements include live Firestore streams for session and availability updates, tutor-side availability management, rescheduling, notifications, profile editing, Google sign-in if required, and automated screenshot comparison against the approved Figma frames.

## 8. References

1. Flutter documentation, *Flutter documentation*. https://docs.flutter.dev/
2. Riverpod documentation, *Riverpod*. https://riverpod.dev/
3. GoRouter documentation, *Navigation and routing*. https://pub.dev/packages/go_router
4. Firebase documentation, *Firebase Authentication for Flutter*. https://firebase.google.com/docs/auth/flutter/start
5. Firebase documentation, *Cloud Firestore for Flutter*. https://firebase.google.com/docs/firestore/quickstart
6. W3C, *Web Content Accessibility Guidelines (WCAG) 2.2*. https://www.w3.org/TR/WCAG22/
7. StudyLink approved Figma prototype, supplied in the project brief.
