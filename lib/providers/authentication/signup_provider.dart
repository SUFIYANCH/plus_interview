import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/providers/authentication/signup_provider_state.dart';
import 'package:plus_interview/service/api_service.dart';

class SignUp extends Notifier<SignUpProviderState> {
  @override
  SignUpProviderState build() {
    return SignUpProviderState(
      name: TextEditingController(),
      email: TextEditingController(),
      password: TextEditingController(),
      isLoading: false,
    );
  }

  // to toggle the loading when clicked signup button
  void toggleLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  // to validate the textfiled if it is not empty
  bool validate() {
    return state.name.text.trim().isNotEmpty &&
        state.email.text.trim().isNotEmpty &&
        state.password.text.trim().isNotEmpty;
  }

  Future<String?> signUp() {
    return ApiService().registerUser(
      name: state.name.text,
      email: state.email.text,
      password: state.password.text,
    );
  }

  void resetFields() {
    state.name.clear();
    state.email.clear();
    state.password.clear();
  }
}

final signUpProvider =
    NotifierProvider<SignUp, SignUpProviderState>(() => SignUp());
