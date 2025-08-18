import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.normal),
          headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal),
          bodyLarge: TextStyle(fontSize: 16.0),
          labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),

      ),

      home: const MyHomePage(),
      builder: FlashyFlushbarProvider.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String str = 'Flutter Demo';
  List imgList = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100,
              leading: Padding(
                padding: const EdgeInsets.all(1),
                child: Row(
                  children: [
                        IconButton(onPressed: (){},
                        icon: const Icon(Icons.account_circle,size: 35,color: Colors.white,),),
                  ],
                ),
              ),
              actions: [
                IconButton(onPressed: (){},
                  icon: const Icon(Icons.add_card,size: 35,color: Colors.white,),)
              ],
              flexibleSpace:  Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors:[
                        Colors.deepPurpleAccent,
                        Colors.pink,
                        Colors.deepPurpleAccent,
                      ] ),
                ),
              ),
              //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              centerTitle: true,
              title:  Text(str,style: TextStyle(
                  fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white
              ),),
            ),
            SliverList(delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text('Slider 1 :Initial page index',textAlign: TextAlign.center,),
                    CarouselSlider(
                      options: CarouselOptions(height: 180,initialPage: 0,),
                      items: imgList.map((imageUrl) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(imageUrl, fit: BoxFit.fill,),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10,),

                    CarouselSlider(
                      options: CarouselOptions(height: 150.0),
                      items: imgList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.amber
                                ),
                              child: Image.asset(i , fit: BoxFit.fill,),
                            );
                          },
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: ElevatedButton(
                      onPressed: (){
                    buildDialog(context);
                  },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent, // Set your desired background color here
                      ),
                      child:Text('Click AlertDialog',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),) ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        str = ' ';
                      });
                      buildSnackbar(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent, // Set your desired background color here
                    ),
                    child: Text('Click SnackBar',style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: ElevatedButton(
                      onPressed: (){
                        buildFlashbar();
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink, // Set your desired background color here
                      ),
                      child: Text('Click FlashBar',style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SelectableText('Lorem ipsum dolor sit amet',showCursor: true,
                    ),
                    Container(
                      width: 200,
                      height: 40,
                      color: Colors.lightGreenAccent,
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                      overflow: TextOverflow.clip,
                      softWrap: false,),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 200,
                      height: 40,
                      color: Colors.lightGreenAccent,
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 200,
                      height: 40,
                      color: Colors.lightGreenAccent,
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                          overflow: TextOverflow.fade),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 200,
                      height: 40,
                      color: Colors.lightGreenAccent,
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                          overflow: TextOverflow.visible),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ]))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showToast('This is normal toast with animation',
              context: context,
              animation: StyledToastAnimation.scale,
              reverseAnimation: StyledToastAnimation.fade,
              position: StyledToastPosition(align: Alignment.bottomCenter, offset: 100.0),
              animDuration: Duration(seconds: 1),
              duration: Duration(seconds: 4),
              curve: Curves.elasticOut,
              reverseCurve: Curves.linear,
            );
          },
        tooltip: 'Increment',
        child: const Icon(Icons. add),
      ),
    );

  }

  void buildFlashbar() {
    FlashyFlushbar
      (
      backgroundColor: Colors.tealAccent,
      leadingWidget: const Icon(
        Icons.error_outline,
        color: Colors.black,
        size: 24,
      ),
      message: 'Hello from Flashy Flushbar',
      duration: const Duration(seconds: 3),
      trailingWidget: IconButton(
        icon: const Icon(
          Icons.close,
          color: Colors.black,
          size: 24,
        ),
        onPressed: () {
          FlashyFlushbar.cancel();
        },
      ),
      isDismissible: false,
    ).show(
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

  void buildDialog(BuildContext context) {
           final AlertDialog alert = AlertDialog(
      title: Text('Alert'),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Divider(color: Colors.black,),
            Text('Dialog text appear here you can tap anything you want'),
            SizedBox(height: 7,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent, // Set your desired background color here
                ),
                  child: Text('Close!',style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),),),
            ),
          ],
        ),
      )
    );
     showDialog(context: context,barrierDismissible: false, builder: (BuildContext ctx){
       return alert;
     });
  }
  Text buildText(){
    return Text('You have pushed the button many time:');
  }
}

