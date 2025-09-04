import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'main.dart'; // Import your main app file
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  final bool isLoggedIn;

  const SplashPage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'images/Flogo.jpg',
        width: 150,
        height: 150,
      ),
      title: const Text(
        "My App",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.deepPurple,
      showLoader: true,
      loaderColor: Colors.white,
      loadingText: const Text(
        "Loading...",
        style: TextStyle(color: Colors.white70),
      ),
      navigator: isLoggedIn
          ? const MyHomePage()  // ✅ Use const
          : const LoginPage(),   // ✅ Already const
      durationInSeconds: 3,
    );
  }
}
