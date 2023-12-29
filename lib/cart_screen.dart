import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_kassensystem/pay_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'SharedPreference.dart';
import 'cart.dart';
import 'cart_provider.dart';
import 'db_helper.dart';

class CartScreen extends StatefulWidget {
  final String currency;
  const CartScreen({Key? key, required this.currency}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  SharedPref sharedPref = SharedPref(); // Fügen Sie die Instanz der SharedPref-Klasse hinzu

  Future<void> saveAndDeleteCartData(CartProvider cart, double? paidAmount) async {
    await saveCartToSharedPreferences(cart, paidAmount);
    await deleteCartData(cart);
  }

  Future<void> saveCartToSharedPreferences(CartProvider cart, double? paidAmount) async {
    final cartItems = await cart.cart;
    final jsonCart = Cart.toCartJson(cartItems);

    // Erstellen des Zeitstempels mit Datum und Uhrzeit
    final timeStamp = DateTime.now().toString();

    // Laden der bisher gespeicherten Einkaufswagen aus den Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    final dynamic previousCarts = prefs.getString('cartData');

    // Erstellen einer Map mit Zeitstempel, Einkaufswagen-Daten und dem gezahlten Betrag
    Map<String, dynamic> cartData = {
      'timeStamp': timeStamp,
      'cart': jsonCart,
      'paidAmount': paidAmount ?? 0.0, // Speichern des gezahlten Betrags oder Standardwert von 0.0
    };

    List<Map<String, dynamic>> carts = previousCarts != null
        ? (json.decode(previousCarts) as List).cast<Map<String, dynamic>>()
        : [];

    // Hinzufügen der aktuellen Einkaufswagen-Daten zur Liste
    carts.add(cartData);

    // Begrenzen auf maximal 20 Einkaufswagen
    if (carts.length > 20) {
      carts = carts.sublist(carts.length - 20);
    }

    // Speichern der Einkaufswagenliste in den Shared Preferences
    await prefs.setString('cartData', jsonEncode(carts));
  }



  Future<void> deleteCartData(CartProvider cart) async {
    await dbHelper!.deleteAll();
    cart.clearCounter();
    cart.removeTotalPrice(cart.totalPrice);
  }

  Widget _buildProductImage(String image) {
    if (image.startsWith('http')) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/No_image_found.jpg', // Pfad zum Platzhalterbild
        image: image,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/No_image_found.jpg', // Platzhalterbild für Fehlerfall
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          );
        },
      );
    } else if (File(image).existsSync()) {
      return Image.file(
        File(image),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/No_image_found.jpg', // Standardbild, wenn kein gültiger Bildpfad
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
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 40,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_return_outlined),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder(
              future: cart.db.getCartList(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Expanded(
                        child: Center(
                          child: Text(
                            "Cart is empty",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ));
                  } else {
                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          _buildProductImage(snapshot.data![index].image.toString()),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index].productName.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        dbHelper!.delete(snapshot.data![index].id!);
                                                        cart.removeCounter();
                                                        cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice!.toString()));
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${snapshot.data![index].unitTag.toString()} ${snapshot.data![index].productPrice!.toStringAsFixed(2)}${snapshot.data![index].productCurrency.toString()}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  int quantity = snapshot.data![index].quantity!;
                                                                  double price = snapshot.data![index].initialPrice!;
                                                                  quantity--;
                                                                  double?newPrice = price * quantity;

                                                                  if (quantity > 0) {
                                                                    dbHelper!.updateQuantity(
                                                                        Cart(
                                                                          id: snapshot.data![index].id!,
                                                                          productId: snapshot.data![index].productId!,
                                                                          productName: snapshot.data![index].productName!,
                                                                          initialPrice: snapshot.data![index].initialPrice!,
                                                                          productPrice: newPrice,
                                                                          productCurrency: snapshot.data![index].productCurrency!,
                                                                          quantity: quantity,
                                                                          unitTag: snapshot.data![index].unitTag!.toString(),
                                                                          image: snapshot.data![index].image!.toString(),
                                                                        )).then((value) {
                                                                      newPrice = 0;
                                                                      quantity = 0;
                                                                      cart.removeTotalPrice(snapshot.data![index].initialPrice!);
                                                                    }).onError((
                                                                        error, stackTrace) {
                                                                      //print(error.toString());
                                                                    });
                                                                  }
                                                                },

                                                                child: const Icon(
                                                                    Icons
                                                                        .remove)),
                                                            Text(
                                                                snapshot.data![index].quantity.toString(),
                                                                style:
                                                                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
                                                                )),
                                                            InkWell(
                                                                onTap: () {

                                                                    int quantity = snapshot.data![index].quantity!;
                                                                    double price = snapshot.data![index].initialPrice!;
                                                                    quantity++;
                                                                    double? newPrice = price * quantity;
                                                                    dbHelper!.updateQuantity(
                                                                        Cart(
                                                                          id: snapshot.data![index].id!,
                                                                          productId: snapshot.data![index].productId!,
                                                                          productName: snapshot.data![index].productName!,
                                                                          initialPrice: snapshot.data![index].initialPrice!,
                                                                          productPrice: newPrice,
                                                                          productCurrency: snapshot.data![index].productCurrency!,
                                                                          quantity: quantity,
                                                                          unitTag: snapshot.data![index].unitTag!.toString(),
                                                                          image: snapshot.data![index].image!.toString(),
                                                                        )).then(
                                                                            (value) {
                                                                          newPrice = 0;
                                                                          quantity = 0;
                                                                          cart.addTotalPrice(snapshot.data![index].initialPrice!);
                                                                        })
                                                                        .onError((
                                                                        error,
                                                                        stackTrace) {

                                                                    });

                                                                },
                                                                child: const Icon(
                                                                    Icons.add)),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Consumer<CartProvider>(builder: (context, value, child) {
                            return Column(
                                children: [
                              ReusableWidget(
                                  value: value.getTotalPrice().toStringAsFixed(2) + widget.currency,
                                  title: 'Total price'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  // Delete cart button
                                  MaterialButton(
                                    onPressed: () {
                                      dbHelper!.deleteAll().then((value) {
                                        cart.clearCounter(); // Setze den Zähler zurück
                                        cart.removeTotalPrice(cart.totalPrice); // Setze den Gesamtpreis zurück
                                      }).onError((error, stackTrace) {
                                        // Handle error
                                      });
                                    },
                                    color: Colors.red,
                                    child: const Text('delete'),
                                  ),

                            //Go to pay button
                                  MaterialButton(
                                    onPressed: () async {
                                      final Tuple2<bool, double?> paymentResult = await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Pay(cashToPay: cart.totalPrice, currency: widget.currency)),
                                      );

                                      bool isPayed = paymentResult.item1;
                                      double? paidAmount = paymentResult.item2 ?? 0.0;
                                      if (isPayed) {
                                        await saveAndDeleteCartData(cart, paidAmount);


                                        //ToDo das ist nur um zu sehen wie der cart in den SharedPrefs mit dem Timestamp gespeichert wird

                                        /*
                                        // Daten aus den SharedPreferences abrufen
                                        final prefs = await SharedPreferences.getInstance();
                                        final dynamic savedCarts = prefs.getString('cartData');

                                        if (savedCarts != null) {
                                          // Konvertiere die gespeicherten Einkaufswagen-Daten zurück
                                          final List<Map<String, dynamic>> carts = (json.decode(savedCarts) as List).cast<Map<String, dynamic>>();

                                          // Ausgabe der Daten für jeden Einkaufswagen
                                          for (final cartData in carts) {
                                            final timeStamp = cartData['timeStamp'];
                                            final cartDetails = cartData['cart'];
                                            final payedAmount = cartData['paidAmount'];

                                            print('Time: $timeStamp');
                                            print('Cart Details: $cartDetails');
                                            print('Payed Amount: $payedAmount');
                                            print('------------');
                                          }
                                        }

                                         */


                                      }
                                    },
                                    color: Colors.blue,
                                    child: const Text('Pay'),
                                  ),
                                ],)
                            ]);
                            }),
                        ],
                      ),
                    );
                  }
                }
                return const Text('missing data');

              }
              ),

        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;

  const ReusableWidget({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
