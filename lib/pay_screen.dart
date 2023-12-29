import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

class Pay extends StatefulWidget {
  final double cashToPay;
  final String currency;

  const Pay({Key? key, required this.cashToPay, required this.currency})
      : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  bool isPayed = false;
  final _textControllerMoneyGiven = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double moneyGiven = double.tryParse(_textControllerMoneyGiven.text.replaceAll(',', '.')) ?? 0;
    double amountToPay = widget.cashToPay;
    double remainingAmount = amountToPay - moneyGiven;
    bool isRemainingAmount = remainingAmount > 0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('POS'),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 40,
            child: InkWell(
              onTap: () {
                Navigator.pop(context, isPayed);
              },
              child: const Icon(Icons.keyboard_return_outlined),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total amount to pay:",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.cashToPay.toStringAsFixed(2)} ${widget.currency}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total amount given:     ",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 180,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        textAlign: TextAlign.right,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        controller: _textControllerMoneyGiven,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _textControllerMoneyGiven.clear();
                                },
                                icon: const Icon(Icons.clear)),
                            hintText: 'Money given',
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        isRemainingAmount
                            ? 'Missing Amount:'
                            : (remainingAmount.abs() > 0.001
                            ? 'Change:'
                            : 'No Change:'),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        isRemainingAmount
                            ? '${remainingAmount.toStringAsFixed(2)} ${widget.currency}'
                            : (remainingAmount.abs() > 0.001
                            ? '${remainingAmount.abs().toStringAsFixed(2)} ${widget.currency}'
                            : 'No Change'),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isRemainingAmount,
            child: MaterialButton(
              onPressed: () {
                isPayed = true;
                double paidAmount = double.tryParse(_textControllerMoneyGiven.text.replaceAll(',', '.')) ?? 0;
                Navigator.pop(context, Tuple2<bool, double>(isPayed, paidAmount));
              },
              color: Colors.blue,
              child: const Text('Pay'),
            ),
          ),
        ],
      ),
    );
  }
}