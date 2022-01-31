import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dap/firebase/firebase_auth/authentication.dart';
import 'package:dap/widgets/student_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'about.dart';
import 'home_page.dart';
import 'login_page.dart';

class TeacherPage extends StatefulWidget {
  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
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

    return Scaffold(
        backgroundColor: Colors.green.shade100,
        appBar: AppBar(
          title: const Text("Teacher's Information"),
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
                accountEmail: Text("$email",style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        color: Colors.black)),),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Colors.green, Colors.lightGreen])),
              ),
              ListTile(
                  title: const Text("News Feed"),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home_Page()));
                  }),
              ListTile(
                title: const Text(
                  'Teacher\'s Information',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TeacherPage()));
                },
              ),
              ListTile(
                title: const Text('Student\'s Information'),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentPage()));
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
                title: const Text('About'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>About()));

                },
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Teachers").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Teachers list is empty",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Something went wrong"),
                  ],
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Waiting for network"),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final data = snapshot.requireData;
                  return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        border: Border.all(
                          color: Colors.green.shade200,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            child: Image.network(data.docs[index]["img"]),
                          ),
                          Text(
                            "${data.docs[index]["name"]}",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "${data.docs[index]["post"]}",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontSize: 15,
                            )),
                          ),
                          Text(
                            "${data.docs[index]["email"]}",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontSize: 15,
                            )),
                          ),
                          Text(
                            "${data.docs[index]["number"]}",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontSize: 15,
                            )),
                          ),
                        ],
                      ));
                },
                itemCount: snapshot.data?.size,
              );
            }
          },
        ));
  }
}
