# Migration from Firebase to PHP Backend - Complete

This document summarizes the migration from Firebase to a PHP backend with phpMyAdmin database.

## Changes Made

### 1. Removed Firebase Components

- ✅ Deleted Firebase documentation files (FIREBASE_*.md)
- ✅ Removed Firebase dependencies from `pubspec.yaml`:
  - Removed: `firebase_core`, `firebase_auth`, `cloud_firestore`
  - Added: `http` package for API calls
- ✅ Removed Firebase initialization from `main.dart`
- ✅ Removed Firebase dependencies from Android build files

### 2. Updated Flutter Code

#### Models
- ✅ **lib/models/habit.dart**: Changed from Firestore serialization to JSON serialization
  - Replaced `toFirestore()` with `toJson()`
  - Replaced `fromFirestore()` with `fromJson()`
- ✅ **lib/models/user.dart**: Created new AppUser model to replace Firebase User

#### Services
- ✅ **lib/services/auth_service.dart**: Complete rewrite
  - Uses HTTP API calls instead of Firebase Auth
  - Implements JWT token-based authentication
  - Stores user session in SharedPreferences
  - Provides Stream<AppUser?> for auth state changes

- ✅ **lib/services/habit_service.dart**: Complete rewrite
  - Uses HTTP API calls instead of Firestore
  - Changed from Stream-based to Future-based API
  - All CRUD operations use REST API endpoints

#### Providers
- ✅ **lib/providers/habit_provider.dart**: Updated to use Future instead of Stream
  - `loadHabits()` now returns Future<void> instead of void with Stream
  - Added automatic habit list reload after create/update/delete operations

#### Screens
- ✅ **lib/screens/habit_tracker_screen.dart**: Replaced Firebase User with AppUser
- ✅ **lib/screens/add_habit_screen.dart**: Replaced Firebase User with AppUser
- ✅ **lib/screens/edit_habit_screen.dart**: Replaced Firebase User with AppUser

#### Configuration
- ✅ **lib/config/api_config.dart**: New file for API configuration
  - Contains base URL and endpoint URLs
  - Update the `baseUrl` to match your PHP backend location

### 3. PHP Backend Created

#### Database
- ✅ **backend/database/schema.sql**: Complete database schema
  - `users` table for user accounts
  - `habits` table for habit data
  - `habit_completions` table for tracking completed dates

#### Configuration
- ✅ **backend/config/database.php**: Database connection configuration
- ✅ **backend/config/config.php**: General configuration (CORS, JWT)
- ✅ **backend/config/jwt.php**: JWT token generation and verification

#### API Endpoints
- ✅ **backend/auth/login.php**: User login
- ✅ **backend/auth/register.php**: User registration
- ✅ **backend/auth/forgot_password.php**: Password reset (placeholder)
- ✅ **backend/auth/logout.php**: User logout
- ✅ **backend/habits/index.php**: Complete CRUD operations for habits

## Setup Instructions

### 1. Database Setup

1. Open phpMyAdmin (usually at `http://localhost/phpmyadmin`)
2. Import `backend/database/schema.sql` or run the SQL commands manually

### 2. PHP Backend Configuration

1. Copy the `backend` folder to your web server directory:
   - XAMPP: `C:\xampp\htdocs\habit_tracker_api\`
   - WAMP: `C:\wamp64\www\habit_tracker_api\`
   - MAMP: `/Applications/MAMP/htdocs/habit_tracker_api/`

2. Edit `backend/config/database.php`:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USER', 'root');  // Your database username
   define('DB_PASS', '');      // Your database password
   define('DB_NAME', 'habit_tracker');
   ```

3. Edit `backend/config/config.php`:
   ```php
   define('JWT_SECRET', 'your-random-secret-key-here');  // Change this!
   ```

### 3. Flutter App Configuration

1. Edit `lib/config/api_config.dart`:
   ```dart
   static const String baseUrl = 'http://10.0.2.2/habit_tracker_api';  // Android emulator
   // OR
   static const String baseUrl = 'http://localhost/habit_tracker_api';  // iOS simulator
   // OR for physical device:
   static const String baseUrl = 'http://YOUR_COMPUTER_IP/habit_tracker_api';
   ```

2. Run `flutter pub get` to install the new dependencies:
   ```bash
   flutter pub get
   ```

### 4. Test the Setup

1. Start your web server (XAMPP, WAMP, or MAMP)
2. Verify database connection in phpMyAdmin
3. Test the API endpoints using Postman or curl
4. Run the Flutter app and test registration/login

## API Endpoints Reference

### Authentication
- `POST /auth/register.php` - Register new user
- `POST /auth/login.php` - Login user
- `POST /auth/forgot_password.php` - Request password reset
- `POST /auth/logout.php` - Logout user

### Habits
- `GET /habits/index.php?user_id={userId}` - Get all habits
- `GET /habits/index.php?id={habitId}` - Get single habit
- `POST /habits/index.php` - Create habit
- `PUT /habits/index.php?id={habitId}` - Update habit
- `DELETE /habits/index.php?id={habitId}` - Delete habit

All endpoints require `Content-Type: application/json` header.

Habit endpoints require `Authorization: Bearer {token}` header.

## Important Notes

1. **JWT Secret**: Change the JWT_SECRET in production to a strong random string
2. **CORS**: The current setup allows all origins. For production, restrict this
3. **Error Handling**: The PHP code has basic error handling. Consider adding more robust error handling for production
4. **Password Reset**: The forgot_password endpoint is a placeholder. Implement email sending for production
5. **Database Security**: Ensure your database credentials are secure and not exposed

## Troubleshooting

### Connection Errors
- Verify the API base URL matches your server location
- Check that your web server is running
- For physical devices, ensure they're on the same network as your computer
- Check firewall settings

### Authentication Errors
- Verify JWT_SECRET is set correctly
- Check database credentials
- Ensure the users table exists and has data

### Database Errors
- Verify database connection settings
- Check that all tables exist (users, habits, habit_completions)
- Verify foreign key constraints are set up correctly

## Next Steps

1. Test all functionality thoroughly
2. Add input validation on both client and server
3. Implement proper error logging
4. Add rate limiting for API endpoints
5. Implement email sending for password reset
6. Add API documentation (Swagger/OpenAPI)
7. Consider adding API versioning

