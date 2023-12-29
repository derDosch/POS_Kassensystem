
class Product{
 late String name;
 late String unit;
 late String image;
 late double price;
 late int stock;
 late String currency;


  Product({required this.name, required this.price, required this.unit, required this.image, required this.stock, required this.currency});

  //Method that converts json to object instance
  Product.fromJson(Map<String, dynamic> json){
    final price_ = json['price'];

    name = json['name'] as String;
    if (price_ is double) {
      price =price_;
    } else if (price_ is int) {
      price =price_.toDouble();
    } else if (price_ is String) {
      price= double.tryParse(price_) ?? 0.0;
    }
    unit = json['unit'] as String;
    image = json['image'] as String;
    stock = json['stock'] as int;
    currency = json['currency'] as String;
  }


  //Method that converts object to json String
  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'unit': unit,
    'image': image,
    'stock': stock,
    'currency': currency,
  };


}