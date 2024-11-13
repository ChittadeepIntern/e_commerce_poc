import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends ChangeNotifier {
  List<dynamic> _data = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedCategory; // Track selected category

  List<dynamic> get data => _data;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedCategory => _selectedCategory;

  // Method to fetch data from the API
  Future<void> fetchData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

      if (response.statusCode == 200) {
        _data = json.decode(response.body);
      } else {
        _errorMessage = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed to load data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String category)
  {
    _selectedCategory = category;
    notifyListeners();
  }
}
