import 'package:firebase_auth/firebase_auth.dart';

class AuthenticateService{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//create User obj based on firebase user
  User? userFromFirebaseUser(User? user){
    return user != null ?  user : null;
  }
  //auth change user stream
  Stream<User?> get user{
    return FirebaseAuth.instance.authStateChanges();
  }

  User? get authUser {
    return FirebaseAuth.instance.currentUser;
  }
  //sign in Anon
  Future signInAnon() async{

    try{
      UserCredential credentialResult = await FirebaseAuth.instance.signInAnonymously();
      User? user = credentialResult.user;
      return userFromFirebaseUser(user);
    }catch( exception){
      print(exception.toString());
      return null;
    }
  }
///////////////////
  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    print('email is :'+email);
    print('password :' +password);
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return userFromFirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return exception;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    print('email is :'+email);
    print('password :' +password);
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return userFromFirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return exception;
    }
  }

  Future getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  //sign out
  Future signOut() async{
    try{
      return await FirebaseAuth.instance.signOut();
    }catch(exception){
      print(exception.toString());
      return exception;
    }
  }
}