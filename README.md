# Ensake

Ensake is a Flutter-based application template designed for robust session management, secure configuration, and comprehensive error handling. The project structure supports modular development and easy scalability.

## Features

- **Authentication**: Login and registration flows with state management using Cubits.
- **Session Management**: Automatic session timeout and user notification.
- **Error Handling**: Centralized error codes and user-friendly messages.
- **Rewards System**: Claim and view rewards.
- **Profile & QR Code**: User profile and QR code features.
- **Secure Configuration**: Sensitive configuration loaded from `assets/env.json`.
- **Custom UI Components**: Buttons, dialogs, input fields, and toast notifications.

## Project Structure

See the [lib/](lib) folder for all source code. Key directories include:

- `app/`: App initialization, session management, dependency injection.
- `features/`: Modular features (auth, home, profile, qrcode, rewards).
- `network/`: API data sources, repositories, and HTTP client setup.
- `services/`: Configuration services.
- `utils/`: Utilities for assets, error handling, routing, storage, and validation.
- `common/`: Shared UI components.

## Error Handling

Error handling is centralized in [`utils/error_handler.dart`](lib/utils/error_handler.dart) and [`utils/constants.dart`](lib/utils/constants.dart). All API errors are mapped to user-friendly messages and codes, ensuring consistent feedback across the app.

Example:

```dart
// filepath: [error_handler.dart](http://_vscodecontentref_/2)
class ResponseCode {
  static const String invalidemail = INVALIDEMAIL;
  // ...
}
class ResponseMessage {
  static const String invalidemail = INVALIDEMAILRESPONSE;
  // ...
}
```

## Session Management

Session management is implemented in [`app/app.dart`](lib/app/app.dart) within the `RootApp` widget. The app uses a timer to track user activity and automatically logs out users after a period of inactivity (default: 5 minutes). On timeout, the user is notified and redirected to the login page.

```dart
// filepath: [app.dart](http://_vscodecontentref_/3)
void _startTimer() {
  int timeoutInSeconds = 300; // 5 minutes
  // ...
  _timer = Timer.periodic(oneSec, (Timer timer) {
    if (timeoutInSeconds == 0) {
      timer.cancel();
      _timeoutAction();
    } else {
      timeoutInSeconds--;
    }
  });
}
```

## Secure Configuration

Sensitive configuration values are stored in `assets/env.json` and loaded at runtime via [`services/config_services.dart`](lib/services/config_services.dart). This approach keeps secrets out of source code and supports environment-specific settings.

```dart
// filepath: [main.dart](http://_vscodecontentref_/4)
await ConfigServices.loadConfig();
```

## Assets

All images and SVGs are organized in `assets/images/` and `assets/svg/`. Asset references are managed via [`utils/assets.dart`](lib/utils/assets.dart).

## Getting Started

### 1.Install dependencies

```bash
flutter pub get
```

### 2.Configure environment

Add the `env.json` inside the `assets` folder with the json structure below.

```json
{
    "BASE_URL": "BASE_URL"
}
```

### 3.Run the app

```bash

flutter run
```

