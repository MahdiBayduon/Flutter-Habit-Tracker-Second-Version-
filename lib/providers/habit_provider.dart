import 'package:flutter/foundation.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';

class HabitProvider with ChangeNotifier {
  final HabitService _habitService = HabitService();
  List<Habit> _habits = [];
  bool _isLoading = false;
  String? _error;

  List<Habit> get habits => _habits;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load habits for a user
  Future<void> loadHabits(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _habits = await _habitService.getHabits(userId);
      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Create a new habit
  Future<bool> createHabit(Habit habit) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _habitService.createHabit(habit);
      // Reload habits to get updated list
      await loadHabits(habit.userId);
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Update a habit
  Future<bool> updateHabit(String habitId, Habit habit) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _habitService.updateHabit(habitId, habit);
      // Reload habits to get updated list
      await loadHabits(habit.userId);
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Delete a habit
  Future<bool> deleteHabit(String habitId, String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _habitService.deleteHabit(habitId);
      // Reload habits to get updated list
      await loadHabits(userId);
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Toggle habit completion
  Future<bool> toggleHabitCompletion(String habitId, Habit habit) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _habitService.toggleHabitCompletion(habitId, habit);
      // Reload habits to get updated list
      await loadHabits(habit.userId);
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}

