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
  double value = 0.0;
  late List<String> li;
  String titleText = 'Flutter Demo';

  @override
  void initState() {
    super.initState();
    li = List<String>.generate(20, (index) => "Item number ${index+1}");
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
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const SizedBox(height: 10),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              percent: 0.8,
              header: const Text("Icon header"),
              center: const Icon(
                Icons.person_pin,
                size: 50.0,
                color: Colors.blue,
              ),
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
            const SizedBox(height: 10),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: 0.8,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 10),
            CircularPercentIndicator(
              radius: 130.0,
              animation: true,
              animationDuration: 1200,
              lineWidth: 15.0,
              percent: value,
              center: const Text(
                "40 hours",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: Colors.yellow,
              progressColor: Colors.red,
            ),
            Slider(value: value, onChanged: (value) => setState(() => this.value = value)),
            const SizedBox(height: 10),
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: 0.7,
              center: const Text(
                "70.0%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: const Text(
                "Sales this week",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.purple,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: 1.0,
                center: const Text("100%"),
                progressColor: Colors.green,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.10,
                      center: const Text("10%"),
                      progressColor: Colors.red,
                    ),
                    const SizedBox(width: 10.0),
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.30,
                      center: const Text("30%"),
                      progressColor: Colors.orange,
                    ),
                    const SizedBox(width: 10.0),
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.60,
                      center: const Text("60%"),
                      progressColor: Colors.yellow,
                    ),
                    const SizedBox(width: 10.0),
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.90,
                      center: const Text("90%"),
                      progressColor: Colors.green,
                    ),
                    // You can add more indicators here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
