import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/ai_chatbot/chatmodel.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/app_guide/splash.dart';
import 'presentation/screens/video_suggestion/video_suggestion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sucide Prevenion App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'splash',
      routes: {
        'splash':(context) => Splash(),
        'chatmodel':(context) => ChatModel(),
      },

    );
  }
}
