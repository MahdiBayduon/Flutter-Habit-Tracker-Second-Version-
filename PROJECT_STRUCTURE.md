# Habit Tracker - Project Structure

## Overview

This Flutter mobile application is a comprehensive habit tracking system with Firebase backend integration. The project follows clean architecture principles with separation of concerns.

## Project Structure

```
habit_tracker/
├── android/                 # Android platform-specific files
│   ├── app/
│   │   └── build.gradle    # Android app build configuration
│   ├── build.gradle        # Android project build configuration
│   └── settings.gradle     # Android project settings
├── ios/                     # iOS platform-specific files (if needed)
├── lib/                     # Main application code
│   ├── main.dart           # Application entry point
│   ├── models/             # Data models
│   │   └── habit.dart      # Habit data model
│   ├── services/           # Business logic services
│   │   ├── auth_service.dart      # Authentication service
│   │   └── habit_service.dart     # Habit CRUD operations
│   ├── providers/          # State management
│   │   └── habit_provider.dart    # Habit state provider
│   ├── screens/            # UI screens/pages
│   │   ├── login_screen.dart           # Login page
│   │   ├── register_screen.dart        # Registration page
│   │   ├── forgot_password_screen.dart # Password reset page
│   │   ├── habit_tracker_screen.dart   # Main dashboard
│   │   ├── add_habit_screen.dart       # Add new habit
│   │   └── edit_habit_screen.dart      # Edit existing habit
│   ├── widgets/            # Reusable UI components
│   │   └── habit_card.dart # Habit card widget
│   └── utils/              # Utility files
│       └── colors.dart     # App color constants
├── assets/                 # Images, icons, etc.
├── pubspec.yaml           # Flutter dependencies
├── README.md              # Project documentation
├── FIREBASE_SETUP.md      # Firebase configuration guide
└── .gitignore            # Git ignore rules
```

## Key Components

### Models (`lib/models/`)

- **habit.dart**: Defines the Habit data model with Firestore serialization/deserialization

### Services (`lib/services/`)

- **auth_service.dart**: Handles user authentication (login, register, password reset)
- **habit_service.dart**: Manages habit CRUD operations and streak calculations

### Providers (`lib/providers/`)

- **habit_provider.dart**: State management for habits using Provider pattern

### Screens (`lib/screens/`)

1. **login_screen.dart**: User login with email/password
2. **register_screen.dart**: New user registration
3. **forgot_password_screen.dart**: Password recovery via email
4. **habit_tracker_screen.dart**: Main dashboard showing all habits
5. **add_habit_screen.dart**: Form to create new habits
6. **edit_habit_screen.dart**: Form to edit existing habits

### Widgets (`lib/widgets/`)

- **habit_card.dart**: Reusable card widget displaying habit information

### Utils (`lib/utils/`)

- **colors.dart**: Centralized color definitions and gradients

## Features Implemented

### Authentication
- ✅ User registration with email/password
- ✅ User login
- ✅ Password reset via email
- ✅ Session management
- ✅ Automatic login state detection

### Habit Management
- ✅ Create new habits
- ✅ View all habits
- ✅ Edit existing habits
- ✅ Delete habits
- ✅ Toggle daily completion
- ✅ Streak tracking
- ✅ Total completion count

### UI/UX
- ✅ Modern, gradient-based design
- ✅ Responsive layouts
- ✅ Loading states
- ✅ Error handling with user-friendly messages
- ✅ Empty states
- ✅ Form validation
- ✅ Customizable habit colors and icons

### Backend Integration
- ✅ Firebase Authentication
- ✅ Cloud Firestore database
- ✅ Real-time data synchronization
- ✅ User-specific data isolation

## Technical Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider
- **Backend**: Firebase (Authentication + Firestore)
- **UI**: Material Design 3
- **Fonts**: Google Fonts (Poppins)

## Course Topics Covered

This project implements the following mobile programming concepts:

1. **Activities/Screens**: Multiple screens with navigation
2. **Authentication**: User registration, login, password reset
3. **Database Operations**: CRUD operations with Firestore
4. **State Management**: Provider pattern for state handling
5. **API Integration**: Firebase services integration
6. **Form Handling**: Input validation and form submission
7. **UI/UX Design**: Modern, responsive interface
8. **Data Models**: Structured data models with serialization
9. **Error Handling**: Comprehensive error management
10. **Real-time Updates**: Live data synchronization

## Getting Started

1. Install Flutter dependencies: `flutter pub get`
2. Set up Firebase (see FIREBASE_SETUP.md)
3. Run the app: `flutter run`

## Notes

- The app requires Firebase configuration to function properly
- All user data is stored in Cloud Firestore
- Authentication is handled by Firebase Auth
- The app supports both Android and iOS platforms

