import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsproductsapp/view/login_view.dart';
import 'package:shopsproductsapp/view/produts_view.dart'; // Import Product_View
import 'package:shopsproductsapp/viewmodel/category_product_viewmodel.dart';
import 'package:shopsproductsapp/viewmodel/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences before the app starts
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userEmail = prefs.getString('userEmail');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryProductViewModel()),
      ],
      child: MyApp(userEmail: userEmail),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? userEmail;

  MyApp({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // If the user is logged in, show Product_View. Otherwise, show LoginPage
      home: userEmail != null ? Product_View() : LoginPage(),
    );
  }
}
