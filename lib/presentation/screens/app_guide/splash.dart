import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/app_guide/get_started.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.003, 1),
              end: Alignment(0.003, -1),
              colors: <Color>[
                Colors.red,
                Colors.white
              ], // Red to Whitish gradient
              stops: <double>[0, 1],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                padding: EdgeInsets.fromLTRB(
                    104 * fem, 334 * fem, 111.14 * fem, 0 * fem),
                width: double.infinity,
                height: 546 * fem,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 214 * fem,
                    height: 212 * fem,
                    child: Image.asset(
                      'assets/Splash/suicide-prevention-logo.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 326.14 * fem,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
