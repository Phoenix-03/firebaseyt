import 'package:flutter/material.dart';
import 'package:youtube/screens/home_screen.dart';
import 'package:youtube/screens/nav_screen.dart';

class CombinedScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: HomeScreen(),
          ),
          Expanded(
            flex: 3,
            child: NavScreen(),
          ),
        ],
      ),
    );
  }
}
