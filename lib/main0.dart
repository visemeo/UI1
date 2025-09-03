
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
textTheme: const TextTheme(
bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
),
),
theme: ThemeData(
primaryColor: Colors.blue,
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

// Carousel
int _currentIndex = 0;
final List<String> imgList = ['images/s1.jpg', 'images/s2.jpg', 'images/s3.jpg'];

// Dropdown
String selectedLetter = 'A';
List<String> letterList = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

// Checkboxes
Map<String, bool> languages = {
"JavaScript": false,
"Python": false,
"C#": false,
};

// Quiz
int? quizAnswer;
String quizResult = "";

// RadioListTile background
Color? selectedColor;

// Snackbar
void buildSnackbar(BuildContext context) {
final sBar = SnackBar(
action: SnackBarAction(
textColor: Colors.white,
label: "Undo!",
onPressed: () {
setState(() {
titleText = 'Flutter Demo';
});
},
),
content: const Text('This is snackBar text'),
duration: const Duration(milliseconds: 3000),
backgroundColor: Colors.pink,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(30),
),
);
ScaffoldMessenger.of(context).showSnackBar(sBar);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
leading: const Padding(
padding: EdgeInsets.all(1),
child: Icon(Icons.account_circle, size: 35, color: Colors.white),
),
actions: const [
Icon(Icons.add_card, size: 35, color: Colors.white),
],
flexibleSpace: Container(
decoration: const BoxDecoration(
gradient: LinearGradient(
colors: [
Colors.deepPurpleAccent,
Colors.pink,
Colors.deepPurpleAccent,
],
),
),
),
centerTitle: true,
title: Text(
titleText,
style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
),
),
body: ListView(
children: [
const SizedBox(height: 30),

// Carousel
CarouselSlider(
options: CarouselOptions(
height: 180.0,
autoPlay: true,
autoPlayInterval: const Duration(seconds: 3),
onPageChanged: (index, _) {
setState(() {
_currentIndex = index;
});
},
),
items: imgList.map((i) {
return Builder(
builder: (BuildContext context) {
return Container(
width: MediaQuery.of(context).size.width,
margin: const EdgeInsets.symmetric(horizontal: 5.0),
child: Image.asset(i, fit: BoxFit.fill),
);
},
);
}).toList(),
),
const SizedBox(height: 10),

// Carousel indicators
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: imgList.asMap().entries.map((entry) {
return Container(
width: 10.0,
height: 10.0,
margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
decoration: BoxDecoration(
shape: BoxShape.circle,
color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
),
);
}).toList(),
),
const SizedBox(height: 20),

// ExpansionTile
ListView(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
children: [
ExpansionTile(
  backgroundColor: Colors.lightBlueAccent,
  leading: Icon(Icons.perm_identity),
title: const Text('Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
children: [
const Divider(color: Colors.grey),
Card(
  color: Colors.cyanAccent,
  child: ListTile(
    leading: Icon(Icons.account_circle),
    trailing:Icon(Icons.arrow_drop_down) ,
  title: const Text('Sign up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  subtitle: const Text('Where you can sign up from'),
  onTap: () {
  setState(() {
  titleText = 'Sign up';
  buildSnackbar(context);
  });
  },
  ),
),
  Card(
    color: Colors.cyanAccent,
    child: ListTile(
      leading: Icon(Icons.add),
      trailing:Icon(Icons.arrow_drop_down) ,
      title: const Text('Sign in', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      subtitle: const Text('Where you can sign in from'),
      onTap: () {
        setState(() {
          titleText = 'Sign in';
          buildSnackbar(context);
        });
      },
    ),
  ),
],
)
],
),

const SizedBox(height: 20),

// Dropdown
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Text('Select A Letter', style: TextStyle(fontSize: 25)),
const SizedBox(width: 10),
DropdownButton<String>(
value: selectedLetter,
items: letterList.map((String letter) {
return DropdownMenuItem<String>(
value: letter,
child: Text(letter),
);
}).toList(),
onChanged: (newVal) {
setState(() => selectedLetter = newVal!);
},
),
],
),

const SizedBox(height: 20),

// Theme switch
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
  const Text("Light Mode",style: TextStyle(fontSize: 20),),
Switch(
value: widget.themeMode == ThemeMode.dark,
onChanged: (val) {
widget.onThemeChanged(val ? ThemeMode.dark : ThemeMode.light);
},
),
  const Text("Dark Mode",style: TextStyle(fontSize: 20),),
],
),

const SizedBox(height: 20),

// Checkboxes
Column(
children: languages.keys.map((String key) {
return CheckboxListTile(
title: Text(key),
value: languages[key],
onChanged: (bool? value) {
setState(() {
languages[key] = value ?? false;
});
},
);
}).toList(),
),
ElevatedButton(
onPressed: () {
var selectedLanguages =
languages.entries.where((e) => e.value).map((e) => e.key).join(", ");
showDialog(
context: context,
builder: (_) => AlertDialog(
title: const Text("Selected Languages"),
content: Text(selectedLanguages.isNotEmpty ? selectedLanguages : "None"),
),
);
},
child: const Text("Apply"),
),

const SizedBox(height: 20),

// Quiz
Column(
children: [
const Text("Quiz: 2 + 2 = ?", style: TextStyle(fontSize: 18)),
RadioListTile<int>(
title: const Text("3"),
value: 3,
groupValue: quizAnswer,
onChanged: (val) {
setState(() {
quizAnswer = val;
quizResult = "Wrong answer";
});
},
),
RadioListTile<int>(
title: const Text("4"),
value: 4,
groupValue: quizAnswer,
onChanged: (val) {
setState(() {
quizAnswer = val;
quizResult = "Correct answer";
});
},
),
Text(
quizResult,
style: TextStyle(
fontSize: 18,
color: quizResult == "Correct answer" ? Colors.green : Colors.red,
),
),
],
),

const SizedBox(height: 20),

// RadioListTiles for background color
Column(
children: [
RadioListTile<Color>(
title: const Text("Teal"),
value: Colors.teal,
groupValue: selectedColor,
onChanged: (val) {
setState(() {
selectedColor = val;
});
},
),
RadioListTile<Color>(
title: const Text("Brown"),
value: Colors.brown,
groupValue: selectedColor,
onChanged: (val) {
setState(() {
selectedColor = val;
});
},
),
Container(
height: 100,
width: double.infinity,
color: selectedColor ?? Colors.grey,
child: const Center(
child: Text("Background Preview"),
),
),
],
),
],
),
);
}
}
