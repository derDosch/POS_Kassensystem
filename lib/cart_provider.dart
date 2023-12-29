import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pos_kassensystem/cart.dart';
import 'package:pos_kassensystem/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier{

  DBHelper db = DBHelper();

  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  Future<List<Cart>> get cart => db.getCartList(); // Updated getter for cart

  /*
  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future <List<Cart>> getData() {
    _cart = db.getCartList();
    return _cart;
  }

   */

  void _setPrefItems()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('cart_item', _counter);
    pref.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _counter = pref.getInt('cart_item') ?? 0;
    _totalPrice = pref.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter(){
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter(){
    if(_counter > 0){
      _counter--;
    }
    _setPrefItems();
    notifyListeners();
  }

  int getCounter(){
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double productPrice){
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice){
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice(){
    _getPrefItems();
    return _totalPrice;
  }

  void clearCounter() {
    _counter = 0;
    _setPrefItems();
    notifyListeners();
  }

  Future<void> saveCartToSharedPreferences(List<Cart> cartItems) async {
    List<Cart> cart = await db.getCartList(); // Erhalten Sie die Artikel des Einkaufswagens

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> cartJsonList = cart.map((cart) => cart.toMap()).toList();
    await prefs.setString('cartData', jsonEncode(cartJsonList));
  }
}