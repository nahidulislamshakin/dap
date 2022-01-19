import '../widgets/create_account_page.dart';
import 'package:flutter/material.dart';
import '../account_list.dart';
import 'student_information.dart';
import 'login_page.dart';

class Home_Page extends StatefulWidget {
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

                accountName: Text("${studentList[userIndex].name}"),
                accountEmail: Text("${studentList[userIndex].email}"),
               decoration: BoxDecoration(
                   gradient: LinearGradient(
                       begin: Alignment.bottomLeft,
                       end: Alignment.topRight,
                       colors: [Colors.green, Colors.lightGreen])),),
            ListTile(
                title: const Text("News Feed", style: TextStyle(color: Colors.green),),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPage()));
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Page()));
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text("Department Notice",style: TextStyle(fontSize: 30, color: Colors.green)))
    );
  }
}
