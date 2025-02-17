import 'package:flutter/material.dart';
import 'package:flutter_application_3/API/get._api.dart';

class PhoneProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? phoneData;
  bool isLoading = false;

  Future<void> getPhoneById(String id) async {
    isLoading = true;
    notifyListeners();
    phoneData = await _apiService.fetchPhoneById(id);
    isLoading = false;
    notifyListeners();
  }
}
