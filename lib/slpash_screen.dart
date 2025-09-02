import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_splash_screen.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool? isLoggedIn = prefs.getBool('X');

  runApp(
      MaterialApp(
        home: SplashPage(isLoggedIn: isLoggedIn ?? false),
        routes: {
          '/home': (context) => MyHomePage(
            themeMode: ThemeMode.light,
            onThemeChanged: (mode) {},
          ),
          '/login': (context) => const LoginPage(),
        },
       )
  );
}

class MyHomePage extends StatefulWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) onThemeChanged;

  const MyHomePage({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String titleText = 'Flutter Demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.account_circle, size: 35, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => widget.onThemeChanged(
              widget.themeMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light,
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.pink,
                Colors.deepPurpleAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        title: GestureDetector(
          onTap: () => setState(() =>
          titleText = titleText == 'Flutter Demo' ? 'Tapped!' : 'Flutter Demo'),
          child: Text(
            titleText,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
