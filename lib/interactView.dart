import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeMode,
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
      home: MyHomePage(
        themeMode: themeMode,
        onThemeChanged: (mode) {
          setState(() {
            themeMode = mode;
          });
        },
      ),
    );
  }
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
            onPressed: () {
              widget.onThemeChanged(
                widget.themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.pink,
                Colors.deepPurpleAccent
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
              titleText = titleText == 'Flutter Demo' ? 'Tapped!' : 'Flutter Demo';
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
      body:Center(
        child: Container(
          height: 500,
          width: double.infinity,
          child: InteractiveViewer(
            constrained: false,
            scaleEnabled: false,
              maxScale: 2,
              minScale: 0.5,
              child: Image.asset('images/sea.jpg', fit: BoxFit.cover )),
        ),
      )
    );
  }
}
