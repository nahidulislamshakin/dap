import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dap/firebase/firebase_auth/authentication.dart';
import 'package:dap/widgets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentPage extends StatefulWidget {
  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
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
            const UserAccountsDrawerHeader(
              accountName: Text("Shakin"),
              accountEmail: Text("Shakin"),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.green, Colors.lightGreen])),
            ),
            ListTile(
                title: const Text("News Feed"),
                onTap: () {
                  Navigator.of(context).pushNamed('/home_page');
                }),
            ListTile(
              title: const Text('Teacher\'s Information'),
              onTap: () {
                Navigator.of(context).pushNamed('./teacher_information');
              },
            ),
            ListTile(
              title: const Text(
                'Student\'s Information',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                await _authService.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page()));
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
