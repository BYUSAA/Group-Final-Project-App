# Architecture and data flow

Each feature separates domain entities/contracts/use cases, data models/data sources/repositories, and presentation pages/widgets/BLoCs. Core holds app-wide routing, dependency injection, theme, validation and UI components.

```text
Flutter page -> BLoC event -> use case -> repository contract
     ^                                      |
     |                                      v
 BLoC state <- result/failure <- repository implementation
                                       |
                               Firebase / local demo store
```

GetIt registers clients, data sources and repository implementations. BLoCs are provided at the app root. GoRouter controls route transitions and redirects unauthenticated users to Sign In; the Home/Find/Sessions pages share a bottom-navigation shell.

Booking runs a Firestore transaction that verifies the time slot is still open, marks it booked and creates a session with the slot ID. Cancellation updates the session and releases that exact slot in a transaction. The local demo store provides the same repository contract for offline UI demonstration.
