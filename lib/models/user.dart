class AppUser {
  final String id;
  final String email;
  final String? displayName;

  AppUser({
    required this.id,
    required this.email,
    this.displayName,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      displayName: json['display_name'] ?? json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      if (displayName != null) 'display_name': displayName,
    };
  }
}

