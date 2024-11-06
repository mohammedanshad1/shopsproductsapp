import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopsproductsapp/model/category_model.dart';
import 'package:shopsproductsapp/model/product_model.dart';

class CategoryProductViewModel extends ChangeNotifier {
  List<Category> _categories = [];
  List<Products> _products = [];
  bool _isLoading = false;
  List<Products> filteredProducts = [];

  List<Category> get categories => _categories;
  List<Products> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    const url = 'https://prethewram.pythonanywhere.com/api/Top_categories/';
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> categoryJson = json.decode(response.body);
        _categories =
            categoryJson.map((json) => Category.fromJson(json)).toList();
      } else {
        print('Error: Failed to load categories - Status Code: ${response.statusCode}');
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    const url = 'https://prethewram.pythonanywhere.com/api/parts_categories';
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> productJson = json.decode(response.body);
        _products = productJson.map((json) => Products.fromJson(json)).toList();
        filteredProducts = _products;  
      } else {
        print('Error: Failed to load products - Status Code: ${response.statusCode}');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterProductsByCategory(int? categoryId) {
    if (categoryId == null) {
      filteredProducts = _products;  
    } else {
      filteredProducts = _products.where((product) {
        return product.partsCat == categoryId; 
      }).toList();
    }
    notifyListeners();
  }
}
