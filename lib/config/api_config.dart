class ApiConfig {
  // Change this to your PHP backend URL
  // For local development: 'http://10.0.2.2' (Android emulator)
  // For local development: 'http://localhost' (iOS simulator)
  // For production: 'https://yourdomain.com'
  // Change based on platform:
  // - Windows desktop/Web: 'http://localhost/habit_tracker_api'
  // - Android emulator: 'http://10.0.2.2/habit_tracker_api'
  // - iOS simulator: 'http://localhost/habit_tracker_api'
  // - Physical device: 'http://YOUR_COMPUTER_IP/habit_tracker_api'
  // Apache is running on port 8081 (Flutter uses 8080)
  static const String baseUrl = 'http://localhost:8081/habit_tracker_api';
  
  // API endpoints
  static const String loginEndpoint = '/auth/login.php';
  static const String registerEndpoint = '/auth/register.php';
  static const String forgotPasswordEndpoint = '/auth/forgot_password.php';
  static const String logoutEndpoint = '/auth/logout.php';
  static const String habitsEndpoint = '/habits/index.php';
  
  // Full URLs
  static String get loginUrl => '$baseUrl$loginEndpoint';
  static String get registerUrl => '$baseUrl$registerEndpoint';
  static String get forgotPasswordUrl => '$baseUrl$forgotPasswordEndpoint';
  static String get logoutUrl => '$baseUrl$logoutEndpoint';
  static String get habitsUrl => '$baseUrl$habitsEndpoint';
  
  // Helper method to get habit-specific URLs
  static String habitUrl(String habitId) => '$baseUrl/habits/index.php?id=$habitId';
}

