import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/ai_chatbot/chatmodel.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/app_guide/splash.dart';
import 'package:guardians_suicide_prevention_app/route_names.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/auth/google_sign_in_provider.dart';
import 'presentation/screens/video_suggestion/video_suggestion.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => GoogleSignInProvider()),
          )
        ],
        child: MaterialApp(
          title: 'Suicide Prevention App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RoutesName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
