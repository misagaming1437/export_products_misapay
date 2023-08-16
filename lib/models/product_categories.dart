import 'package:flutter/material.dart';

import '../helpers/dataqflite_helper.dart';

class ProductCategory {
  final int productId;
  final int categoryId;
  const ProductCategory({required this.productId, required this.categoryId});

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
          productId: json['ProductId'], categoryId: json['CategoryId']);
}

//
//
//
class ProductsCategories extends ChangeNotifier {
  List<ProductCategory> _items = [];
  get items => [..._items];

  fetchData() async {
    List<ProductCategory> extractedData = [];
    final data = await DataSqflite.getData('ProductsCategories');
    for (final value in data) {
      extractedData.add(ProductCategory.fromJson(value));
    }

    _items = [...extractedData];
  }

  int? getCategoryIdByProductId(int productId) {
    final index =
        _items.indexWhere((element) => element.productId == productId);
    if (index == -1) return null;
    return _items[index].categoryId;
  }
}
