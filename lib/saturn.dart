import 'package:flutter/material.dart';
import 'dart:math' as Math;

void main() => runApp(Sliver());

class Sliver extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SliverState();
}

class SliverState extends State<Sliver>
    with SingleTickerProviderStateMixin<Sliver> {
  int _step;
  double a = 275;
  double b = 125;
  Animation circleTween;
  AnimationController _controller;

  @override
  Widget build(BuildContext context) => MaterialApp(
          home: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
            )),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.black,
                  expandedHeight: 500.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: EdgeInsets.only(bottom: 10),
                      background: Container(
                          height: 200,
                          width: 200,
                          child: Stack(children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "images/star_sky_bar.jpg",
                                        )))),
                            Column(children: <Widget>[
                              Theme(
                                data: ThemeData(),
                                child: Stepper(
                                  customIcon: _assetImageBuilder(
                                      "images/asteroid.jpg",
                                      20,
                                      BoxFit.cover,
                                      0.0),
                                  onStepTapped: (index) {
                                    setState(() {
                                      _step = index;
                                    });
                                  },
                                  currentStep: _step ?? 0,
                                  controlsBuilder: (BuildContext context,
                                          {VoidCallback onStepContinue,
                                          VoidCallback onStepCancel}) =>
                                      Container(),
                                  steps: [
                                    _stepBuilder(
                                        "Rivne Nuclear Power Plant",
                                        "Engineer",
                                        "images/earth.jpg",
                                        " 09.16 - 04.17",
                                        " 09.16 - 04.17",
                                        BoxFit.fitHeight,
                                        0.0),
                                    _stepBuilder(
                                        "Sigma Software",
                                        "Support and maintanance engineer",
                                        "images/venera.jpg",
                                        " 04.17 - 09.17",
                                        " 04.17 - 09.17",
                                        BoxFit.cover,
                                        0),
                                    _stepBuilder(
                                        "KeepSolid",
                                        "Technical customer support",
                                        "images/jupiter.jpg",
                                        " 01.18 - 04.18",
                                        " 01.18 - 04.18",
                                        BoxFit.fitHeight,
                                        0),
                                    _stepBuilder(
                                        "Comodo Cyber Security",
                                        "Tier 3 Technical Support",
                                        "images/moon.jpg",
                                        " 04.18 - 04.19",
                                        " 04.18 - 04.19",
                                        BoxFit.cover,
                                        0),
                                    _stepBuilder(
                                        "MaxBill Solutions",
                                        "Implementation engineer",
                                        "images/uranium.jpg",
                                        " 04.19 - Present time",
                                        " 04.19 - Present time",
                                        BoxFit.cover,
                                        0),
                                  ],
                                ),
                              )
                            ])
                          ]))),
                )
              ];
            },
            body: Stack(children: <Widget>[
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "images/star_sky_bar.jpg",
                              ))))),
              Center(
                  child: Transform.rotate(
                      angle: Math.pi / 3,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget child) {
                          return Transform(
                              transform: Matrix4.translationValues(
                                  a * Math.cos(circleTween.value),
                                  b * Math.sin(circleTween.value),
                                  0.0),
                              child: _assetImageBuilder(
                                  "images/star.jpg", 30, BoxFit.cover, 0.0));
                        },
                      ))),
              Center(
                  child: Material(
                      shape: CircleBorder(),
                      elevation: 2,
                      child: _assetImageBuilder(
                          "images/saturn.jpg", 100, BoxFit.fitHeight, 1))),
            ])),
      ));

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    circleTween = Tween(begin: 0, end: 2 * Math.pi).animate(_controller);
    _controller.forward();
    _controller.repeat();
  }

  Widget _assetImageBuilder(
          String path, double size, BoxFit fitType, double width) =>
      Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: width),
              image: DecorationImage(
                  fit: fitType,
                  image: AssetImage(
                    path,
                  ))));

  Step _stepBuilder(
          String company,
          String position,
          String companyIcon,
          String responsibilities,
          String workingDates,
          BoxFit iconFit,
          double width) =>
      Step(
          title: Text(company, style: TextStyle(color: Colors.white70)),
          state: StepState.complete,
          isActive: true,
          subtitle: Text(position, style: TextStyle(color: Colors.white70)),
          content: Row(
            children: <Widget>[
              _assetImageBuilder(companyIcon, 50, iconFit, width),
              Container(color: Colors.yellowAccent, width: 5.0),
              Text(responsibilities, style: TextStyle(color: Colors.white70)),
            ],
          ));
}
