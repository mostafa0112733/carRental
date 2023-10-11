// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gocar/signup.dart';



class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text;

      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        User? user = userCredential.user;

        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => UploadCarForRent()));
      } else {
        // Handle invalid input
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid email and password.'),
          ),
        );
      }
    } catch (e) {
      // Handle login errors
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
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
                  'Welcome',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 50.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
                TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
           
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Log In'),
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
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text("Don't Have Account?Sign Up"),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
