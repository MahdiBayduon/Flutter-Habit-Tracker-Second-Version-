# Habit Tracker Mobile App

A beautiful and functional habit tracking mobile application built with Flutter and Firebase.

## Features

- 🔐 User Authentication (Login, Register, Forgot Password)
- 📝 Create, Read, Update, Delete Habits
- 📊 Track daily habit completion
- 🎨 Modern and intuitive UI
- ☁️ Cloud-based data storage with Firebase

## Pages

1. **Login Page** - User authentication
2. **Register Page** - New user registration
3. **Forgot Password Page** - Password recovery
4. **Habit Tracker Page** - Main dashboard showing all habits
5. **Add Habit Page** - Create new habits
6. **Edit Habit Page** - Modify existing habits

## Setup Instructions

1. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

2. Set up Firebase:
   - Create a Firebase project at https://console.firebase.google.com
   - Enable Authentication (Email/Password)
   - Enable Cloud Firestore
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories

3. Run the app:
   ```bash
   flutter run
   ```

## Technical Stack

- **Framework**: Flutter
- **Backend**: Firebase (Authentication + Firestore)
- **State Management**: Provider
- **UI**: Material Design with Google Fonts

## Project Structure

```
lib/
├── main.dart
├── models/
│   └── habit.dart
├── services/
│   ├── auth_service.dart
│   └── habit_service.dart
├── providers/
│   └── habit_provider.dart
├── screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── forgot_password_screen.dart
│   ├── habit_tracker_screen.dart
│   ├── add_habit_screen.dart
│   └── edit_habit_screen.dart
├── widgets/
│   └── habit_card.dart
└── utils/
    └── colors.dart
```

