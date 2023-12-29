import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class_product.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String textName;
  final String textPrice;
  final String textImage;
  final String textUnit;
  final String textStock;
  final String textCurrency;
  final bool edit;

   const AddProduct({Key? key,  this.textName = "",  this.textPrice = "",  this.textImage = "",  this.textUnit = "",  this.textStock = "",  this.textCurrency = "", this.edit = false}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final _textControllerName = TextEditingController();
  final _textControllerPrice = TextEditingController();
  final _textControllerImage = TextEditingController();
  final _textControllerUnit = TextEditingController();
  final _textControllerStock = TextEditingController();
  final _textControllerCurrency = TextEditingController();
  late bool _deleteButton;
  late bool _isDelete = false;


  //this is a test object
  var newProduct = Product(
    name: '',
    price: 0,
    image: '',
    unit: '',
    stock: 0,
    currency: '',
  );



  //Function to save Data in a json
  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();


    prefs.setString(key, json.encode(value));
  }

  //Function to delete a saved json
  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _textControllerImage.text = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _textControllerName.text = widget.textName;
    _textControllerCurrency.text = widget.textCurrency;
    _textControllerStock.text = widget.textStock;
    _textControllerUnit.text = widget.textUnit;
    _textControllerImage.text = widget.textImage;
    _textControllerPrice.text = widget.textPrice;
    _deleteButton = widget.edit;
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add new product'),
        centerTitle: true,

        actions: [

        SizedBox(
        width: 40,
        child:InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.keyboard_return_outlined),
        ),
        ),
        ],
    ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children:  [

              TextField(
                controller: _textControllerName,
                decoration:   InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          //Clear the input
                          _textControllerName.clear();
                        },
                        icon: const Icon(Icons.clear)
                    ),
                  hintText: 'Product name',
                  border: const OutlineInputBorder()
                ),
              ),

              //Spacing
              const SizedBox(height: 10),

              TextField(
                controller: _textControllerPrice,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: (){
                        //Clear the input
                        _textControllerPrice.clear();
                      },
                      icon: const Icon(Icons.clear)
                  ),
                    hintText: 'Product price',
                    border: const OutlineInputBorder()
                ),
              ),

              //Spacing
              const SizedBox(height: 10),

              TextField(
                controller: _textControllerImage,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final imageSource = await showDialog<ImageSource>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Select Image Source'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  ListTile(
                                    title: const Text('Gallery'),
                                    onTap: () {
                                      Navigator.of(context).pop(ImageSource.gallery);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Camera'),
                                    onTap: () {
                                      Navigator.of(context).pop(ImageSource.camera);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      if (imageSource != null) {
                        _pickImage(imageSource);
                      }
                    },
                    icon: const Icon(Icons.image),
                  ),
                  hintText: 'Product image (Optional)',
                  border: const OutlineInputBorder(),
                ),
              ),

              //Spacing
              const SizedBox(height: 10),

              TextField(
                controller: _textControllerUnit,
                decoration:  InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          //Clear the input
                          _textControllerUnit.clear();
                        },
                        icon: const Icon(Icons.clear)
                    ),
                    hintText: 'Product unit',
                    border: const OutlineInputBorder()
                ),
              ),

              //Spacing
              const SizedBox(height: 10),

              TextField(
                controller: _textControllerStock,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')), // Erlaubt nur Zahlen
                ],
                decoration:  InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          //Clear the input
                          _textControllerStock.clear();
                        },
                        icon: const Icon(Icons.clear)
                    ),
                    hintText: 'Product stock',
                    border: const OutlineInputBorder()
                ),
              ),

              //Spacing
              const SizedBox(height: 10),

              TextField(
                controller: _textControllerCurrency,
                decoration:  InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          //Clear the input
                          _textControllerCurrency.clear();
                        },
                        icon: const Icon(Icons.clear)
                    ),
                    hintText: 'Product currency',
                    border: const OutlineInputBorder()
                ),
              ),

              //Spacing
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: _deleteButton,
                    child: MaterialButton(
                        onPressed: (){

                          _isDelete = true;

                          setState(() {
                            remove(_textControllerName.text);
                            Navigator.pop(context,_isDelete);
                          });

                        },
                      color: Colors.red,
                      child: const Text('delete'),
                        ),
                  ),

                  MaterialButton(
                    onPressed: () {
                      if (_textControllerName.text.isNotEmpty &&
                          _textControllerPrice.text.isNotEmpty &&
                          _textControllerUnit.text.isNotEmpty &&
                          _textControllerStock.text.isNotEmpty &&
                          _textControllerCurrency.text.isNotEmpty) {

                        var newProduct = Product(
                          name: _textControllerName.text,
                          price: double.parse(_textControllerPrice.text),
                          image: _textControllerImage.text,
                          unit: _textControllerUnit.text,
                          stock: int.parse(_textControllerStock.text),
                          currency: _textControllerCurrency.text,
                        );
                        
                        save('product_${newProduct.name}', newProduct);
                        // Hier das neue Produktobjekt an das vorherige Widget zurückschicken
                        Navigator.pop(context, newProduct);
                      }
                    },
                    color: Colors.blue,
                    child: const Text('Add'),
                  ),
                ],
              )
    ]
          ),
        ),
      ),
    );
  }
}
