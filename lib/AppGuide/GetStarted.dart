import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/AIChatBot/chatmodel.dart';
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
          child: ElevatedButton(onPressed: (){Navigator.pushReplacement(context,
              MaterialPageRoute(
                builder: (context) => ChatModel(),
              ),
          );
            },
              child: Text("Get Started")),
        ),
      ),
    );
  }
}
