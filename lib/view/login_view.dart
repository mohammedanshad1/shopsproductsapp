// import 'package:flutter/material.dart';
// import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
// import 'package:provider/provider.dart';
// import 'package:shopsproductsapp/view/produts_view.dart';
// import 'package:shopsproductsapp/viewmodel/login_viewmodel.dart';
// import 'package:shopsproductsapp/widgets/custom_snackabr.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final loginViewModel = Provider.of<LoginViewModel>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               if (loginViewModel.isLoading)
//                 const CircularProgressIndicator()
//               else
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       // print(_emailController.text);
//                       await loginViewModel.login(
//                         _emailController.text,
//                         _passwordController.text,
//                       );
//                       if (loginViewModel.user != null) {
//                         // Navigate to the HomePage
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomePage()),
//                         );
//                         CustomSnackBar.show(
//                           context,
//                           snackBarType: SnackBarType.success,
//                           label: 'Login successful!',
//                           bgColor: Colors.green,
//                         );
//                       } else {
//                         CustomSnackBar.show(
//                           context,
//                           snackBarType: SnackBarType.fail,
//                           label: loginViewModel.errorMessage,
//                           bgColor: Colors.red,
//                         );
//                       }
//                     }
//                   },
//                   child: const Text('Login'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
