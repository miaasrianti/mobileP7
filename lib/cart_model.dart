import 'package:flutter/material.dart';

class Product {
  final String nama;

  Product(this.nama);
}

class CartModel extends ChangeNotifier {
  final List<Product> _list = [];

  List<Product> get list => _list;
  int get totalItems => _list.length;

  void add(Product product) {
    _list.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _list.remove(product);
    notifyListeners();
  }
}
