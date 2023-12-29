class Cart{
  late final int? id;
  final String? productId;
  final String? productName;
  final double? initialPrice;
  final double? productPrice;
  final String? productCurrency;
  final int? quantity;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.productCurrency,
    required this.quantity,
    required this.unitTag,
    required this.image,
});

  Cart.fromMap(Map<dynamic,dynamic> res)
  : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        initialPrice = res['initialPrice']?.toDouble(), // Convert to double
        productPrice = res['productPrice']?.toDouble(), // Convert to double
        productCurrency = res['productCurrency'],
        quantity = res['quantity'],
        unitTag = res['unitTag'],
        image = res['image'];

  Map<String, Object?> toMap(){
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'productCurrency' : productCurrency,
      'quantity': quantity,
      'unitTag': unitTag,
      'image': image,
    };
  }

  // Funktion zum Konvertieren des Einkaufswagens in JSON
  static Map<String, dynamic> toCartJson(List<Cart> cartItems) {
    return {
      'items': cartItems.map((item) => item.toMap()).toList(),
    };
  }
}