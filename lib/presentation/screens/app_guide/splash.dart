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
      const Duration(seconds: 5),
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.003, 1),
              end: Alignment(0.003, -1),
              colors: <Color>[
                Color(0xFFC7A3E7), // Light purplish color
                Color(0xFF4A00E0), // Deep purple color
              ],
              stops: <double>[0, 1],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                padding: EdgeInsets.fromLTRB(
                  104 * fem,
                  334 * fem,
                  111.14 * fem,
                  0 * fem,
                ),
                width: double.infinity,
                height: 500 * fem,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      color: Colors.transparent,
                      width: 150 * fem, // Adjust as needed
                      height: 150 * fem, // Adjust as needed
                      child: Image.asset(
                        'assets/Splash/suicide-prevention-logo.png',
                        fit: BoxFit.fill,
                      ),
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
