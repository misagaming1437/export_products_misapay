import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../const.dart';
import '../helpers/dataqflite_helper.dart';
part 'ingredient_item.g.dart';

@immutable
@HiveType(typeId: 10)
class IngredientItem {
  @HiveField(0)
  final String uuid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool allowInventory;
  @HiveField(3)
  final int inventory;
  IngredientItem(
      {String? uuid,
      required this.name,
      required this.allowInventory,
      required this.inventory})
      : uuid = uuid ?? const Uuid().v4();

  IngredientItem copyWith(
          {String? name, bool? allowInventory, int? inventory}) =>
      IngredientItem(
          name: name ?? this.name,
          allowInventory: allowInventory ?? this.allowInventory,
          inventory: inventory ?? this.inventory,
          uuid: uuid);

  @override
  String toString() =>
      'Material(title: $name, inventory: $inventory, uuid: $allowInventory)';

  factory IngredientItem.fromJson(Map<String, dynamic> json) => IngredientItem(
      name: json['Name'],
      allowInventory: false,
      inventory: json['Inventory'] ?? 0);
}

//
//
//
class IngredientItemData extends ChangeNotifier {
  List<IngredientItem> _items = [];
  get items => [..._items];
  //
  final _boxItem = Hive.box<IngredientItem>(boxIngredientItem);
  //

  Future<void> fetchData() async {
    List<IngredientItem> dataProducts = [];
    //
    final data = await DataSqflite.getData('Materials');
    //
    for (final value in data) {
      dataProducts.add(IngredientItem.fromJson(value));
    }
    _items = dataProducts;
    print('convert product ${_items.length}');
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

  getIngredientItem(int ingredientId) async {
    final data = await DataSqflite.getData('Materials');
    //
    final name =
        data.firstWhere((element) => element['Id'] == ingredientId)['Name'];
    return _items.firstWhere((element) => element.name == name);
  }
}
