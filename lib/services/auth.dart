import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:food_bank_auth/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:http/http.dart' as http;

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  Users _userFromFirebaseUser(User user){
    return user != null ? Users(user.uid,user.displayName,user.photoURL) : null;
  }

  // auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  //sign in email & password
  Future signInWithEmailAndPassword(String email, String password) async {

    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User user = result.user;
        return _userFromFirebaseUser(user);
    }catch(e){
        print(e.toString());
        return null;
    }
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  try{
    UserCredential result =  await _auth.signInWithCredential(credential);
    User user = result.user;
    await FirebaseFirestore.instance.collection('user').doc(_auth.currentUser.uid)
        .get()
        .then((doc) {
          if(doc.exists) //??????user???????????????data??????usercollection
            print("user already exists!");
          else {
            DataUpload().registerAccount(
                user.displayName,
                user.email,
                user.photoURL,
                user.providerData[0].providerId
            );
          }
    });
    return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
  }

  Future signInWithFacebook() async{
    FacebookLoginResult _result = await FacebookLogin().logIn(['email']);
    switch(_result.status){
      case FacebookLoginStatus.loggedIn:
        await _loginWithFacebook(_result);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled by user");
        return null;
      case FacebookLoginStatus.error:
        print("Error");
        return null;
    }
  }

  Future _loginWithFacebook(FacebookLoginResult _result) async{
    // Get Token
    FacebookAccessToken fbtoken = _result.accessToken;
    AuthCredential credential =
    FacebookAuthProvider.credential(fbtoken.token);
    // Create a new credential
    UserCredential result =  await _auth.signInWithCredential(credential);
    User user = result.user;
    await FirebaseFirestore.instance.collection('user').doc(_auth.currentUser.uid)
        .get()
        .then((doc) {
      if(doc.exists) //??????user???????????????data??????usercollection
        print("user already exists!");
      else {
        DataUpload().registerAccount(
            user.displayName,
            user.email,
            user.photoURL,
            user.providerData[0].providerId
        );
      }
    });
    return _userFromFirebaseUser(user);
  }

  //sign out
  Future signOut() async{
    User user =  _auth.currentUser;
    try{
      if (user.providerData[0].providerId == 'google.com') {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.disconnect();
      }
      else if(user.providerData[0].providerId == 'facebook.com'){
        await FacebookLogin().logOut();
      }
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}