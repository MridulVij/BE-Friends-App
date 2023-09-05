import 'package:flutter/material.dart';

import '../ai_chatbot/chatmodel.dart';
import '../video_suggestion/video_suggestion.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({super.key});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  int _currentIndex = 0;
  List<Widget> _bottomNavbarScreens = [HelpAndSupport(), ChatModel()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // drawer: const AppDrawer(),
          // appBar: AppBar(actions: [
          //   IconButton(
          //       onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          //   IconButton(
          //       onPressed: () {}, icon: const Icon(Icons.mail_outline_rounded)),
          //   IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.notifications_none_rounded)),
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.apps_rounded))
          // ]),
          body: _bottomNavbarScreens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
              ])
          // ElevatedButton(
          // currentIndex: _currentIndex,
          // onTap: (index) {
          //   setState(() {
          //     _currentIndex = index;
          //   });
          // },
          ),
    );
  }
}
