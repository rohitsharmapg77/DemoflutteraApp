import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  List<User> users = [];
  bool isLoading = false;

  void fetchUserData() async {
    isLoading = true;
    notifyListeners();

    try {
      users = await ApiService.fetchUsers();
    } catch (e) {
      print("Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
