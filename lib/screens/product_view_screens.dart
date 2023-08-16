import 'package:flutter/material.dart';
import 'package:misapay/const.dart';
import 'package:misapay/fetch_data.dart';
import 'package:misapay/pickerfile.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';

class ProductsViewScreen extends StatefulWidget {
  const ProductsViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsViewScreen> createState() => _ProductsViewScreenState();
}

class _ProductsViewScreenState extends State<ProductsViewScreen> {
  bool _isloadedData = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    submid() async {
      final pathSqlData = await pickerfileDataSql();
      if (pathSqlData != null) {
        pathData = pathSqlData;
        if (context.mounted) await convertData(context);
        setState(() {
          _isloadedData = true;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mặt hàng'), actions: []),
      body: _isloadedData == false
          ? Center(
              child: ElevatedButton(
                  onPressed: () async => submid(),
                  child: const Text('Load Data')))
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer(builder: (context, value, child) {
                final products = Provider.of<Products>(context).items;

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(),
                            Text(
                                '$index ${products[index].title} : ingredients length: ${products[index].ingredients.length}'),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: products[index]
                                  .ingredients
                                  .map((e) => ListTile(
                                        title: Text(e.ingredientItem.name),
                                        trailing: Text(e.count.toString()),
                                      ))
                                  .toList(),
                            )
                          ],
                        ));
              }),
            ),
      bottomNavigationBar: Consumer(
          builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        await Provider.of<Products>(context, listen: false)
                            .reloadData();
                      },
                      icon: const Icon(Icons.replay_outlined)),
                  IconButton(
                      onPressed: () async {
                        await Provider.of<Products>(context, listen: false)
                            .clearTemp();
                      },
                      icon: const Icon(Icons.clear)),
                ],
              )),
    );
  }
}
