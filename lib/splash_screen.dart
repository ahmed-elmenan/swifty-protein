import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: const Center(child:Text("Splash Screen")), // maybe we create animated object with flair 
      ),
    );
  }
}
