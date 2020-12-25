import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy New Year',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _colorController;
  Animation<Color> animation;
  AnimationController _backgroundController;
  AnimationController _fontController;
  Animation<double> fontimation;
  Animation<Color> background;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    );

    _fontController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    animation = ColorTween(
      begin: Colors.green[200],
      end: Colors.white,
    ).animate(_colorController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _colorController.reverse().whenComplete(() {
            _colorController.reset();
            _colorController.forward();
          });
        }
      });

    background = ColorTween(
      begin: Colors.black,
      end: Colors.blue,
    ).animate(_fontController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _backgroundController.reverse().whenComplete(() {
            _backgroundController.reset();
            _backgroundController.forward();
          });
        }
      });

    fontimation = Tween<double>(
      begin: 70,
      end: 90,
    ).animate(
      CurvedAnimation(
        parent: _fontController,
        curve: Curves.elasticIn,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _fontController.reverse().whenComplete(() {
            _fontController.reset();
            _fontController.forward();
          });
        }
      });

    _colorController.forward();
    _fontController.forward();
    _backgroundController.forward();
  }

  Widget _rowWidget() {
    return Scaffold(
      body: Container(
        color: background.value,
        child: Center(
            child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'HAPPY\nNew\nYear',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontimation.value,
                      color: animation.value,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '2020',
                      style: TextStyle(
                          fontSize: 150,
                          color: Colors.green[400],
                          fontWeight: FontWeight.bold),
                    )),
                madeWithLove()
              ],
            ))
          ],
        )),
      ),
    );
  }

  Widget madeWithLove() {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(
        'Made With Flutter  ❤️',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _columnWidget() {
    return Scaffold(
      body: Container(
        color: background.value,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'HAPPY\nNew\nYear',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontimation.value,
                    color: animation.value,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '2020',
                      style: TextStyle(
                          fontSize: 120,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ))),
            madeWithLove()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _colorController,
        builder: (BuildContext context, Widget child) {
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 600)
              return _columnWidget();
            else
              return _rowWidget();
          });
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _colorController.dispose();
  }
}
