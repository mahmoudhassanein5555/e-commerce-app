# E-Commerce App - Registration Feature

Welcome to the Registration Feature documentation for the E-Commerce App. This module is responsible for handling new user onboarding, capturing user credentials, validating inputs, and securely communicating with the backend to create new accounts.

Architecture & Design Pattern

This feature is built using a Feature-First Architecture and enforces a strict separation of concerns between the UI and business logic.

Key Technologies & Libraries:
-State Management: `flutter_bloc` (using `Cubit` for lightweight, predictable state emission).
-Dependency Injection: `get_it` is utilized as a service locator to instantiate and inject the `RegisterCubit`.
-Routing: Handled via Flutter's standard named route mappings.

Directory Structure

-The code for this feature is cleanly isolated within its domain:

```text
lib/feature/auth/register/
└── presentation/
    ├── view/
    │   └── register_screen.dart        # The declarative UI layout and form for registration.
    └── view_model/
        └── home_cubit/
            └── register_cubit.dart     # The Cubit managing API calls and view states (Loading, Success, Error).
```

Integration & Lifecycle

-The Registration screen is designed to be fully decoupled. It is hooked into the application tree inside `main.dart` using a `BlocProvider`.

1. Navigation: The app navigates to `RegisterScreen.routeName`.
2. Provisioning: A `BlocProvider` intercepts the route creation and requests an instance of `RegisterCubit` from the `get_it` service locator.
3. Observation: The `RegisterScreen` consumes the Cubit to build its UI based on the current state (e.g., showing a `CircularProgressIndicator` during an active network request).

Implementation Details

Here is how the module is registered in the application's root routing table:

```dart
RegisterScreen.routeName: (context) => BlocProvider<RegisterCubit>(
    create: (context) => getIt<RegisterCubit>(),
    child: const RegisterScreen(),
),
```

Future Improvements

- Add comprehensive Unit Tests for `RegisterCubit` testing state emissions.
- Add Widget Tests for `RegisterScreen` form validations.
