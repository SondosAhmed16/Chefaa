# Chefaa

Chefaa is a healthcare mobile application built with Flutter. It brings patients, doctors, pharmacies, and medical facilities together in one place, making it easier to manage everyday healthcare tasks through a single app.

The project is organized by feature and follows a Clean Architecture approach, with BLoC/Cubit for state management and a shared API layer for communication with the backend.

## Overview

Chefaa supports four main user roles:

- **Patient** – manage personal health information, medications, appointments, lab results, orders, and more.
- **Doctor** – manage a professional profile, clinics, appointments, and prescriptions.
- **Pharmacy** – manage pharmacy information, medicine inventory, and orders.
- **Medical Facility** – manage facility services, incoming requests, results, and notifications.

Each role has its own screens and workflows, while common services and reusable components are shared across the app.

## Features

### Patient
- Sign in, registration, password recovery, and verification flows.
- View and update personal and medical profile information.
- Search for doctors, pharmacies, and medical laboratories.
- Book and manage medical appointments.
- Keep track of medications and reminders.
- View lab results and submit reports for analysis.
- Browse medicines, manage the cart, and place orders.
- Follow order status and manage notifications.
- Access the patient chatbot.

### Doctor
- Doctor registration and profile management.
- Manage clinics and appointment schedules.
- View appointments and update their status.
- Add and manage patient prescriptions.
- Use doctor-focused assistant features and brief summaries.

### Pharmacy
- Manage pharmacy profile and settings.
- Add medicines and maintain stock information.
- View and manage customer orders.
- Access pharmacy assistant features.

### Medical Facility
- Manage facility profile and available services.
- View dashboard information and incoming requests.
- Upload lab results and manage notifications.

## Tech Stack

| Area | Tools |
| --- | --- |
| Framework | Flutter |
| Language | Dart |
| State management | flutter_bloc (BLoC / Cubit) |
| Networking | Dio |
| Dependency injection | GetIt |
| Local secure storage | Flutter Secure Storage |
| Local preferences | Shared Preferences |
| Maps and location | Google Maps Flutter, Geolocator, Geocoding |
| Responsive UI | Flutter ScreenUtil |
| SVG assets | flutter_svg |

Other packages are used for form validation, file selection, date picking, navigation, and common UI components.

## Project Structure

The codebase is grouped by feature. Most features are split into three layers:

```
lib/
├── core/
│   ├── API/                 # API consumer, Dio setup, endpoints, interceptors
│   ├── DI/                  # GetIt dependency registration
│   ├── error handle/        # API and application error handling
│   ├── routes/              # App navigation
│   ├── services/            # Storage, location, and shared services
│   ├── theme/                # App theme
│   ├── utils/                # Shared utilities and validators
│   └── widgets/              # Reusable UI components
│
├── features/
│   ├── auth/
│   ├── onboarding/
│   ├── patient/
│   ├── doctor/
│   ├── pharmacy/
│   ├── facility/
│   └── splash/
│
└── main.dart
```

A typical feature is organized like this:

```
feature_name/
├── data/
│   ├── datasource/
│   ├── model/
│   └── repository/
├── domain/
│   ├── entities/
│   ├── repository/
│   └── usecase/
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

- **Data** handles API requests, data models, and repository implementations.
- **Domain** contains the app's business logic, entities, repository contracts, and use cases.
- **Presentation** contains the screens, widgets, and Cubits that manage UI state.

## Architecture and App Flow

- **BLoC/Cubit:** separates UI rendering from application state and business logic.
- **Repository Pattern:** keeps data access behind clear interfaces.
- **Dependency Injection:** GetIt registers and provides shared services, data sources, repositories, use cases, and Cubits.
- **API Layer:** Dio is wrapped by a shared API consumer, keeping network operations consistent across features.
- **Error Handling:** shared exceptions and error models help handle API failures in a consistent way.
- **Secure Storage:** authentication tokens and user-related session data are stored using Flutter Secure Storage.

The dependency container is initialized before the app starts, and navigation is handled through the central app router.

## Getting Started

### Requirements

Make sure you have the following installed:

- Flutter SDK (compatible with the Dart SDK constraint in `pubspec.yaml`)
- Dart SDK
- Android Studio or VS Code
- An Android emulator, iOS simulator, or a physical device

### Run Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/SondosAhmed16/Chefaa.git
   ```

2. Open the project directory:

   ```bash
   cd Chefaa
   ```

3. Install the dependencies:

   ```bash
   flutter pub get
   ```

4. Check that Flutter is configured correctly:

   ```bash
   flutter doctor
   ```

5. Run the application:

   ```bash
   flutter run
   ```

## Backend Connection

The app communicates with the Chefaa backend through the shared Dio-based API layer. API endpoints and the base URL are defined in:

`lib/core/API/api_endpoints.dart`

If you are running the app against a different backend environment, update the base URL there before launching the application. Some features also require the relevant backend services to be available.

## Useful Commands

| Command | Description |
| --- | --- |
| `flutter pub get` | Install project dependencies |
| `flutter run` | Run the app on a connected device |
| `flutter analyze` | Check the project for analysis issues |
| `flutter test` | Run the available tests |
| `flutter build apk` | Build an Android APK |
| `flutter build ios` | Build for iOS (on macOS with Xcode) |

## Notes

- Location-based features require location permissions on the device.
- Google Maps features may require a valid Maps API key in the native platform configuration.
- Keep API keys and other private configuration out of version control.

---

Built with Flutter.
