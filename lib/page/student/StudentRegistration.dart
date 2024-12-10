import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/material.dart';

class StudentRegistration extends StatefulWidget {
  @override
  _StudentRegistrationState createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _rollnoController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _registerAndNavigate() async {
    String name = _nameController.text.trim();
    String mobile = _mobileController.text.trim();
    String email = _emailController.text.trim();
    String department = _departmentController.text.trim();

    String Password = _PasswordController.text.trim();
    String rollno = _rollnoController.text.trim();

    try {
      if (name.isNotEmpty &&
          mobile.isNotEmpty &&
          email.isNotEmpty &&
          department.isNotEmpty &&
          Password.isNotEmpty &&
          rollno.isNotEmpty) {
        final response = await setStudentRegister({
          "rollno": rollno,
          "name": name,
          "department": department,
          "mobile": mobile,
          "email": email,
          "password": Password
        });
        if (response != null) {
          final status = response['body']['status'];
          final msg = response['body']['msg'];
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
      SnackBarMessage(context, false, error.toString());
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
          "Student Register",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal, // Changed color
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 15),
                // Registration Form
                _buildTextField("Name", Icons.person, _nameController),
                SizedBox(height: 15),
                _buildTextField(
                    "Mobile Number", Icons.phone, _mobileController),
                SizedBox(height: 15),
                _buildTextField("Email ID", Icons.email, _emailController),
                SizedBox(height: 15),
                _buildTextField(
                    "Department", Icons.apartment, _departmentController),
                SizedBox(height: 15),
                _buildTextField("Roll No", Icons.school, _rollnoController),
                SizedBox(height: 15),
                TextField(
                  controller: _PasswordController,
                  obscureText: _obscureText,
                  obscuringCharacter: "*",
                  autocorrect: true,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: "Password",
                    counterText: "",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.teal,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.teal,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.teal, width: 2.0), // Focused border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.grey, width: 1.0), // Default border
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _registerAndNavigate,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.teal,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/StudentLogin');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Footer (Pati) Section
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Text(
                      "By registering, you agree to our terms and conditions.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
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
        labelStyle: TextStyle(color: Colors.grey), // Default label color
        prefixIcon: Icon(
          icon,
          color: Colors.teal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(color: Colors.teal, width: 2.0), // Focused border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(color: Colors.grey, width: 1.0), // Default border
        ),
      ),
      style: TextStyle(color: Colors.black), // Text color
    );
  }
}
