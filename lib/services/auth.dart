import 'package:firebase_auth/firebase_auth.dart';
import 'package:treeapp/models/user.dart';


class AuthService{

 //static bool admin = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser

//  bool returnAdmin() {
//    return admin;
//  }

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //sign in anonymous
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }

  }
  //sign in anonymous
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

//      if(user.email == 'admin@gmail.com'){
//       // admin = true;
//        print('This is an admin');
//        return AdminPage();
//      }

      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
     AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
     FirebaseUser user = result.user;

      //create a new document for the user with the uid
     // await DatabaseService()
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}