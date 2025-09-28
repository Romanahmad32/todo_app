import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial(isLoggedIn: false));

  void authStateChanged({User? user}) {
    final bool isLoggedIn = user != null;
    emit(
      AuthCubitInitial(isLoggedIn: isLoggedIn, userId: user?.uid),
    );
  }
}
