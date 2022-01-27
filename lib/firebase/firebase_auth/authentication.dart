import 'package:firebase_auth/firebase_auth.dart';

class AuthRegistration {
  final String email;
  final String password;

  AuthRegistration({required this.email, required this.password});

  Future register() async {
    FirebaseAuth firebaseauth = FirebaseAuth.instance;
    final UserCredential user = await firebaseauth.createUserWithEmailAndPassword(
            email: email, password: password);
    return user;
  }
}
