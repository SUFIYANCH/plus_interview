import 'package:flutter/material.dart';

class LoginProviderState {
  final TextEditingController email;
  final TextEditingController password;
  final bool isLoading;
  LoginProviderState({
    required this.email,
    required this.password,
    required this.isLoading,
  });

  LoginProviderState copyWith(
      {TextEditingController? email,
      TextEditingController? password,
      bool? isLoading}) {
    return LoginProviderState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
