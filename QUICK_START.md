# Quick Start Guide

## Prerequisites

- Flutter SDK (3.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Firebase account (free tier is sufficient)
- Android device or emulator / iOS simulator

## Step 1: Install Dependencies

```bash
flutter pub get
```

## Step 2: Set Up Firebase

1. Follow the detailed guide in `FIREBASE_SETUP.md`
2. Create a Firebase project
3. Enable Authentication (Email/Password)
4. Enable Firestore Database
5. Download and add configuration files:
   - `google-services.json` for Android → `android/app/`
   - `GoogleService-Info.plist` for iOS → `ios/Runner/`

## Step 3: Run the App

### Android
```bash
flutter run
```

### iOS
```bash
flutter run -d ios
```

### Specific Device
```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

## Step 4: Test the App

1. **Register**: Create a new account with email/password
2. **Login**: Sign in with your credentials
3. **Add Habit**: Tap the "+" button to add your first habit
4. **Track**: Tap the circle icon to mark habits as complete
5. **Edit**: Tap a habit card to edit details
6. **View Stats**: See streaks and completion counts

## Common Issues

### Firebase Not Initialized
- Ensure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location
- Check that Firebase is properly initialized in `main.dart`

### Build Errors
- Run `flutter clean` then `flutter pub get`
- For Android: Check Gradle version compatibility
- For iOS: Run `cd ios && pod install`

### Authentication Errors
- Verify Email/Password authentication is enabled in Firebase Console
- Check Firestore security rules

## Development Tips

- Use hot reload (`r` in terminal) for quick UI updates
- Use hot restart (`R` in terminal) for state changes
- Check Flutter DevTools for debugging

## Next Steps

- Customize colors in `lib/utils/colors.dart`
- Add more habit icons in `lib/screens/add_habit_screen.dart`
- Enhance UI components in `lib/widgets/`
- Add more features as needed

## Support

For issues or questions:
1. Check `FIREBASE_SETUP.md` for Firebase configuration
2. Review `PROJECT_STRUCTURE.md` for code organization
3. Check Flutter and Firebase documentation

