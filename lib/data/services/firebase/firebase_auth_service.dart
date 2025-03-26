import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/helpers/functions.dart';
import 'package:todo_fire_app/presentation/modules/authentication/login_screen.dart';
import 'package:todo_fire_app/routes/app_routes.dart';

class FirebaseAuthService {
  

  
  //signIn with google account
  // Future<bool> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   if (googleUser == null) {
  //     //!if the user get back and didn't  choose any choice
  //     return false; //indication that authentication doesn't completed
  //   }
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   return true; //you can go to the home page
  // }
}
