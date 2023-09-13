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
    return Container(
      color: Colors.deepPurple,
      child: Center(
        child: Container(
          child: Text("BE Friend.",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 26),
          ),
        ),
      ),

    );
  }
}
