import 'package:hive/hive.dart';
import 'package:misapay/models/ingredient.dart';

import 'const.dart';
import 'main.dart';
import 'models/ingredient_item.dart';
import 'models/category.dart';
import 'models/product.dart';

Future hiveInitializing() async {
  final directory = await getFileDatabase();
  Hive.init(directory);

  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(IngredientItemAdapter());
  Hive.registerAdapter(IngredientAdapter());

  await Hive.openBox<Category>(boxMenuCategory);
  await Hive.openBox<Product>(boxProduct);
  await Hive.openBox<IngredientItem>(boxIngredientItem);
}
