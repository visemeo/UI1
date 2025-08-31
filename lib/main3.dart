import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  // Colors
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  // Track if dialog should be shown (not used directly; button triggers it)
  void openColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) => setState(() => pickerColor = color),
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                // Finalize the color
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop(); // Close dialog
                _showSnackbar("Color changed!");
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String titleText = 'Flutter Demo';

  final List<String> _defaultImages = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg'
  ];

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.pink,
      action: SnackBarAction(
        label: "Undo",
        textColor: Colors.white,
        onPressed: () {
          setState(() {
            currentColor = const Color(0xff443a49); // Reset to default
          });
        },
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
              widget.onThemeChanged(widget.themeMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light);
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
            _showSnackbar("Title changed to '$titleText'");
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
        padding: const EdgeInsets.all(16),
        children: [
          // Color Picker Button
          ElevatedButton.icon(
            icon: const Icon(Icons.color_lens),
            label: const Text("Pick a Color"),
            onPressed: openColorPicker,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[100],
            ),
          ),
          const SizedBox(height: 20),
          // Preview Selected Color
          Container(
            height: 100,
            width: double.infinity,
            color: currentColor,
            alignment: Alignment.center,
            child: Text(
              "Selected Color",
              style: TextStyle(
                color: currentColor.computeLuminance() < 0.5 ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
