import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class User {
  final String uid;
  User({required this.uid});
}

class AuthService{
  User _userFromFirebaseUser(User user){
    // ignore: unnecessary_null_comparison
    return User(uid: user.uid);
    

  }
}
