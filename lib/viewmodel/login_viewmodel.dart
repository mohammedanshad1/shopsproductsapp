import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shopsproductsapp/model/login_model.dart';
import 'package:shopsproductsapp/view/produts_view.dart';
import 'package:shopsproductsapp/widgets/custom_snackabr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> login(
      String username, String password, BuildContext context) async {
    const url = 'https://api.escuelajs.co/api/v1/auth/login';
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': username,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final user = userFromJson(response.body);
        print('Login successful: ${user.accessToken}');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userEmail', username);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Product_View()),
            (route) => false);

        CustomSnackBar.show(
          context,
          snackBarType: SnackBarType.success,
          label: 'Login successful!',
          bgColor: Colors.green,
        );
      } else {
        _errorMessage = 'Failed to login. Please try again.';
        print('Login failed: ${response.body}');
        CustomSnackBar.show(
          context,
          snackBarType: SnackBarType.fail,
          label: _errorMessage,
          bgColor: Colors.red,
        );
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error logging in: $e');
      CustomSnackBar.show(
        context,
        snackBarType: SnackBarType.fail,
        label: _errorMessage,
        bgColor: Colors.red,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
