import 'package:flutter/material.dart';
import 'dart:io';
import 'package:marquee/marquee.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker picker = ImagePicker();
  List<File> _imageFiles = [];

  // For carousel
  int _currentIndex = 0;

  // Default fallback images if no picked
  final List<String> _defaultImages = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg'
  ];

  // Get list of image widgets (from picked files or assets)
  List<Widget> get _imageWidgets {
    if (_imageFiles.isEmpty) {
      return _defaultImages
          .map((path) => Image.asset(path, fit: BoxFit.cover))
          .toList();
    } else {
      return _imageFiles
          .map((file) => Image.file(file, fit: BoxFit.cover))
          .toList();
    }
  }

  // Handle picking multiple images from gallery
  Future<void> _pickImages() async {
    final List<XFile>? picked = await picker.pickMultiImage();
    if (picked != null && picked.isNotEmpty) {
      setState(() {
        _imageFiles = picked.map((xFile) => File(xFile.path)).toList();
      });
      _showSnackbar("Images picked!", undoAction: () {
        setState(() {
          _imageFiles.clear();
        });
      });
    }
  }

  // Pick single image from camera
  Future<void> _takePicture() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _imageFiles.add(File(photo.path));
      });
      _showSnackbar("Picture taken!", undoAction: () {
        setState(() {
          _imageFiles.removeLast();
        });
      });
    }
  }

  // Handle error from image picker
  void _handleError(Exception error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Error: $error")));
  }

  // Snackbar helper
  void _showSnackbar(String message, {VoidCallback? undoAction}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.pink,
      action: undoAction != null
          ? SnackBarAction(
        label: "Undo",
        textColor: Colors.white,
        onPressed: undoAction,
      )
          : null,
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
            icon: const Icon(Icons.add_a_photo, size: 35, color: Colors.white),
            onPressed: _takePicture,
          ),
          IconButton(
            icon: const Icon(Icons.collections, size: 35, color: Colors.white),
            onPressed: _pickImages,
          ),
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
              colors: [Colors.deepPurpleAccent, Colors.pink, Colors.deepPurpleAccent],
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
          // Marquee Examples
          const SizedBox(height: 15),
          SizedBox(
            height: 70,
            child: Card(
              color: Colors.teal,
              child: Marquee(
                text: 'Scrolling horizontally... Welcome to Flutter!',
                style: const TextStyle(color: Colors.white, fontSize: 18),
                blankSpace: 100,
                velocity: 50,
                scrollAxis: Axis.horizontal,
                pauseAfterRound: const Duration(seconds: 1),
                accelerationDuration: const Duration(milliseconds: 500),
                accelerationCurve: Curves.linear,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 70,
            child: Card(
              color: Colors.teal,
              child: Marquee(
                text: 'Vertical Scroll!\nLine 2\nLine 3',
                style: const TextStyle(color: Colors.white, fontSize: 18),
                blankSpace: 20,
                scrollAxis: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                pauseAfterRound: const Duration(seconds: 2),
                velocity: 30,
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Image Carousel
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: _imageWidgets,
                ),
                Positioned(
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _imageWidgets.asMap().entries.map((entry) {
                      return Container(
                        width: _currentIndex == entry.key ? 16 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: _currentIndex == entry.key
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          // Buttons for picking images
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Take Photo"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              ),
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.image),
                label: const Text("Pick Images"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
