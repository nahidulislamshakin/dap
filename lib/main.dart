import 'package:flutter/material.dart';
import 'widgets/create_account_page.dart';
import 'widgets/home_page.dart';
import 'widgets/login_page.dart';
import 'widgets/student_information.dart';
import 'widgets/teacher_information.dart';
import './account_list.dart';

void main() {
  runApp( MyApp()
  );
}

class MyApp extends StatelessWidget{
   
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return     MaterialApp(

      debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.green,
      accentColor: Colors.red,
    ),
    initialRoute: '/login_page',
    routes: {
      '/login_page': (context) => Login_Page(),
      '/create_account': (context) => Create_Account_Page(),
      '/home_page': (context) => Home_Page(),
      './student_information': (context) => StudentPage(),
      './teacher_information': (context) => TeacherPage(),
    },

    // home: Login_Page(),
  

    );
  }
}
