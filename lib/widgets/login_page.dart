
import 'package:dap/firebase/firebase_auth/authentication.dart';
import 'package:provider/provider.dart';

import '../account.dart';
import '../widgets/home_page.dart';
import 'package:flutter/material.dart';
import '../widgets/create_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login_Page extends StatefulWidget {
  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final formkey = GlobalKey<FormState>();

  final numbController = TextEditingController();

  final passController = TextEditingController();

  String thisMail="";

  String thisPassword="";
  bool valid = true;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    final _authService = Provider.of<Authentication>(context);

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Computer Science Engineering"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               const SizedBox(height: 10,),
               const Text(
                 "Log in",
                 style: TextStyle(fontSize: 35, color: Colors.green),
               ),
               const SizedBox(height: 20,),

               Form(
                 key: formkey,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                         SizedBox(
                           width:300,
                             height: 50,
                             child: TextFormField(

                               controller: numbController,
                                 keyboardType: TextInputType.number,
                                 onChanged: (value){
                                 setState(() {
                                   thisMail = value;
                                 });
                                 },
                               decoration: const InputDecoration(
                                 border: OutlineInputBorder(),
                                 labelText: "Enter mail"
                               ),
                               // validator: (value){
                               //     if(valid) return null;
                               //     else return "Invalid email!";
                               //
                               // },
                             ),
                         ),

                         const SizedBox(height: 15,),

                         SizedBox(
                           width: 300,
                           height: 50,
                           child: TextFormField(
                             obscureText: true,
                             controller: passController,
                             onChanged: (value){
                               setState(() {
                                 thisPassword = value;
                               });
                             },
                             decoration: const InputDecoration(
                                 border: OutlineInputBorder(),
                                 labelText: "Enter password"
                             ),
                             // validator: (value){
                             //   if(_authService.user != null) return null;
                             //   else return "Invalid password!";
                             //
                             // },
                             // validator: (value){
                             //   if(value!.isEmpty) return "Enter password";
                             //   return null;
                             // },
                           ),
                         )
                       ],
                   ),
               ),

               const SizedBox(height: 10,),

               RaisedButton(
                 onPressed: ()async{

                   await _authService.signInWithEmailAndPassword(thisMail, thisPassword);

                   if(_authService.user != null) {
                     User? currentUser = FirebaseAuth.instance.currentUser;
                     Navigator.pushReplacement(
                         context, MaterialPageRoute(builder:
                         (context) => Home_Page()));
                   }
                 //  else{
                  //   valid = false;
                //   }
                //   final isValid = formkey.currentState?.validate();
                 },
                 color: Colors.green,
                 child: const Text("Sign in",style: TextStyle(color: Colors.white),),
               ),

               const SizedBox(height: 5,),

               FlatButton(onPressed: (){},
               child: const Text("Forget password?",style: TextStyle(color: Colors.green),)),

              const SizedBox(
                 height: 20,
               ),

               FlatButton(
                   onPressed: () {
                     Navigator.push(context,
                       MaterialPageRoute(
                           builder: (context) => Create_Account_Page()),
                     );
                   },
                   color: Colors.green,
                   child: const Text("Create Acoount",style: TextStyle(color:Colors.white),)),
              //
              const SizedBox(height: 200,),

            ],
          ),
        ),
      ),
      //  ),
    );
  }
}
