import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../models/user.dart';

class AuthService {
  AppUser? _currentUser;
  final _authController = StreamController<AppUser?>.broadcast();

  // Get current user
  AppUser? get currentUser => _currentUser;

  // Auth state stream
  Stream<AppUser?> get authStateChanges => _authController.stream;

  AuthService() {
    _loadUserFromStorage();
  }

  // Load user from local storage
  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('current_user');
      final token = prefs.getString('auth_token');

      if (userJson != null && token != null) {
        final userMap = json.decode(userJson) as Map<String, dynamic>;
        _currentUser = AppUser.fromJson(userMap);
        _authController.add(_currentUser);
      } else {
        _authController.add(null);
      }
    } catch (e) {
      _authController.add(null);
    }
  }

  // Save user to local storage
  Future<void> _saveUserToStorage(AppUser user, String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(user.toJson()));
      await prefs.setString('auth_token', token);
      _currentUser = user;
      _authController.add(_currentUser);
    } catch (e) {
      throw 'Error saving user data';
    }
  }

  // Clear user from local storage
  Future<void> _clearUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_user');
      await prefs.remove('auth_token');
      _currentUser = null;
      _authController.add(null);
    } catch (e) {
      throw 'Error clearing user data';
    }
  }

  // Get auth token from storage
  Future<String?> getAuthToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    } catch (e) {
      return null;
    }
  }

  // Sign in with email and password
  Future<AppUser> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email.trim(),
          'password': password,
        }),
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          final user = AppUser.fromJson(responseData['user']);
          final token = responseData['token'] as String;
          await _saveUserToStorage(user, token);
          return user;
        } else {
          throw responseData['message'] ?? 'Login failed';
        }
      } else {
        throw responseData['message'] ?? 'Login failed. Please try again.';
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup') || 
          e.toString().contains('Connection refused')) {
        throw 'Cannot connect to server. Please check your internet connection and API URL.';
      }
      throw e.toString().replaceAll('Exception: ', '');
    }
  }

  // Register with email and password
  Future<AppUser> registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email.trim(),
          'password': password,
          'display_name': displayName.trim(),
        }),
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true) {
          final user = AppUser.fromJson(responseData['user']);
          final token = responseData['token'] as String;
          await _saveUserToStorage(user, token);
          return user;
        } else {
          throw responseData['message'] ?? 'Registration failed';
        }
      } else {
        throw responseData['message'] ?? 'Registration failed. Please try again.';
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup') || 
          e.toString().contains('Connection refused')) {
        throw 'Cannot connect to server. Please check your internet connection and API URL.';
      }
      throw e.toString().replaceAll('Exception: ', '');
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.forgotPasswordUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email.trim(),
        }),
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        if (responseData['success'] != true) {
          throw responseData['message'] ?? 'Failed to send reset email';
        }
      } else {
        throw responseData['message'] ?? 'Failed to send reset email. Please try again.';
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup') || 
          e.toString().contains('Connection refused')) {
        throw 'Cannot connect to server. Please check your internet connection and API URL.';
      }
      throw e.toString().replaceAll('Exception: ', '');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      final token = await getAuthToken();
      if (token != null) {
        // Optionally call logout endpoint
        try {
          await http.post(
            Uri.parse(ApiConfig.logoutUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          );
        } catch (e) {
          // Ignore logout API errors
        }
      }
      await _clearUserFromStorage();
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }

  void dispose() {
    _authController.close();
  }
}
