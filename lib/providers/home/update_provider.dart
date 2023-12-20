import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/providers/home/update_provider_state.dart';
import 'package:plus_interview/service/api_service.dart';

class UpdateNotifier extends Notifier<UpdateProviderState> {
  @override
  UpdateProviderState build() {
    return UpdateProviderState(
      password: TextEditingController(),
      token: "",
      isLoading: false,
    );
  }

  bool validate() {
    return state.password.text.isNotEmpty;
  }

  void toggleLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  void setToken(String token) {
    state = state.copyWith(token: token);
  }

  void reset() {
    state.password.clear();
  }

  Future<bool> updatePassword() {
    return ApiService().updatedPassword(
      state.token,
      state.password.text,
    );
  }

  Future<bool> deleteAccount() {
    return ApiService().deleteAccount(state.token);
  }
}

final updateProvider = NotifierProvider<UpdateNotifier, UpdateProviderState>(
    () => UpdateNotifier());
