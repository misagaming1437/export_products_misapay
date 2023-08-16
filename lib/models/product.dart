import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'ingredient.dart';
part 'product.g.dart';

@HiveType(typeId: 6)
class Product {
  @HiveField(0)
  final String uuid;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final int originalPrice;
  @HiveField(5)
  final bool isActive;
  @HiveField(6)
  final bool allowInventory;
  @HiveField(7)
  final int inventory;

  @HiveField(8)
  final String? printerId;
  @HiveField(9)
  final String menuUuid;
  @HiveField(10, defaultValue: [])
  final List<Ingredient> ingredients;

  Product({
    String? uuid,
    required this.title,
    required this.price,
    this.originalPrice = 0,
    this.image,
    this.isActive = true,
    this.allowInventory = false,
    this.inventory = 0,
    this.printerId,
    this.menuUuid = '',
    this.ingredients = const [],
  }) : uuid = uuid ?? const Uuid().v4();

  Product copyWith({
    String? title,
    String? image,
    int? price,
    int? originalPrice,
    bool? isActive,
    bool? allowInventory,
    int? inventory,
    String? printerId,
    String? menuUuid,
    List<Ingredient>? ingredients,
  }) =>
      Product(
          uuid: uuid,
          title: title ?? this.title,
          image: image ?? this.image,
          price: price ?? this.price,
          originalPrice: originalPrice ?? this.originalPrice,
          isActive: isActive ?? this.isActive,
          allowInventory: allowInventory ?? this.allowInventory,
          inventory: inventory ?? this.inventory,
          printerId: printerId ?? this.printerId,
          menuUuid: menuUuid ?? this.menuUuid,
          ingredients: ingredients ?? this.ingredients);
  @override
  String toString() =>
      'Product(title: $title, uuid: $uuid,image: $image, price: $price, oringinPrice: $originalPrice, \nisActive: $isActive, alowwInventory: $allowInventory, inventory: $inventory, categoryId: $menuUuid';
}
