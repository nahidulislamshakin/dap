import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dap/widgets/student_information.dart';
import 'package:dap/widgets/teacher_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../firebase/firebase_auth/authentication.dart';
import 'about.dart';
import 'home_page.dart';
import 'login_page.dart';

class drawer extends StatefulWidget{
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
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
    // TODO: implement build

    final _authService = Provider.of<Authentication>(context);

    return Drawer(
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (conte)=>TeacherPage()));
            },
          ),
          ListTile(
            title: const Text('Student\'s Information'),
            onTap: () {
              Navigator.pushReplacement(context,
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
    );
  }
}