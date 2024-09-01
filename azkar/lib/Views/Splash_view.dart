import 'dart:async';

import 'package:azkar/Views/Home_view.dart';
import 'package:azkar/Views/Onbording_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static String id = 'Splash_view';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    Timer(const Duration(seconds: 3), () {
      _checkFirstTime();
    });
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime) {
      // If it's the first time, navigate to the onboarding screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnbordingView()),
      );
      // Set isFirstTime to false to indicate that onboarding has been shown
      await prefs.setBool('first_time', false);
    } else {
      // If not the first time, navigate to the authentication screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:const Color(0xffefede6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
              Image.asset('assets/images/mosque.png',
             height: isPortrait ? 250 : screenHeight / 2, // Adjust height based on orientation
          width: isPortrait ? 250 : screenWidth / 2 ,),
              
            ],
          ),
           const SizedBox(height: 50),
           const CircularProgressIndicator(
            color: Color(0xffb19877),
            ),
        ],
      ),
    );
  }
}
