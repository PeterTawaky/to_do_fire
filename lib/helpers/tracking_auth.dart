import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

trackAuthentication() {
 FirebaseAuth.instance.authStateChanges().listen((User? user) {
 if (user == null) {
 debugPrint('User is currently signed out!');
 } else {
 debugPrint('User is signed in!');
}
});
 }