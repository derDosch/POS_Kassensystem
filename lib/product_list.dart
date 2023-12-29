import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_kassensystem/cart.dart';
import 'package:pos_kassensystem/cart_provider.dart';
import 'package:pos_kassensystem/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_product.dart';
import 'class_product.dart';
import 'cart_screen.dart';
import 'package:badges/badges.dart' as badges;

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  DBHelper? dbHelper = DBHelper();
  bool dataLoaded = false;

  List<String> productName = [];
  List<String> productUnit = [];
  List<double> productPrice = [];
  List<String> productImage = [];
  List<int> productStock = [];
  List<String> productCurrency = [];

  late SharedPreferences sharedPreferences;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();

    dbHelper = DBHelper();
    _openDatabase();
    initialGetSavedData();
  }

  Future<void> _openDatabase() async {
    await dbHelper?.initDatabase();
  }

  void initialGetSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final prefsMap = <String, dynamic>{};
    //prefs.clear();

    for (String key in keys) {
      final value = prefs.get(key);


      if (value != null && key.startsWith('product_')) {
        prefsMap[key] = value;
        Product product = Product.fromJson(jsonDecode(prefsMap[key]));


        setState(() {
          productName.add(product.name.toString());
          productUnit.add(product.unit.toString());
          productImage.add(product.image.toString());
          productStock.add(product.stock.toInt());
          productCurrency.add(product.currency.toString());
          productPrice.add(product.price.toDouble());
        });
      }
    }
    setState(() {
      dataLoaded = true;
    });
  }


  Widget _buildProductImage(int index) {
    if (productImage[index].startsWith('http')) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/No_image_found.jpg',
        image: productImage[index],
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/No_image_found.jpg',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          );
        },
      );
    } else if (File(productImage[index]).existsSync()) {
      return Image.file(
        File(productImage[index]),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/No_image_found.jpg',
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Product list'),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 40,
            child: InkWell(
              onTap: () {
                // TODO: Navigator zu menu
              },
              child: const Icon(Icons.menu),
            ),
          ),
          SizedBox(
            width: 40,
            child: InkWell(
              onTap: () async {
                final newProduct = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProduct()),
                );
                setState(() {
                  productName.add(newProduct.name);
                  productUnit.add(newProduct.unit);
                  productPrice.add(newProduct.price);
                  productImage.add(newProduct.image);
                  productStock.add(newProduct.stock);
                  productCurrency.add(newProduct.currency);
                });
              },
              child: const Icon(Icons.add),
            ),
          ),
          IconButton(
            icon: Icon(isEditMode ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                isEditMode = !isEditMode;
              });
            },
          ),
          badges.Badge(
            alignment: Alignment.centerLeft,
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                );
              },
            ),
            animationDuration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: 40,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(currency: productCurrency[0]),
                    ),
                  );
                },
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: dataLoaded
      ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, index) {
    if (index < productName.length) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildProductImage(index),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        productName[index].toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      isEditMode
                                          ? InkWell(
                                        onTap: () async {
                                          final dynamic result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddProduct(
                                                textCurrency: productCurrency[index],
                                                textImage: productImage[index],
                                                textName: productName[index],
                                                textPrice: productPrice[index].toString(),
                                                textStock: productStock[index].toString(),
                                                textUnit: productUnit[index],
                                                edit: true,
                                              ),
                                            ),
                                          );
                                          setState(() {
                                            if (result is bool && result) {
                                              productName.removeAt(index);
                                              productUnit.removeAt(index);
                                              productPrice.removeAt(index);
                                              productImage.removeAt(index);
                                              productStock.removeAt(index);
                                              productCurrency.removeAt(index);
                                            } else if (result is Product) {
                                              setState(() {
                                                productName[index] = result.name;
                                                productUnit[index] = result.unit;
                                                productPrice[index] = result.price;
                                                productImage[index] = result.image;
                                                productStock[index] = result.stock;
                                                productCurrency[index] = result.currency;
                                              });
                                            }
                                          });
                                        },
                                        child: const Icon(Icons.edit),
                                      )
                                          : const SizedBox(), // Platzhalter
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${productUnit[index]} ${productPrice[index].toStringAsFixed(2)}${productCurrency[index]}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${productStock[index]} ${productUnit[index]} available",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            dbHelper!.insert(
                                              Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: productName[index],
                                                initialPrice: productPrice[index],
                                                productPrice: productPrice[index],
                                                productCurrency: productCurrency[index].toString(),
                                                quantity: 1,
                                                unitTag: productUnit[index],
                                                image: productImage[index],
                                              ),
                                            ).then((value) {
                                              cart.addTotalPrice(productPrice[index]);
                                              cart.addCounter();
                                            }).onError((error, stackTrace) {
                                              // ignore: avoid_print
                                              print('Error adding to cart: $error');
                                            });
                                          },
                                          child: const Text(
                                            'Add to cart',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }else{
      return const SizedBox();
    }
    },
            ),
          ),
        ],
      )
          : const Center(
        child: CircularProgressIndicator(), // Anzeige während des Ladens
      ),
    );
  }
}
