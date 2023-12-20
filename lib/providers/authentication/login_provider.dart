import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/providers/authentication/login_provider_state.dart';
import 'package:plus_interview/service/api_service.dart';

class Login extends Notifier<LoginProviderState> {
  @override
  LoginProviderState build() {
    return LoginProviderState(
      email: TextEditingController(),
      password: TextEditingController(),
      isLoading: false,
    );
  }

  // to toggle the loading when clicked login button
  void toggleLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  //reset text
  void resetLogin() {
    state.email.clear();
    state.password.clear();
  }

  // to check whether the text is not empty
  bool validate() {
    return state.email.text.trim().isNotEmpty &&
        state.password.text.trim().isNotEmpty;
  }

  Future<String?> login() {
    return ApiService().loginUser(
      email: state.email.text,
      password: state.password.text,
    );
  }
}

final loginProvider =
    NotifierProvider<Login, LoginProviderState>(() => Login());
