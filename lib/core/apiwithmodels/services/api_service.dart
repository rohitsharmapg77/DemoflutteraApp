import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {

  final String baseUrl = 'https://jsonplaceholder.typicode.com';


  //User API CALL for fetch data

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }
    //with mutiple use



    // ✅ 1. Get Users List
    Future<List<dynamic>> fetchUserse() async {
      final response = await http.get(Uri.parse('$baseUrl/users'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load users');
      }
    }

    // ✅ 2. Get Posts
    Future<List<dynamic>> fetchPosts() async {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    }

    // ✅ 3. Get Single User by ID
    Future<Map<String, dynamic>> fetchUserById(int id) async {
      final response = await http.get(Uri.parse('$baseUrl/users/$id'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('User not found');
      }
    }









}