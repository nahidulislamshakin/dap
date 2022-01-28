import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dap/firebase/firebase_auth/authentication.dart';
import 'package:dap/widgets/home_page.dart';
import 'package:dap/widgets/student_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String? uid;

  String? email;

  Future<void> getUser() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User currentUser = firebaseAuth.currentUser!;
    // return currentUser;
    uid = currentUser.uid;
    email = currentUser.email;
  }

  String? currentUserName;

  Future<void> getUserName() async {
    FirebaseFirestore.instance
        .collection("Students")
        .doc(uid)
        .get()
        .then((value) {
      setState(() {
        currentUserName = value.get("name").toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<Authentication>(context);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.green.shade100,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "$currentUserName",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              accountEmail: Text(
                "$email",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(color: Colors.black)),
              ),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.green, Colors.lightGreen])),
            ),
            ListTile(
                title: const Text(
                  "News Feed",
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Page()));
                }),
            ListTile(
              title: const Text('Teacher\'s Information'),
              onTap: () {
                Navigator.of(context).pushNamed('./teacher_information');
              },
            ),
            ListTile(
              title: const Text('Student\'s Information'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentPage()));
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                await _authService.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Login_Page()));
              },
            ),
            ListTile(
              title: const Text('About',style: TextStyle(color: Colors.green),),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => About()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.green.shade200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Developer: ",
                  style: GoogleFonts.openSans(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20,),
                // Divider(
                //   thickness: 2,
                // ),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset("image/developer.jpg"),
                ),
                const SizedBox(height: 05,),
                Text(
                  "Nahidul Islam Shakin",
                  style: GoogleFonts.openSans(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Text("Contacts:",style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 17)),),
                const SizedBox(height: 05,),
                Text("shakinhabib2000@gmail.com",style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 15)),),
                Text("01954841508",style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 15)),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
