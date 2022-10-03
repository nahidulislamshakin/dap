import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dap/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  UserAccount? userFromFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return UserAccount(email: user.email, password: user.uid);
    }
  }

  Stream<UserAccount?>? get user{
  //  try{
      print("get user is worked");
      return _firebaseAuth.authStateChanges().map(userFromFirebase);

   // } on FirebaseAuthException catch(error)
  //  {
  //    print(error.code);
  //  } catch(error)
  //  {
   //   print(error);
  //  }

  }
//
//   User? user(){
//     print("get user is worked");
//     return _firebaseAuth.currentUser;
// }

  Future<UserAccount?> signInWithEmailAndPassword(String email, String password)async{
  //  try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userFromFirebase(userCredential.user);
 //   } on FirebaseAuthException catch (error){
   //   Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
  //  }
  }

  Future<UserAccount?> createAccountWithEmailAndPassword(String email, String password, String name, String id, String number) async{

  //  try{
      final UserCredential? userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        FirebaseFirestore.instance.collection("Students").doc(value.user?.uid).set({"email":value.user?.email,
          "name":name,
          "ID":id,
          "number":number,
        "password":password},
        );

      });
      return userFromFirebase(userCredential?.user);
   // }on FirebaseAuthException catch(error){
   //   print(error.code);
  //  }

  }

  Future<void> signOut() async{
    return await _firebaseAuth.signOut();
  }



}
