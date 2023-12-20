import 'package:flutter/material.dart';

class UpdateProviderState {
  final TextEditingController password;
  final String token;
  final bool isLoading;
  UpdateProviderState({
    required this.password,
    required this.token,
    required this.isLoading,
  });

  UpdateProviderState copyWith({
    TextEditingController? password,
    String? token,
    bool? isLoading,
  }) {
    return UpdateProviderState(
      password: password ?? this.password,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
