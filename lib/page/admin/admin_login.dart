// import 'package:eventifyQr/services/services.dart';
// import 'package:eventifyQr/snackBar.dart';
// import 'package:flutter/material.dart';

// class AdminLoginPage extends StatefulWidget {
//   @override
//   _AdminLoginPageState createState() => _AdminLoginPageState();
// }

// class _AdminLoginPageState extends State<AdminLoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // Dummy Admin credentials (replace with real authentication logic)
//   final String adminEmail = "admin@example.com";
//   final String adminPassword = "admin123";

//   void _loginAdmin()async {

//      if (_formKey.currentState!.validate()) {
//       final response = await setAdminLogin({
//           "username": "Admin",
//           "password": 123
//       });

//       final responseBody = response['body'];

//       final status = responseBody['status'];

//       if (status == 200) {
//         SnackBarMessage(context, true, responseBody['msg'].toString());
//         Navigator.pushReplacementNamed(context, '/AdminHome');
//       } else if (status == 500) {
//         SnackBarMessage(context, false, "Internal Server Error");
//       } else {

//           SnackBarMessage(context, false, "msg");
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Admin Login"),
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: ,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Login Title
//                   Text(
//                     "Admin Login",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepOrange,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20),

//                   // Email Field
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your email";
//                       }
//                       if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                         return "Please enter a valid email address";
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20),

//                   // Password Field
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.lock),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your password";
//                       }
//                       if (value.length < 6) {
//                         return "Password must be at least 6 characters long";
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 30),

//                   // Login Button
//                   ElevatedButton(
//                     onPressed: _loginAdmin,
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       backgroundColor: Colors.deepOrange,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "Login",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // Footer Message
//                   Center(
//                     child: Text(
//                       "Access restricted to Admins only",
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:eventifyQr/services/services.dart'; // Assuming this exists
import 'package:eventifyQr/snackBar.dart'; // Assuming this exists
import 'package:flutter/material.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginAdmin() async {
    if (!_formKey.currentState!.validate()) {
      try {
        final response = await setAdminLogin({
          "username": _emailController.text,
          "password": _passwordController.text,
        });
        // final response = await setAdminLogin({
        //   "username": "Nik",
        //   "password": "123456",
        // });
        print(response['body']['data']);
        if (response != null) {
          final status = response['body']['status'];
          final msg = response['body']['msg'];

          if (status == 200) {
            SnackBarMessage(context, true, msg);
            Navigator.pushReplacementNamed(context, '/AdminHome');
          } else if (status == 500) {
            SnackBarMessage(context, false, "Internal Server Error");
          } else {
            SnackBarMessage(context, false, msg.toString());
          }
        } else {
          SnackBarMessage(context, false, "No response from the server");
        }
      } catch (error) {
        print(error);
        SnackBarMessage(context, false, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Correctly assigned the key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Admin Login",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _loginAdmin,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Access restricted to Admins only",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
