import 'package:provider/provider.dart';

import '../widgets/login_page.dart';
import 'package:flutter/material.dart';
import '../account.dart';
import '../account.dart';
import '../firebase/students/data_write/data_write.dart';
import '../firebase/firebase_auth/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Create_Account_Page extends StatefulWidget {
  @override
  State<Create_Account_Page> createState() => _Create_Account_PageState();
}

class _Create_Account_PageState extends State<Create_Account_Page> {
  final formkey = GlobalKey<FormState>();

  final namecontroller = TextEditingController();
  final idcontroller = TextEditingController();
  final mailcontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final cpasswordcontroller = TextEditingController();

  String inname = "";
  String inid = "";
  String inmail = "";
  String innumber = "";
  String inpassword = "";
  String incpass = "";
  bool valid = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final _authService = Provider.of<Authentication>(context);

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Create Your Account"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: namecontroller,
                        onChanged: (value) {
                          setState(() {
                            inname = value;
                          });
                        } ,
                        decoration: const InputDecoration(
                            //    border: OutlineInputBorder(),
                            labelText: "Name",
                            hintText: "Enter your full name",
                            icon: Icon(Icons.person)),
                        validator: (value) {
                          if (value!.isEmpty) return "Enter your name please";
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: idcontroller,
                        onChanged: (value) {
                          setState(() {
                            inid = value;
                          });
                        } ,
                        decoration: const InputDecoration(
                            //    border: OutlineInputBorder(),
                            labelText: "ID",
                            hintText: "Enter your ID",
                            icon: Icon(Icons.perm_identity)),
                        validator: (value) {
                          if (value!.isEmpty) return "Enter your ID please";
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: mailcontroller,
                        onChanged: (value) {
                          setState(() {
                            inmail = value;
                          });
                        } ,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            //    border: OutlineInputBorder(),
                            labelText: "E-mail",
                            hintText: "Enter your E-mail",
                            icon: Icon(Icons.email)),
                        validator: (value){

                          if(value!.isEmpty) return "Enter email";
                           return null;


                        },
                      ),
                      TextFormField(
                        controller: numbercontroller,
                        onChanged: (value) {
                          setState(() {
                            innumber = value;
                          });
                        } ,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            //     border: OutlineInputBorder(),
                            labelText: "Number",
                            hintText: "Enter your phone number",
                            icon: Icon(Icons.phone)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your number please";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        onChanged: (value) {
                          setState(() {
                            inpassword = value;
                          });
                        } ,
                        obscureText: true,
                        decoration: const InputDecoration(
                            //    border: OutlineInputBorder(),
                            labelText: "Password",
                            hintText: "Enter your password",
                            icon: Icon(Icons.password)),
                        validator: (value) {
                          if (value!.isEmpty || value.length<6) {
                            return "Enter your password which should be more than 6 characters";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cpasswordcontroller,
                        onChanged: (value) {
                          setState(() {
                            incpass = value;
                          });
                        } ,
                        obscureText: true,
                        decoration: const InputDecoration(
                            //       border: OutlineInputBorder(),
                            labelText: "Confirm Password",
                            hintText: "Confirm Password",
                            icon: Icon(Icons.password)),
                        validator: (value) {
                          if (value!.isEmpty || inpassword != incpass) {
                            return "Confirm your password please";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RaisedButton(
                  onPressed: ()async{

                   await _authService.createAccountWithEmailAndPassword(inmail, incpass, inname, inid, innumber);
                   if(_authService.user != null) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login_Page()));
                //   else valid = false;
                  // final isValid = formkey.currentState?.validate();
                  },
                  color: Colors.green,
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //goto sign in button
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Already have an account?'),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login_page');
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
