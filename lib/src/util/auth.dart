import 'package:firebase_auth/firebase_auth.dart'  ;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:rxdart/rxdart.dart';

typedef AuthAction = void Function();

enum SignInStatus {
  invalid
}

class Auth {
  final BehaviorSubject<FirebaseUser> _user =
      new BehaviorSubject<FirebaseUser>();
  Stream get stream => _user.stream;

  Auth._() {
    update();
  }

  static Auth instance = Auth._();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() => _auth.signOut().whenComplete(() => this.update());

  void update() => _auth.currentUser().then((user) => _user.add(user));


  Future<SignInStatus> emailSignIn(String email, String password) async {
    try {
     await _auth.signInWithEmailAndPassword(email: email, password: password)
         .then((user) => _user.add(user));
     return null;
    } on PlatformException {
      // wrong username password
      return SignInStatus.invalid;
    }
  }
}
