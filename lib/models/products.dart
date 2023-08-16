import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:misapay/const.dart';

import '../helpers/dataqflite_helper.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  final _boxItem = Hive.box<Product>(boxProduct);

  Future reloadData() async {
    _items = [..._boxItem.values];
    notifyListeners();
  }

  Future clearTemp() async {
    _items = [];
    notifyListeners();
  }

  Future<void> fetDataProducts() async {
    List<Product> dataProducts = [];
    final data = await DataSqflite.getData('Products');
    for (var value in data) {
      dataProducts.add(Product(
        title: value['Name'],
        price: int.tryParse(value['Price']) ?? 0,
        image: value['Image']?.split('uploads/').last,
        isActive: value['IsActive'] == 1 ? true : false,
        allowInventory: value['AllowInventory'] == 1 ? true : false,
        inventory: value['Inventory'],
        originalPrice: int.tryParse(value['OriginalPrice']) ?? 0,
      ));
    }
    _items = [...dataProducts];

    try {
      await _boxItem.clear();
      for (final e in _items) {
        await _boxItem.add(e);
      }
      print('success ');
    } catch (e) {}
    // await _boxItem.addAll([..._items]);

    notifyListeners();
  }

  Future getProductIdByName(String name) async {
    final data = await DataSqflite.getData('Products');
    final product = data.firstWhere((element) => element['Name'] == name);
    return product['Id'];
  }

  //
  //
  Future toogle(Product updatedProduct) async {
    // print(updatedProduct.title);
    // updatedProduct.ingredients.forEach((element) {
    //   print(element.toString());
    // });

    final index = _items.indexWhere((e) => e.uuid == updatedProduct.uuid);

    // print(index);

    try {
      _items = [
        for (final e in _items)
          e.uuid == updatedProduct.uuid ? updatedProduct : e
      ];
      await _boxItem.putAt(index, updatedProduct);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
