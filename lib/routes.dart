import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/app_guide/get_started.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/app_guide/splash.dart';
import 'presentation/screens/ai_chatbot/chatmodel.dart';
import 'presentation/screens/home/home.dart';
import 'route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.dashboardMain:
        return MaterialPageRoute(builder: (context) => const DashboardMain());
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => Splash());
      case RoutesName.getStarted:
        return MaterialPageRoute(builder: (context) => const GetStarted());
      case RoutesName.chatbot:
        return MaterialPageRoute(builder: (context) => const ChatModel());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route Not Found"),
            ),
          ),
        );
    }
  }
}
