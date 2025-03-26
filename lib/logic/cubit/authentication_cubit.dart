import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_fire_app/data/services/firebase/firebase_auth_service.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(UserSignedOutState());
  FirebaseAuthService fire = FirebaseAuthService();

  chooseScreen() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
        emit(UserSignedOutState());
      } else {
        debugPrint('User is signed in!');
        emit(UserSignedInState());
      }
    });
  }
}
