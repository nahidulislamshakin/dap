import '../account_list.dart';
import '../widgets/home_page.dart';
import 'package:flutter/material.dart';
import '../widgets/create_account_page.dart';

int userIndex = -1;



class Login_Page extends StatefulWidget {
  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final formkey = GlobalKey<FormState>();

  final numbController = TextEditingController();

  final passController = TextEditingController();

  double thisnumber = 0;

  String thispassword = "";

  //String userCheckError = "";
  @override
  Widget build(BuildContext context) {
    submit() {
      final isValid = formkey.currentState?.validate();

      thisnumber = double.parse(numbController.text);
      thispassword = passController.text;
      if (studentList.isEmpty) return;
       // userCheckError = "Invalid number or password";

      else {
        for (int i = 0; i < studentList.length; i++) {
          if (studentList[i].number == thisnumber) {
            if (studentList[i].password == thispassword) {
              userIndex = i;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_Page()));
              break;
            }
          }
        }
        //if(numberCheck == false || passwordCheck == false) userCheckError = "Invalid number or password";

      }
    }

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Computer Science Engineering"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const SizedBox(height: 10,),
               const Text(
                 "Log in",
                 style: TextStyle(fontSize: 35, color: Colors.green),
               ),
               const SizedBox(height: 20,),

             //  UserCheck(numberCheck: numberCheck, passwordCheck: passwordCheck,),
            //   SizedBox(height: 5,),

               Form(
                 key: formkey,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                         SizedBox(
                           width: 200,
                             height: 50,
                             child: TextFormField(

                               controller: numbController,
                                 keyboardType: TextInputType.number,
                                 onFieldSubmitted: (_)=>submit,
                               decoration: InputDecoration(
                                 border: OutlineInputBorder(),
                                 labelText: "Enter number"
                               ),
                               validator: (value){
                                 // bool numberCheck = false;
                                 // for(int j = 0 ;j<studentList.length;j++)
                                 //   if(studentList[j].number == value) numberCheck = true;

                                 if(value!.isEmpty) return "Invalid number";


                                 else return null;
                               },
                             ),
                         ),

                         SizedBox(height: 15,),

                         SizedBox(
                           width: 200,
                           height: 50,
                           child: TextFormField(
                             obscureText: true,
                             controller: passController,
                             onFieldSubmitted: (_)=>submit,
                             decoration: InputDecoration(
                                 border: OutlineInputBorder(),
                                 labelText: "Enter password"
                             ),
                             validator: (value){
                               if(value!.isEmpty) return "Enter password";
                               return null;
                             },
                           ),
                         )
                       ],
                   ),
               ),

               SizedBox(height: 10,),

               RaisedButton(
                 onPressed: () {
                   submit();
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
              SizedBox(height: 200,),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    // color: Colors.black,

                    child: Column(
                      children: [
                        Text(
                          "Developer:",
                          style: TextStyle(color: Colors.black),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          "Nahidul Islam Shakin",
                          style: TextStyle(color: Colors.black),
                        ),
                        //),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      //  ),
    );
  }
}
