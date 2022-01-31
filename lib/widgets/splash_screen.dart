import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

class AnimatedSplash extends StatelessWidget {
  Widget nextScreen;

  AnimatedSplash({required this.nextScreen});

  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Lottie.asset("image/2programmer.json"),
          Text(
            "CSE BSMRSTU",
            style: GoogleFonts.openSans(
                textStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      splashIconSize: 1000,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: nextScreen,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
