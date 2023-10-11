import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gocar/authmodel.dart';
import 'package:gocar/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  final AuthModel _authModel = AuthModel();
  
  String emailError = "";
  String passwordError = "";
  String nameError = "";
  String phoneError = "";

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool validateEmail(String email) {
    if (email.contains('@')) {
      setState(() {
        emailError = "";
      });
      return true;
    } else {
      setState(() {
        emailError = "Invalid email address";
      });
      return false;
    }
  }

  bool validatePassword(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{8,20}$');
    if (regex.hasMatch(password)) {
      setState(() {
        passwordError = "";
      });
      return true;
    } else {
      setState(() {
        passwordError = "Password must contain at least one uppercase letter, one lowercase letter, and be between 8 and 20 characters.";
      });
      return false;
    }
  }

 

 bool validatePhone(String phone) {
    if (phone.length == 11 && int.tryParse(phone) != null) {
      setState(() {
        phoneError = "";
      });
      return true;
    } else {
      setState(() {
        phoneError = "Phone number must be exactly 11 digits (numbers only).";
      });
      return false;
    }
  }

  void _handleSignUp() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String name = nameController.text.trim();
    final String phone = phoneController.text.trim();

    if (validateEmail(email) && validatePassword(password)  && validatePhone(phone)) {
      User? user = await _authModel.signUpWithEmailAndPassword(
        email,
        password,
        name,
        phone,
      );

      if (user != null) {
        print('User registration successful: ${user.displayName}');
      } else {
        print('User registration failed.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 200),
                child: 
                Text(
                  'Create Account',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 50.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              // Text(emailError, style: TextStyle(color: Colors.red)),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              // Text(passwordError, style: TextStyle(color: Colors.red)),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              Text(phoneError, style: TextStyle(color: Colors.red)),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _handleSignUp,
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LogIn()),
                  );
                },
                child: Text("Already have an account? Log In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
