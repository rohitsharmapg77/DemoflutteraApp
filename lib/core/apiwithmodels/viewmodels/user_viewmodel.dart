import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../models/postmodel.dart';


class UserViewModel extends ChangeNotifier {

  //for mutiple
  final ApiService _apiService = ApiService();

  List<dynamic> users = [];
  List<dynamic> _posts = [];
  bool isLoading = false;
  String? _error;


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


  Future<void> loadData() async {
   isLoading = true;
    _error = null;
   notifyListeners();

    try {
      users = await _apiService.fetchUserse();
       _posts = await _apiService.fetchPosts();
    } catch (e) {
       _error = e.toString();
     }

   isLoading = false;
     notifyListeners();
  }


}



