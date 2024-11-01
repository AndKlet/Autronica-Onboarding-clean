import 'dart:convert';
import 'package:autron/src/view_models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// A service class that handles user data.
class UserService {
  final _storage = const FlutterSecureStorage();

  /// Fetches user data from the server.
  /// 
  /// This method sends a GET request to the server with the access token in the headers.
  Future<User?> fetchUserData(String accessToken) async {
    final url = Uri.parse('https://164.92.218.9/get_user_data/');

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
        // Remove print statement in production
        // TODO Error handling
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      // Remove print statement in production
      // TODO Error handling
      print('Error fetching user data: $e');
    }
    return null;
  }

  /// Stores user data securely on the device using FlutterSecureStorage.
  Future<void> storeUserData(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.write(key: 'user_data', value: userJson);
  }

  /// Retrieves user data from the device's storage using FlutterSecureStorage.
  /// 
  /// Returns `null` if no user data is found.
  Future<User?> getUserData() async {
    final userJson = await _storage.read(key: 'user_data');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  /// Clears user data from the device's storage using FlutterSecureStorage.
  /// 
  /// This method is used when the user logs out.
  Future<void> clearUserData() async {
    await _storage.delete(key: 'user_data');
  }
}