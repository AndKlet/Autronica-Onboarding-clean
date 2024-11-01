import 'dart:convert';
import 'package:autron/src/view_models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserService {
  final _storage = const FlutterSecureStorage();

  Future<Object> getUser() async {
    return {
      'name': 'John Johnberg',
      'department': 'Engineering',
    };
  }
  
  // Fetch user data from the server
  Future<User?> fetchUserData(String accessToken) async {
    final url = Uri.parse('https://164.92.218.9/get_user_data/'); // Replace with actual URL

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken', // Send access token
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body)['user_data'];
        final user = User.fromJson(userData); // Parse JSON into User model
        await storeUserData(user); // Store user data securely
        return user;
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }

  // Store user data in secure storage
  Future<void> storeUserData(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.write(key: 'user_data', value: userJson);
  }

  // Retrieve user data from secure storage
  Future<User?> getUserData() async {
    final userJson = await _storage.read(key: 'user_data');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  // Clear user data
  Future<void> clearUserData() async {
    await _storage.delete(key: 'user_data');
  }
}