import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:suitmedia_test/models/user_model.dart';
import 'dart:convert';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;
  String _selectedUserName = "No user selected";

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;
  String get selectedUserName => _selectedUserName;

  Future<void> fetchUsers({int page = 1, int perPage = 10}) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<UserModel> loadedUsers = [];
      for (var userJson in data['data']) {
        loadedUsers.add(UserModel.fromJson(userJson));
      }
      if (page == 1) {
        _users = loadedUsers;
      } else {
        _users.addAll(loadedUsers);
      }
      _hasMoreData =
          loadedUsers.length == perPage;
      _page = page;
    } else {
      throw Exception('Failed to load users');
    }

    _isLoading = false;
    notifyListeners();
  }

  void resetUsers() {
    _users = [];
    _page = 1;
    _hasMoreData = true;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_hasMoreData && !_isLoading) {
      await fetchUsers(page: _page + 1);
    }
  }

  set selectedUserName(String name) {
    _selectedUserName = name;
    notifyListeners();
  }
}
