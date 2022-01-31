import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dap/firebase/firebase_auth/authentication.dart';
import 'package:dap/widgets/login_page.dart';
import 'package:dap/widgets/teacher_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'about.dart';
import 'home_page.dart';

class StudentPage extends StatefulWidget {
  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String? uid ;
  String? email;


  Future<void> getUser() async{
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User currentUser = await firebaseAuth.currentUser!;
    // return currentUser;
    uid = currentUser.uid;
    email = currentUser.email;
  }
  String? currentUserName;
  Future<void> getUserName() async{
    await FirebaseFirestore.instance.collection("Students").doc(uid).get().then((value){
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

    final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection("Students").snapshots();

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Text("Student's Information"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.green.shade100,
        child: ListView(
          children: [
             UserAccountsDrawerHeader(
              accountName: Text("$currentUserName",style: GoogleFonts.openSans(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black)),),
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
                title: const Text("News Feed"),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home_Page()));
                }),
            ListTile(
              title: const Text(
                'Teacher\'s Information',
              ),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TeacherPage()));
              },
            ),
            ListTile(
              title: const Text('Student\'s Information',style: TextStyle(color: Colors.green),),
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
        stream: users,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 15,),
                    Text("No Students are registered"),
                  ],
                ),
              );

          }
          if(snapshot.hasError){
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 15,),
                    Text("Something went wrong"),
                  ],
                ),
              );
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 15,),
                    Text("Waiting for network"),
                  ],
                ),
              );

          }


          else{
            return ListView.builder(itemBuilder: (context, index) {
              final data = snapshot.requireData;
              return Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(

                    color: Colors.green.shade200,
                    border: Border.all(color: Colors.green.shade200,),
                    borderRadius: BorderRadius.circular(8),
                    // boxShadow: [
                    //   new BoxShadow(color: Colors.green.shade400, offset: new Offset(6.0, 6.0),),
                    // ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${data.docs[index]["name"]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("${data.docs[index]["ID"]}",style: TextStyle(fontSize: 15),),
                      Text("${data.docs[index]["email"]}",style: TextStyle(fontSize: 15),),
                      Text("${data.docs[index]["number"]}",style: TextStyle(fontSize: 15),),

                    ],
                  )
              );
            }, itemCount: snapshot.data?.size,);
          }
        },
      )
    );
  }
}
