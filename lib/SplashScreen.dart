import 'dart:async';

import 'package:Kide/pages/Auth/Login.dart';
import 'package:Kide/util/constants.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyApp.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedOut = prefs.getBool('loggedOut');

    var _duration = new Duration(seconds: 2);

    if (loggedOut != null && !loggedOut) {
      // Not first time
      return new Timer(_duration, navigationMyApp);
    } else {
      // First time
      return new Timer(_duration, this.navigationUserAuth);
    }
  }


  // navigation to 
  void navigationMyApp() {
    Navigator.of(context).pushReplacementNamed(MyApp.routeName);
  }

  // navigation to use auth
  void navigationUserAuth() {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  double _opacityAnimator(double op) {
    setState(() => _opacity = op == 0.5 ? 1.0 : 1.0);
    return _opacity;
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  // overall widget
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                    child: AnimatedOpacity(
                      opacity: _opacityAnimator(_opacity),
                      duration: Duration(milliseconds: 1700),
                      curve: Curves.easeInOut,
                      child: Opacity(
                        opacity: 1.0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 1350),
                          curve: Curves.easeInOut,
                          width: size.width / (4 * _opacityAnimator(_opacity)),
                          height:
                              size.height / (4.0 * _opacityAnimator(_opacity)),
                          child: Image.asset(
                            MAIN_KIDE_LOGO,
                            gaplessPlayback: true,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              AnimatedOpacity(
                opacity: 0.8,
                duration: Duration(milliseconds: 4500),
                curve: Curves.easeInOut,
                child: Text(
                  KIDE_CAPS,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Michroma",
                    color:
                        DynamicTheme.of(context).data.textTheme.subtitle.color,
                    letterSpacing: 20.0,
                  ),
                ),
              ),
              Container(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: LinearProgressIndicator(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(VERSION),
            ),
          ),
        ],
      ),
    );
  }
}
