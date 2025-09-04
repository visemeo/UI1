import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purple[900],
      ),
      body: Center(
        child: ElevatedButton(// shadow
          onPressed: () {
            // Example: Go to HomePage after login
            Navigator.pushReplacementNamed(context, '/home');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // button background
            foregroundColor: Colors.white,      // text (and icon) color
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // rounded corners
            ),
            elevation: 5, // shadow
          ),
          child: const Text("Login",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
