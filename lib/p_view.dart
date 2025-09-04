
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui/main.dart';
import 'main_splash_screen.dart';

class Data {
  final String title;
  final String subtitle;
  final String image;
  final IconData iconData;

  Data({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.iconData,
  });
}

class PView extends StatefulWidget {
  const PView({super.key});

  @override
  State<PView> createState() => _PViewState();
}

class _PViewState extends State<PView> {

  final PageController _controller = PageController(
    initialPage: 0,
  );
  late Timer _timer;
  int _currentIndex = 0;

  final List<Data> myData = <Data>[
    Data(
        title: 'SPRING',
        subtitle: 'Spring Landscape',
        image: 'images/spring.jpg',
        iconData: Icons.sunny),
    Data(
        title: 'WINTER',
        subtitle: 'Winter Landscape',
        image: 'images/winter.jpg',
        iconData: Icons.snowing),
    Data(
        title: 'AUTUMN',
        subtitle: 'Autumn Landscape',
        image: 'images/autumn.jpg',
        iconData: Icons.wind_power),
  ];
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < myData.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/main': (ctx) => const MyHomePage(),
        '/main_splash_screen': (ctx) =>
        const SplashPage(isLoggedIn: false), // ✅ required param
      },
      home: Scaffold(
        body: Stack(
          children: [
            Builder(builder: (ctx) =>PageView(
              controller: _controller,
              children: myData
                  .map(
                    (item) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.iconData,
                          size: 100, color: Colors.grey[700]),
                      const SizedBox(height: 50),
                      Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900]),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900]),
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
              onPageChanged: (val){
                setState(() {
                  _currentIndex = val;
                  if(_currentIndex == 2) {
                    Future . delayed(Duration(seconds: 1),() =>Navigator.of(ctx).pushNamed('/main') );}
                });
              },
            ), ),
            Align(
              alignment: const Alignment(0, 0.75),
              child:Indicator(_currentIndex),
            ),
            Builder(
              builder:(ctx) => Align(
                alignment: const Alignment(0, 0.93),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pushNamed('/main'); // ✅ fixed
                    },
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;
  const Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildIndicator(index == 0 ?Colors.green: Colors.redAccent),
        buildIndicator(index == 1 ?Colors.green: Colors.redAccent),
        buildIndicator(index == 2 ?Colors.green: Colors.redAccent),
      ],
    );
  }

  Container buildIndicator(Color color) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
