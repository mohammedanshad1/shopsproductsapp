import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopsproductsapp/model/login_model.dart';
import 'dart:convert';

class LoginViewModel with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String _errorMessage = '';

  User? get user => _user;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    print(email);
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final url = Uri.parse('https://api.escuelajs.co/api/v1/auth/login');
    final response = await http.post(
      url,
      body: {'email': email, 'password': password}, 
    );
    print(response.body);
    _isLoading = false;

    if (response.statusCode == 201) {
      _user = User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      _errorMessage = 'Unauthorized. Please check your credentials.';
    } else {
      _errorMessage = 'Login failed. Please try again later.';
    }
    notifyListeners();
  }
}
