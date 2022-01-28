import 'package:dap/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/create_account_page.dart';
import 'widgets/home_page.dart';
import 'widgets/login_page.dart';
import 'widgets/student_information.dart';
import 'widgets/teacher_information.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import '../firebase/firebase_auth/authentication.dart';

FirebaseOptions get firebaseOptions => const FirebaseOptions(
    apiKey: 'AIzaSyCA_H3mG6AclrDt-5C6Jp49ZIDZ9XR7YbA',
    appId: '1:73750114527:android:e11ecdf97ad0d855d7b96a',
    messagingSenderId: '73750114527',
    projectId: 'department-app-888ef');

Future<void> initializeDefult() async {
  FirebaseApp app = await Firebase.initializeApp(options: firebaseOptions);
  //return app;
  print("Initialized default app $app");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefult();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        Provider<Authentication>(create: (context) => Authentication(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.red,
        ),
         initialRoute: '/wrapper',
        routes: {
          '/wrapper' : (context) => Wrapper(),
          '/login_page': (context) => Login_Page(),
          '/create_account': (context) => Create_Account_Page(),
          '/home_page': (context) => Home_Page(),
          './student_information': (context) => StudentPage(),
          './teacher_information': (context) => TeacherPage(),
        },
      ),
    );
  }
}
