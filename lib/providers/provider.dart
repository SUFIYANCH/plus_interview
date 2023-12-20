import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plus_interview/models/api_model.dart';
import 'package:plus_interview/service/api_service.dart';

//api provider
final dataProvider = FutureProvider<List<ApiModel>?>((ref) async {
  return ApiService().getItems();
});

final protectedRouteProvider =
    FutureProvider.family<String?, String>((ref, token) async {
  return ApiService().protectedRoute(token);
});
