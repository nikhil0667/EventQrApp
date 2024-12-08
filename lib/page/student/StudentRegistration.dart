import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/material.dart';
import 'StudentLogin.dart';
// Import the HomePage class

class StudentRegistration extends StatefulWidget {
  @override
  _StudentRegistrationState createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _rollnoController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Toggle the obscured text state
    });
  }

  void _registerAndNavigate() async {
    String name = _nameController.text.trim();
    String mobile = _mobileController.text.trim();
    String email = _emailController.text.trim();
    String department = _departmentController.text.trim();
    String division = _divisionController.text.trim();
    String Password = _PasswordController.text.trim();
    String rollno = _rollnoController.text.trim();

    try {
      if (name.isNotEmpty &&
          mobile.isNotEmpty &&
          email.isNotEmpty &&
          department.isNotEmpty &&
          division.isNotEmpty &&
          Password.isNotEmpty &&
          rollno.isNotEmpty) {
        final response = await setStudentRegister({
          "rollno": rollno,
          "name": name,
          "div": division,
          "department": department,
          "mobile": mobile,
          "email": email,
          "password": Password
        });
        print(response['body']);
        if (response != null) {
          final status = response['body']['status'];
          final msg = response['body']['msg'];
          print(status);
          if (status == 201) {
            SnackBarMessage(context, true, msg);
            Navigator.pushReplacementNamed(context, '/StudentHome');
          } else if (status == 500) {
            SnackBarMessage(context, false, "Internal Server Error");
          } else {
            SnackBarMessage(context, false, msg.toString());
          }
        } else {
          SnackBarMessage(context, false, "No response from the server");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all fields.")),
        );
      }
    } catch (error) {
      print(error);
      SnackBarMessage(context, false, error.toString());
    }
  }

  void _navigateToLogin() {
    Navigator.pushNamed(
      context,
      '/StudentLogin',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TextFields for user inputs
                _buildTextField("Name", Icons.person, _nameController),
                SizedBox(height: 10),
                _buildTextField(
                    "Mobile Number", Icons.phone, _mobileController),
                SizedBox(height: 10),
                _buildTextField("Email ID", Icons.email, _emailController),
                SizedBox(height: 10),
                _buildTextField(
                    "Department", Icons.apartment, _departmentController),
                SizedBox(height: 10),
                _buildTextField("Division", Icons.group, _divisionController),
                SizedBox(height: 10),
                TextField(
                  controller: _PasswordController,
                  obscureText: _obscureText,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                _buildTextField("Roll No ", Icons.school, _rollnoController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerAndNavigate,
                  child: Text("Submit"),
                ),
                SizedBox(height: 20),
                // Link to login page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You have already an account? "),
                    GestureDetector(
                      onTap: _navigateToLogin,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
