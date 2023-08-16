import 'dart:io';

import 'package:flutter/material.dart';

import 'package:misapay/models/product_ingredients.dart';

import 'hive_init.dart';
import 'models/product_categories.dart';
import 'models/products.dart';
import './screens/product_view_screens.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as syspath;
import 'models/ingredient_item.dart';
import 'models/category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await hiveInitializing();
  runApp(const MyApp());
}

Future<String> getPathApp() async {
  if (Platform.isWindows) {
    return p.dirname(Platform.resolvedExecutable);
  }
// is IOS and Android
  final directory = await syspath.getApplicationDocumentsDirectory();
  return directory.path;
}

Future<String> getFileDatabase() async {
  final pathApp = await getPathApp();
  final pathDatabase = '$pathApp/database';
  final isExisted = await Directory(pathDatabase).exists();
  if (isExisted == false) {
    await Directory(pathDatabase).create(recursive: true);
  }
  return pathDatabase;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Products>(create: (ctx) => Products()),
          ChangeNotifierProvider<Categories>(create: (ctx) => Categories()),
          ChangeNotifierProvider<ProductsCategories>(
              create: (ctx) => ProductsCategories()),
          ChangeNotifierProvider<ProductsIngredients>(
              create: (ctx) => ProductsIngredients()),
          ChangeNotifierProvider<IngredientItemData>(
              create: (ctx) => IngredientItemData()),
        ],
        builder: (context, child) => const ProductsViewScreen(),
      ),
    );
  }
}
