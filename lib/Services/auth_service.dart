import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:oirov13/Constants/api_config.dart';

class AuthService {
  final String apiUrl = '${ApiConfig.apiUrl}/api/admin/user/login';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String token = responseData['data']['token'];
        await storage.write(key: 'token', value: token);
        return {'success': true, 'data': responseData};
      } else {
        return {'success': false, 'message': 'Login failed: ${response.body}'};
      }
    } catch (error) {
      return {'success': false, 'message': 'An error occurred: $error'};
    }
  }

  Future<bool> isTokenExists() async {
    final token = await storage.read(key: 'token');
    return token != null && token.isNotEmpty;
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }
}
