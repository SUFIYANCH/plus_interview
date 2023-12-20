import 'package:flutter/material.dart';

class SignUpProviderState {
  TextEditingController name;
  TextEditingController email;
  TextEditingController password;
  bool isLoading;
  SignUpProviderState({
    required this.name,
    required this.email,
    required this.password,
    required this.isLoading,
  });

  SignUpProviderState copyWith({
    TextEditingController? name,
    TextEditingController? email,
    TextEditingController? password,
    bool? isLoading,
  }) {
    return SignUpProviderState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
