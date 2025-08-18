import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_state/Models/user_model.dart';

class FetchProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  bool _isLoading = false;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

  /// Fetch users from API
  Future<void> getUserList() async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

      // 👇 Add headers to avoid 403
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "User-Agent": "FlutterApp/1.0",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> res = jsonDecode(response.body);
        _users = res.map((e) => UserModel.fromJson(e)).toList();
      } else {
        _users = [];
        print("API Error: ${response.statusCode}");
      }
    } catch (e) {
      _users = [];
      print("Exception while fetching users: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
