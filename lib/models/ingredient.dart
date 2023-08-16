import '/models/ingredient_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'ingredient.g.dart';

@immutable
@HiveType(typeId: 11)
class Ingredient {
  @HiveField(0)
  final IngredientItem ingredientItem;
  @HiveField(1)
  final int count;

  const Ingredient({required this.ingredientItem, required this.count});

  Ingredient copyWith({IngredientItem? ingredientItem, int? count}) =>
      Ingredient(
          ingredientItem: ingredientItem ?? this.ingredientItem,
          count: count ?? this.count);

  @override
  String toString() =>
      'Ingredient name:${ingredientItem.name} : count: $count - uuid: ${ingredientItem.uuid}';
}
