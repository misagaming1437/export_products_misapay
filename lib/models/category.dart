import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:misapay/const.dart';
import 'package:uuid/uuid.dart';

import '../helpers/dataqflite_helper.dart';
part 'category.g.dart';

final _boxItem = Hive.box<Category>(boxMenuCategory);

@HiveType(typeId: 5)
class Category {
  @HiveField(0)
  final String uuid;
  @HiveField(1)
  final String title;

  @override
  String toString() => 'MenuCatgory: title: $title - uuid: $uuid';

  @override
  bool operator ==(covariant Category other) =>
      uuid == other.uuid && title == other.title;

  int get hashcode => uuid.hashCode;

  Category({String? uuid, required this.title})
      : uuid = uuid ?? const Uuid().v4();

  Category updated({String? title}) =>
      Category(title: title ?? this.title, uuid: uuid);

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(title: json['Name']);
}

class Categories extends ChangeNotifier {
  List<Category> _items = [];
  get items => [..._items];

  Future<void> fetchData() async {
    List<Category> dataProducts = [];
    final data = await DataSqflite.getData('Categories');
    for (final value in data) {
      dataProducts.add(Category.fromJson(value));
    }
    _items = dataProducts;
    print('convert product ${_items.length}');
    try {
      await _boxItem.clear();
      for (final e in _items) {
        await _boxItem.add(e);
      }
    } catch (e) {}
    // await _boxItem.addAll([..._items]);

    notifyListeners();
  }

  getCategoryNameByCategoryId(int categoryId) async {
    final data = await DataSqflite.getData('Categories');
    return data.firstWhere((element) => element['Id'] == categoryId)['Name'];
  }

  getUuidCategory(String title) =>
      _items.firstWhere((element) => element.title == title).uuid;
}
