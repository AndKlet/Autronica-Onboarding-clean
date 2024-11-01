import 'dart:convert';
import 'package:http/http.dart' as http;

/// A service class that handles user data.
class UserService {
  /// Gets user data.
  /// 
  /// This method is a placeholder for a future API call.
  Future<Object> getUser() async {
    return {
      'name': 'John Johnberg',
      'department': 'Engineering',
    };
  }

  /// Fetches user data using the provided access token.
  /// 
  /// - [accessToken]: The access token to use for fetching user data.
  Future<void> fetchUserData(String accessToken) async {
  final url = Uri.parse('https://164.92.218.9/get_user_data/');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $accessToken',  // Send token in Authorization header
    },
  );

  if (response.statusCode == 200) {
    final userData = jsonDecode(response.body);
    print('User Data Retrieved: $userData');
  } else {
    print('Failed to fetch user data: ${response.statusCode}');
  }
}
}
