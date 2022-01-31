import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatelessWidget {
  Widget nextScreen;
  String imagePath;

  Splash({required this.nextScreen,required this.imagePath});

  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(child: Lottie.asset("image/$imagePath")),
      splashIconSize: 1000,
      duration: 1500,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: nextScreen,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}