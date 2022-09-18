import 'package:dap/widgets/create_account_page.dart';
import 'package:dap/widgets/login_page.dart';
import 'package:dap/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(

          height: double.infinity,
          child: IntroductionScreen(
            key: GlobalKey<IntroductionScreenState>(),
            globalBackgroundColor: Colors.white,

            showNextButton: true,
            showDoneButton: false,
            showSkipButton: false,

            next: Text(
              "Next",
             style: GoogleFonts.openSans(
                textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.blue),
              ),
           ),
            // color: Colors.white,
            pages: [
              PageViewModel(
                  title:
                      "App to represent Computer Science and Engineering department of BSMRSTU, Gopalganj-8100",
                  image: Image.asset("image/BSMRSTU.jpg"),
                  body:
                      "CSE is one of the top department of Bangabandhu Sheikh Mujibur Rahman Science and Technology University. By this app you can connect to this department.",
                  decoration: PageDecoration(
                    pageColor: Colors.white,
                    titleTextStyle: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900),
                    ),
                    bodyTextStyle: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade600)),
                    descriptionPadding:
                        const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    imagePadding: EdgeInsets.zero,
                  )),
              PageViewModel(
                title: "Let's get started",
                image: Lottie.asset("image/programmer.json"),
                body: "Are you ready to start with us?",
                decoration: PageDecoration(
                  titleTextStyle: GoogleFonts.openSans(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  bodyTextStyle: GoogleFonts.openSans(
                      textStyle:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  descriptionPadding:
                      const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  pageColor: Colors.white,
                  imagePadding: EdgeInsets.zero,
                ),
                footer: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50)),
                      child: TextButton(
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_Page())),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50)),
                      child: TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Create_Account_Page())),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
