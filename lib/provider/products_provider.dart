import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel> _data = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductModel> get data => _data;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Method to fetch data from the API
  Future<void> fetchData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        List<dynamic> t = json.decode(response.body);
        _data = t.map((i) => ProductModel.fromJson(i)).toList();
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

  Future<void> fetchDataByCategory(String category) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
          Uri.parse('https://fakestoreapi.com/products/category/$category'));

      if (response.statusCode == 200) {
        List<dynamic> t = json.decode(response.body);
        _data = t.map((i) => ProductModel.fromJson(i)).toList();
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
}
