import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/shared_Preference.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/material.dart';

class OrganizerLogin extends StatefulWidget {
  const OrganizerLogin({super.key});

  @override
  State<OrganizerLogin> createState() => _OrganizerLoginState();
}

class _OrganizerLoginState extends State<OrganizerLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // Password visibility control

  // Function to toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Dummy Organizer credentials (replace with real authentication logic)
  Future<void> _loginOrganizer() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await setOrganizerLogin({
          "email": _emailController.text.toString(),
          "password": _passwordController.text.toString(),
        });
        print(response);
        if (response != null) {
          final status = response['body']['status'];
          final msg = response['body']['msg'];

          if (status == 200) {
            SetPreference('organizer_token',
                response['body']['body']['organizer']['token']);
            SnackBarMessage(context, true, msg);
            Navigator.pushReplacementNamed(context, '/OrganizerHome');
          } else if (status == 500) {
            SnackBarMessage(context, false, "Internal Server Error");
          } else {
            SnackBarMessage(context, false, msg.toString());
          }
        } else {
          SnackBarMessage(context, false, "No response from the server");
        }
      } catch (error) {
        SnackBarMessage(context, false, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          title: Text(
            "Organizer Login",
            style: TextStyle(color: Color(0xffFFFFFF)),
          ),
          backgroundColor: Colors.blue // Updated to green
          ),
      backgroundColor: Colors.white,
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
                    "Organizer Login", // Changed title text
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue // Updated to green
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Colors.blue, width: 2.0), // Focused border
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Colors.grey, width: 1.0), // Default border
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    maxLength: 6,
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed:
                            _togglePasswordVisibility, // Toggle visibility
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Colors.blue, width: 2.0), // Focused border
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Colors.grey, width: 1.0), // Default border
                      ),
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
                    onPressed: _loginOrganizer,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue, // Updated to green
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You don't have an account? ",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/OrganizerRegistration');
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
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
