
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'auth/authSelection.dart';

class SplashScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          splashIconSize: 200,
          splashTransition: SplashTransition.fadeTransition,
          splash: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image:
              AssetImage("assets/images/careerconnect.jpg"),
                  ),
          ),
          nextScreen: AuthSelection()),
    );
  }
}
