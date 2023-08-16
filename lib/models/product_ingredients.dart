import 'package:flutter/material.dart';

import '../helpers/dataqflite_helper.dart';

class ProductIngredient {
  final int productId;
  final int ingredientId;
  final int quantity;
  const ProductIngredient(
      {required this.productId,
      required this.ingredientId,
      required this.quantity});
  factory ProductIngredient.fromJson(Map<String, dynamic> json) =>
      ProductIngredient(
          productId: json['ProductId'],
          ingredientId: json['MaterialId'],
          quantity: json['Quantity']);
}

//
//
class ProductsIngredients extends ChangeNotifier {
  List<ProductIngredient> _items = [];
  get items => [..._items];

  fetchData() async {
    List<ProductIngredient> extractedData = [];
    final data = await DataSqflite.getData('ProductsMaterials');
    for (final value in data) {
      extractedData.add(ProductIngredient.fromJson(value));
    }
    _items = [...extractedData];
  }

  List<int> getIngredientsListIdByProductId(int productId) {
    final ingredientsIds = [];
    for (final e in _items) {
      if (e.productId == productId) ingredientsIds.add(e.ingredientId);
    }
    return [...ingredientsIds];
  }

  getQuantityProductId(int productId, int ingredientId) {
    final index = _items.indexWhere((element) =>
        (element.productId == productId) &&
        element.ingredientId == ingredientId);
    if (index == -1) return null;
    return _items[index].quantity;
  }
}
