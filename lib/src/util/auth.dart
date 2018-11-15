import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';


typedef LogoutAction = void Function();
class Auth {
  final BehaviorSubject<FirebaseUser> _user = new BehaviorSubject<FirebaseUser>();
  Auth._(){
    this._update();
  }
  static Auth instance = Auth._();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() => _auth.signOut().whenComplete(()=>this._update());
  void _update()=> _auth.currentUser().then((user)=>_user.add(user)); 
  void emailSignIn(String email, String password)=> _auth.signInWithEmailAndPassword(email: email, password: password).then((user)=>_user.add(user));
  set onLogout(LogoutAction action){
    _user.where((user)=>user == null).listen((_){
      action();
    });
  }
}

