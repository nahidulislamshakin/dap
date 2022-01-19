import '../widgets/login_page.dart';
import 'package:flutter/material.dart';
import '../account_list.dart';
import '../account_list.dart';
import '../firebase/students/data_write/data_write.dart';
import '../firebase/firebase_auth/auth_registration.dart';

List<AccountList> studentList = [
  AccountList(
      name: "Nahidul Islam Shakin",
      id: "18ICTCSE046",
      email: "shakinhabib2000@gmail.com",
      number: 01954841508,
      password: "1234")
];

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
  double innumber = 0;
  String inpassword = "";
  String incpass = "";

  //double innumber = -1;

  void SubmitData() {
    final isValid = formkey.currentState?.validate();

    inname = namecontroller.text;
    inid = idcontroller.text;
    inmail = mailcontroller.text;
    innumber = double.parse(numbercontroller.text);
    inpassword = passwordcontroller.text;
    incpass = cpasswordcontroller.text;

    if (inname.isEmpty) return;
    if (inid.isEmpty) return;
    if (inmail.isEmpty) return;
    if (innumber < 0) return;

    if (inpassword.isEmpty || incpass.isEmpty || inpassword != incpass)
      return;
    else {
      final addAccount = AccountList(
          name: inname,
          id: inid,
          email: inmail,
          number: innumber,
          password: inpassword);
      studentList.add(addAccount);
      // else{
      //Navigator.of(context).pushNamed('/login_page');

    }

    AuthRegistration(email: inmail, password: incpass);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login_Page()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                        onFieldSubmitted: (_) => SubmitData,
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
                        onFieldSubmitted: (_) => SubmitData,
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
                        onFieldSubmitted: (_) => SubmitData,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            //    border: OutlineInputBorder(),
                            labelText: "E-mail",
                            hintText: "Enter your E-mail",
                            icon: Icon(Icons.email)),
                        validator: (value) {
                          if (value!.length < 4)
                            return "Enter your mail please";
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: numbercontroller,
                        onFieldSubmitted: (_) => SubmitData,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            //     border: OutlineInputBorder(),
                            labelText: "Number",
                            hintText: "Enter your phone number",
                            icon: Icon(Icons.phone)),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Enter your number please";
                          else {
                            for (int i = 0; i < studentList.length; i++) {
                              if (studentList[i].number == innumber) {
                                return "Number is already used";
                                break;
                              }
                            }
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        onFieldSubmitted: (_) => SubmitData,
                        obscureText: true,
                        decoration: const InputDecoration(
                            //    border: OutlineInputBorder(),
                            labelText: "Password",
                            hintText: "Enter your password",
                            icon: Icon(Icons.password)),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Enter your password please";

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cpasswordcontroller,
                        onFieldSubmitted: (_) => SubmitData,
                        obscureText: true,
                        decoration: const InputDecoration(
                            //       border: OutlineInputBorder(),
                            labelText: "Confirm Password",
                            hintText: "Confirm Password",
                            icon: Icon(Icons.password)),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Confirm your password please";
                          else if (inpassword != incpass)
                            return "Confirm your password correctly";
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
                  onPressed: () {
                    //Navigator.of(context).pushNamed('/login_page');
                    SubmitData();
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
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    const Text('Already have an account?'),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login_page');
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Login_Page()));
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
