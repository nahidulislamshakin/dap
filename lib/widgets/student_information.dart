import '../widgets/create_account_page.dart';
import '../widgets/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../show_student.dart';

class StudentPage extends StatefulWidget {
  // int userIdx=0;

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  accountName: Text("${studentList[userIndex].name}"),
                  accountEmail: Text("${studentList[userIndex].email}"),
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
                onTap: () {
                  Navigator.of(context).pushNamed('/login_page');
                },
              ),
            ],
          ),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return Container(
      //color: Colors.green.shade100,
    width: double.infinity,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.green.shade400,),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
    new BoxShadow(color: Colors.green.shade400, offset: new Offset(6.0, 6.0),),
    ],
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${studentList[index].name}"),
            Text("${studentList[index].id}"),
            Text("${studentList[index].email}"),
            Text("0${studentList[index].number?.round()}"),

          ],
      )
    );
        }, itemCount: studentList.length,));
  }
}
