import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          body: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin<MyHomePage> {
  AnimationController controller;
  Animation flipStart;
  Animation flipFinish;
  Animation elevationDown;
  IconData icon = Icons.visibility;
  double scaleSize = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: <Widget>[
          Container(
            height: 500 * (1 - controller.value),
          ),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
      Center(
        child: GestureDetector(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.rotationY(flipStart.value)
                  ..scale(1 + scaleSize * 0.05),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  shadowColor: Colors.black,
                  elevation: elevationDown.value,
                  child: Icon(
                    icon,
                    size: 100,
                  ),
                ),
              );
            },
          ),
          onTap: () {
            controller.forward();
          },
        ),
      ),
    ]);
  }

  Future<void> elevateDown() async {
    await controller.animateBack(0.0);
    await controller.forward(from: 0.7);
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 6), vsync: this);

    flipStart = Tween(begin: 0.0, end: 2 * pi).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.4, curve: Curves.bounceIn)))
      ..addListener(() {
        if (controller.value >= 0.4 && controller.value < 0.5) {
          elevateDown();
        }
        if (controller.value >= 0.6) {
          scaleSize = 0;
        } else
          scaleSize = flipStart.value;
      });
    elevationDown = Tween(begin: 15.0, end: 0.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.7, 1, curve: Curves.ease)));
  }

  // Dispose controller to prevent resources overuse
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
