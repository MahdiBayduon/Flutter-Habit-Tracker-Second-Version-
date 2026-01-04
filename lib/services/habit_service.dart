import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/habit.dart';
import 'auth_service.dart';

class HabitService {
  final AuthService _authService = AuthService();

  // Get auth headers
  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await _authService.getAuthToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Create a new habit
  Future<String> createHabit(Habit habit) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        Uri.parse(ApiConfig.habitsUrl),
        headers: headers,
        body: json.encode(habit.toJson()),
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true) {
          return responseData['data']['id']?.toString() ?? '';
        } else {
          throw responseData['message'] ?? 'Error creating habit';
        }
      } else {
        throw responseData['message'] ?? 'Error creating habit';
      }
    } catch (e) {
      throw 'Error creating habit: ${e.toString().replaceAll('Exception: ', '')}';
    }
  }

  // Get all habits for a user
  Future<List<Habit>> getHabits(String userId) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(
        Uri.parse('${ApiConfig.habitsUrl}?user_id=$userId'),
        headers: headers,
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          final habitsList = responseData['data'] as List<dynamic>;
          return habitsList.map((json) => Habit.fromJson(json as Map<String, dynamic>)).toList();
        } else {
          throw responseData['message'] ?? 'Error fetching habits';
        }
      } else {
        throw responseData['message'] ?? 'Error fetching habits';
      }
    } catch (e) {
      throw 'Error fetching habits: ${e.toString().replaceAll('Exception: ', '')}';
    }
  }

  // Get a single habit by ID
  Future<Habit?> getHabitById(String habitId) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(
        Uri.parse(ApiConfig.habitUrl(habitId)),
        headers: headers,
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          return Habit.fromJson(responseData['data'] as Map<String, dynamic>);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      throw 'Error fetching habit: ${e.toString().replaceAll('Exception: ', '')}';
    }
  }

  // Update a habit
  Future<void> updateHabit(String habitId, Habit habit) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.put(
        Uri.parse(ApiConfig.habitUrl(habitId)),
        headers: headers,
        body: json.encode(habit.toJson()),
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        if (responseData['success'] != true) {
          throw responseData['message'] ?? 'Error updating habit';
        }
      } else {
        throw responseData['message'] ?? 'Error updating habit';
      }
    } catch (e) {
      throw 'Error updating habit: ${e.toString().replaceAll('Exception: ', '')}';
    }
  }

  // Delete a habit
  Future<void> deleteHabit(String habitId) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.delete(
        Uri.parse(ApiConfig.habitUrl(habitId)),
        headers: headers,
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        if (responseData['success'] != true) {
          throw responseData['message'] ?? 'Error deleting habit';
        }
      } else {
        throw responseData['message'] ?? 'Error deleting habit';
      }
    } catch (e) {
      throw 'Error deleting habit: ${e.toString().replaceAll('Exception: ', '')}';
    }
  }

  // Toggle habit completion for today
  Future<void> toggleHabitCompletion(String habitId, Habit habit) async {
    try {
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      
      List<DateTime> updatedDates = List.from(habit.completedDates);
      bool isCompletedToday = habit.isCompletedToday();

      if (isCompletedToday) {
        // Remove today's completion
        updatedDates.removeWhere((date) =>
            date.year == today.year &&
            date.month == today.month &&
            date.day == today.day);
      } else {
        // Add today's completion
        updatedDates.add(todayStart);
      }

      // Calculate streak
      int newStreak = _calculateStreak(updatedDates);
      int newTotalCompletions = updatedDates.length;

      final updatedHabit = habit.copyWith(
        completedDates: updatedDates,
        updatedAt: DateTime.now(),
        streak: newStreak,
        totalCompletions: newTotalCompletions,
      );

      await updateHabit(habitId, updatedHabit);
    } catch (e) {
      throw 'Error toggling habit completion: ${e.toString().replaceAll('Exception: ', '')}';
    }
  }

  // Calculate current streak
  int _calculateStreak(List<DateTime> completedDates) {
    if (completedDates.isEmpty) return 0;

    // Sort dates in descending order
    final sortedDates = List<DateTime>.from(completedDates)
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime expectedDate = DateTime.now();
    final today = DateTime(expectedDate.year, expectedDate.month, expectedDate.day);

    for (var date in sortedDates) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      final expectedDateOnly = DateTime(
        expectedDate.year,
        expectedDate.month,
        expectedDate.day,
      );

      if (dateOnly.year == expectedDateOnly.year &&
          dateOnly.month == expectedDateOnly.month &&
          dateOnly.day == expectedDateOnly.day) {
        streak++;
        expectedDate = expectedDate.subtract(const Duration(days: 1));
      } else if (dateOnly.isBefore(expectedDateOnly)) {
        break;
      }
    }

    return streak;
  }
}
