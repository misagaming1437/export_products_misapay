import 'package:flutter/material.dart';
import 'package:misapay/models/ingredient.dart';
import 'package:misapay/models/product_ingredients.dart';

import 'package:misapay/models/products.dart';
import 'package:provider/provider.dart';

import 'models/ingredient_item.dart';
import 'models/category.dart';
import 'models/product_categories.dart';

Future convertData(BuildContext context) async {
  final productPro = Provider.of<Products>(context, listen: false);
  final categoryProv = Provider.of<Categories>(context, listen: false);
  final ingredientPro = Provider.of<IngredientItemData>(context, listen: false);

  final productsCategoriesProvider =
      Provider.of<ProductsCategories>(context, listen: false);
  final productsIngredientsProvider =
      Provider.of<ProductsIngredients>(context, listen: false);
  //
  //
  await productPro.fetDataProducts();
  await categoryProv.fetchData();
  await ingredientPro.fetchData();
  await productsCategoriesProvider.fetchData();
  await productsIngredientsProvider.fetchData();
  // ad prodcut to Categorries

  final products = productPro.items;

  print(products.length);
  products.forEach((product) async {
    final productId = await productPro.getProductIdByName(product.title);
    // print('productId: $productId');
    final categoryId =
        productsCategoriesProvider.getCategoryIdByProductId(productId);

    if (categoryId != null) {
      final categoryNamne =
          await categoryProv.getCategoryNameByCategoryId(categoryId);

      final uuidCategory = categoryProv.getUuidCategory(categoryNamne);
      final newProduct1 = product.copyWith(menuUuid: uuidCategory);
      await productPro.toogle(newProduct1);
      //
      //-------------------------------------------------------------------------------------------
      // update ingredient
      final List<Ingredient> ingredientsList = [];

      final ingredientIdList = productsIngredientsProvider
          .getIngredientsListIdByProductId(productId);

      for (final ingredientId in ingredientIdList) {
        final quantity = productsIngredientsProvider.getQuantityProductId(
            productId, ingredientId);
        if (quantity > 0) {
          final ingredientItem =
              await ingredientPro.getIngredientItem(ingredientId);

          final ingredient =
              Ingredient(ingredientItem: ingredientItem, count: quantity);

          ingredientsList.add(ingredient);
        }
      }
      // print(product.title);
      // ingredientsList.forEach((element) {
      //   print(element.toString());
      // });
      //---update
      if (ingredientsList.isNotEmpty) {
        final newProduct2 = newProduct1.copyWith(ingredients: ingredientsList);
        // print(newProduct2.title);
        // newProduct2.ingredients.forEach((element) {
        //   print(element.toString());
        // });
        // ---update
        await productPro.toogle(newProduct2);
      }
    }
  });
}
