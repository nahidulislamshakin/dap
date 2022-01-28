import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dap/firebase/firebase_auth/authentication.dart';
import 'package:dap/widgets/about.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/create_account_page.dart';
import 'package:flutter/material.dart';
import '../account.dart';
import 'student_information.dart';
import 'login_page.dart';

class Home_Page extends StatefulWidget {
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
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
          title: Text("News Feed"),
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
                accountEmail: Text("$email",
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.black)),),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Colors.green, Colors.lightGreen])),
              ),
              ListTile(
                  title: const Text(
                    "News Feed",
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('./home_page');
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
                title: const Text('About'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>About()));

                },
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("Chairman").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                final data = snapshot.requireData;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(05),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            color: Colors.green.shade100,
                            elevation: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade300,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: double.infinity,
                                  child: const Center(
                                      child: (Text(
                                    "Message from Chairman",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: Image.network(
                                    "https://www.bsmrstu.edu.bd/dev/departments/cse/uploaded_image/chairman/saleh Ahmed Pic.jpg",
                                  ),
                                ),
                                const SizedBox(
                                  height: 05,
                                ),
                                Text(
                                  "${data.docs[0]["Name"]}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("${data.docs[0]["speech"]}",
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(fontSize: 17))),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.green.shade300,
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            child: const Center(
                                child: (Text(
                              "News Room",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("News")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              final data = snapshot.requireData;
                              if (!snapshot.hasData) {
                                return const Text(
                                  "News list is empty",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Text(
                                  "Something went wrong",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                );
                              } else {
                                if (data.docs[0]["news"].length < 1) {
                                  return const Text(
                                    "News list is empty",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  );
                                }

                                // return Text("${data.docs[0]["news"]}",
                                //     style: GoogleFonts.openSans(
                                //         textStyle: TextStyle(fontSize: 17)));
                                //
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  height: 400,
                                  child: ListView.builder(
                                      itemCount: snapshot.data?.size,
                                      itemBuilder: (context, index) {
                                        final news = snapshot.requireData;
                                        return Text(
                                          "${news.docs[index]["news"]}",
                                          style: GoogleFonts.openSans(
                                              textStyle:
                                                  TextStyle(fontSize: 17)),
                                        );
                                      }),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 500,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
