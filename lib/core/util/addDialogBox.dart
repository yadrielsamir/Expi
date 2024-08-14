import 'package:expiration_date/features/services/productService.dart';
import 'package:expiration_date/features/data/modles.dart';
import 'button.dart';
import 'package:flutter/material.dart';
import 'package:expiration_date/features/services/chobaniService.dart';

class AddDialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onCancel;


  const AddDialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
  });

  @override
  State<AddDialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<AddDialogBox> {
  String? _selectedFlavor;
  double? _selectedSize;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: Container(
        height: 250,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 10),
            TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Flavor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    DropdownButton<String>(
                      value: _selectedFlavor,
                      hint: const Text("Select flavor"),
                      items: chobaniService.getChobaniFlavors().map((String flavor) {
                        return DropdownMenuItem<String>(
                          value: flavor,
                          child: Text(flavor),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedFlavor = newValue;
                        });
                      },
                    ),
                  ],
                ),

                Column(
                  children: [
                    const Text('Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ),),
                    DropdownButton<double>(
                      value: _selectedSize,
                      hint: const Text("Select size"),
                      items: chobaniService.getChobaniSizes().map((double size) {
                        return DropdownMenuItem<double>(
                          value: size,
                          child: Text(size.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSize = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                    buttonName: "Save",
                    onPressed: () {
                      productService.addProduct(Product(name: _controller.text,
                      expirationDate: 0,
                      flavor: _selectedFlavor!,
                      size: _selectedSize!));
                      Navigator.of(context).pop();
                }),

                const SizedBox(width: 8),

                MyButton(buttonName: "Cancel", onPressed: widget.onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}

