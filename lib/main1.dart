import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(const MyHomePage());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData( // Dark Theme
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
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.normal),
          headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal),
          bodyLarge: TextStyle(fontSize: 16.0),
          labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
        primaryColor: Colors.blue, canvasColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),

      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  var str ='Demo flutter';
  late int _currentIndex = 0;
  List imgList = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg',
  ];
  int _radioVal = 0;
  int _radioValue = 0;
  late String result ;
  late Color resultColor;

  bool js = false;
  bool csharp = false;
  bool python = false;

  ThemeMode tm = ThemeMode.light ;
  bool switchVal = false;

  String? selectedLetter;
  List <String> letterList = ['A','B','C','D','E','F','G'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: tm,
      darkTheme: ThemeData( // Dark Theme
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
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.normal),
          headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal),
          bodyLarge: TextStyle(fontSize: 16.0),
          labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
        primaryColor: Colors.blue, canvasColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),

      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(1),
            child: Row(
              children: [
                IconButton(onPressed: () {},
                  icon: const Icon(
                    Icons.account_circle, size: 35, color: Colors.white,),),
              ],
            ),
          ),
          actions: [
            IconButton(onPressed: () {},
              icon: const Icon(Icons.add_card, size: 35, color: Colors.white,),)
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.deepPurpleAccent,
                    Colors.pink,
                    Colors.deepPurpleAccent,
                  ]),
            ),
          ),
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: Text(str, style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white
          ),),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 30,),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    onPageChanged: (index,_){
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
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber
                          ),
                          child: Image.asset(i, fit: BoxFit.fill,),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer(0),
                    buildContainer(1),
                    buildContainer(2),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50,),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ExpansionTile(
                  title: Text('Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  children: [
                    Divider(color: Colors.grey,),
                    ListTile(
                        title: Text('Sign up',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Text('Where are you can sign from'),
                        onTap:(){
                          setState(() {
                            str = 'sing up';
                            buildSnackbar(context);
                          });
                        }
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 50,),
            buildDropDownButton(),
            buildSwitch(),
            buildCheckbox(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Guess the answer 2+2=?',
                    style:Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.lightBlue),),
                  buildRow(3),
                  buildRow(4),
                  buildRow(5),
                ],
              ),
            ),
            Container(
              color:_radioVal==0?Colors.teal:Colors.brown,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  buildRadioListTile(0,'teal','change bg to teal'),
                  buildRadioListTile(1,'brown','change bg to brown'),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
  void buildSnackbar(BuildContext context) {
    final sBar = SnackBar(
      action: SnackBarAction(
          textColor: Colors.white,
          label:"Undo!" ,
          onPressed: (){
            setState(() {
              str = 'Flutter Demo';
            });
          }),
      content:Text('This is snackBar text'),
      duration: Duration(milliseconds: 3000),
      backgroundColor: Colors.pink,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(sBar);
  }

  Padding buildDropDownButton() {
    return Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Select a Letter : ', style: TextStyle(fontSize: 25),),
                DropdownButton<String>(
                  hint: Text('selected letter'),
                  value: selectedLetter ,
                    items:  letterList.map((String letter) {
                      return DropdownMenuItem<String>(
                        value: letter,
                        child: Text(letter, style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent)),
                      );
                    }).toList(),
                    onChanged: (newVal){
                    setState(() => selectedLetter = newVal!);
                    })
              ],
            ),
          );
  }

  Padding buildSwitch() {
    return Padding(
            padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Light',style: TextStyle(fontSize: 20)),
                  ),
                  Switch(
                      value:switchVal ,
                      onChanged: (val){
                        setState(() {
                          switchVal = val;
                          if(switchVal== false){tm = ThemeMode.light;}
                          else{tm = ThemeMode.dark;}
                        });
                      },
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.blueGrey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Dark',style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
          );
  }

  Padding buildCheckbox(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            Text('Choose all the programming language you know ?',
            style: Theme.of(context).textTheme.headlineMedium ,),
            Row(
              children: [
                Checkbox(
                    value: js,
                    onChanged: (value){
                      setState(() {
                        js = value! ;
                      });
                    }),
                Text('js'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: python,
                    onChanged: (value){
                      setState(() {
                        python = value! ;
                      });
                    }),
                Text('python'),
              ],
            ),

            CheckboxListTile(
                value: csharp,
                onChanged: (value){
                  setState(() {
                    csharp = value! ;
                  });
                },
              title: Text('csharp'),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Your Selected Languages"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (js) Text("JavaScript"),
                        if (python) Text("Python"),
                        if (csharp) Text("C#"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Apply'),
            ),

          ],),
        );
  }

  RadioListTile<dynamic> buildRadioListTile(val,txt,subTxt) {
    return RadioListTile(
                  value: val,
                  controlAffinity: ListTileControlAffinity.leading,
                  groupValue:_radioVal ,
                  onChanged: (value) {
                    setState(() {
                      _radioVal = value;
                    });
                  },
                  title:Text(txt,style:Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),),
                  subtitle: Text(subTxt,style:Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),),
              );
  }
  myDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Result"),
        content: Text(
          message,
          style: TextStyle(color: color, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
  Row buildRow(int value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _radioValue,
          onChanged: (val) {
            setState(() {
              _radioValue = val!;

              // ✅ Use assignment (=) instead of comparison (==)
              if (_radioValue == 4) {
                result = 'Correct answer';
                resultColor = Colors.green;
              } else {
                result = 'Wrong answer';
                resultColor = Colors.red;
              }

              myDialog(result, resultColor);
            });
          },
        ),
        Text(
          '$value',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
  Container buildContainer(index) {
    return Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:_currentIndex==index? Colors.deepPurple:Colors.pink,
            ),
          );
  }
}

Please write in English language.
