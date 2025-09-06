import 'package:flutter/material.dart';
import 'package:ui/P_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? repeat = prefs.getBool('repeat');
  Widget _screen = (repeat==false || repeat==null)?const PView():const MyHomePage();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _screen,
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // added const constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
      ),
      home: const MyHomePage(), // ✅ fixed
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key}); // added const for consistency

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
          onTap: () {
            setState(() {
              titleText =
              titleText == 'Flutter Demo' ? 'Tapped!' : 'Flutter Demo';
            });
          },
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
        children: const [
          SizedBox(height: 20),
          Center(
            child: Text(
              "Hello Flutter!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
