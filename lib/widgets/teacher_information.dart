import 'package:dap/firebase/firebase_auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherPage extends StatefulWidget {
  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
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
            const UserAccountsDrawerHeader(accountName: Text("Nahidul Islam Shakin"), accountEmail: Text("shakinhabib2000@gmail.com"),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.green, Colors.lightGreen])),),
            ListTile(
                title: const Text("News Feed"),
                onTap: () {
                  Navigator.of(context).pushNamed('/home_page');
                }),
            ListTile(
              title: const Text('Teacher\'s Information',style: TextStyle(color: Colors.green),),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Student\'s Information'),
              onTap: () {
                Navigator.of(context).pushNamed('./student_information');
              },
            ),            ListTile(
              title: const Text('Settings'),
              onTap: () {},
            ),            ListTile(
              title: const Text('Logout'),
              onTap: () async{
                await _authService.signOut();

              },
            ),
          ],
        ),
      ),
      body:  const Center(
        child: Text(
          "Teacher's Information",
          style: TextStyle(fontSize: 30, color: Colors.green),
        ),
      ),
    );
  }
}
