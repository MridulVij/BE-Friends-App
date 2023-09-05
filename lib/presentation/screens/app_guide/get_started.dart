import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/ai_chatbot/chatmodel.dart';
import 'package:guardians_suicide_prevention_app/route_names.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.dashboardMain);
              },
              child: Text("Get Started")),
        ),
      ),
    );
  }
}
