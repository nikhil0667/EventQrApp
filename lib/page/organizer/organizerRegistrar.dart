import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/material.dart';

class OrganizerRegistration extends StatefulWidget {
  @override
  _OrganizerRegistrationState createState() => _OrganizerRegistrationState();
}

class _OrganizerRegistrationState extends State<OrganizerRegistration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
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
    String Password = _PasswordController.text.trim();

    try {
      if (name.isNotEmpty &&
          mobile.isNotEmpty &&
          email.isNotEmpty &&
          Password.isNotEmpty) {
        final response = await setOrganizerRegister({
          "name": name,
          "email": email,
          "mobile": mobile,
          "password": Password,
        });
        print(response);
        if (response != null) {
          final status = response['body']['status'];
          final msg = response['body']['msg'];
          if (status == 200) {
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
            "Organizer Register",
            style: TextStyle(color: Color(0xffFFFFFF)),
          ),
          backgroundColor: Colors.blue // Updated to green
          ),
      backgroundColor: Colors.white, // Updated background color
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header with Arrow and Title
                SizedBox(height: 40),

                // Registration Form (Name, Email, Mobile, Password)
                _buildTextField("Name", Icons.person, _nameController),
                SizedBox(height: 15),
                _buildTextField(
                    "Mobile Number", Icons.phone, _mobileController),
                SizedBox(height: 15),
                _buildTextField("Email ID", Icons.email, _emailController),
                SizedBox(height: 15),
                TextField(
                  controller: _PasswordController,
                  obscureText: _obscureText,
                  obscuringCharacter: "*",
                  maxLength: 6,
                  decoration: InputDecoration(
                    counterText: "",
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
                SizedBox(height: 30),

                // Submit Button with updated color
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _registerAndNavigate,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue, // Updated to green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Link to Login Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Organizerlogin');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Footer (Terms and Conditions)
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
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
