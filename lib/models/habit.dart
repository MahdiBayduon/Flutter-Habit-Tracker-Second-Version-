class Habit {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final String color;
  final String icon;
  final List<DateTime> completedDates;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int streak;
  final int totalCompletions;

  Habit({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.completedDates,
    required this.createdAt,
    required this.updatedAt,
    this.streak = 0,
    this.totalCompletions = 0,
  });

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'color': color,
      'icon': icon,
      'completed_dates': completedDates.map((date) => date.toIso8601String()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'streak': streak,
      'total_completions': totalCompletions,
    };
  }

  // Create from JSON response
  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id']?.toString(),
      userId: json['user_id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      color: json['color'] ?? '#6366F1',
      icon: json['icon'] ?? '📝',
      completedDates: (json['completed_dates'] as List<dynamic>?)
              ?.map((dateStr) => DateTime.parse(dateStr as String))
              .toList() ??
          [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      streak: json['streak'] ?? 0,
      totalCompletions: json['total_completions'] ?? 0,
    );
  }

  // Copy with method for updates
  Habit copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? color,
    String? icon,
    List<DateTime>? completedDates,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? streak,
    int? totalCompletions,
  }) {
    return Habit(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      completedDates: completedDates ?? this.completedDates,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      streak: streak ?? this.streak,
      totalCompletions: totalCompletions ?? this.totalCompletions,
    );
  }

  // Check if habit is completed today
  bool isCompletedToday() {
    final today = DateTime.now();
    return completedDates.any((date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day);
  }
}

