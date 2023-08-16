import 'dart:io';

import 'package:flutter/material.dart';

String a = '';

class ProductItem extends StatelessWidget {
  final String _title;
  final int _price;
  final String _image;

  // ignore: use_key_in_widget_constructors
  ProductItem(this._title, this._price, this._image);

  String imagePath(String? img) {
    String imageApp;
    if (img == null || img == '') {
      imageApp =
          'D:/DEV/App/misapay/misapay/uploads/637907308182316798-burger-bo-trung-pho-mai-2.jpg';
    } else {
      imageApp =
          '${Directory.current.path.replaceAll('\\', '/')}/$img'.toString();
    }

    return imageApp;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Theme.of(context).primaryColor,
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.file(
                      File(imagePath(_image)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Chip(
                    backgroundColor: Colors.white10,
                    label: Text(
                      _price.toString(),
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 5,
                  child: Material(
                    color: Colors.transparent,
                    shape: Border.all(
                        style: BorderStyle.none,
                        width: 0,
                        color: Colors.white10),
                    child: IconButton(
                      iconSize: 24,
                      splashColor: Colors.redAccent,
                      splashRadius: 24.0,
                      icon: const Icon(Icons.shopping_cart),
                      color: Theme.of(context).primaryColor,
                      // hoverColor: ,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Text(_title),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
