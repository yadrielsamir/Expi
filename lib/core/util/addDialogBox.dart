import 'package:expiration_date/features/services/inventoryService.dart';
import 'package:expiration_date/features/services/productService.dart';
import 'package:expiration_date/features/data/modles.dart';
import 'button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class AddDialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onCancel;
  final VoidCallback onProductAdded;


  const AddDialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onProductAdded
  });

  @override
  State<AddDialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<AddDialogBox> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _flavorController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();


  void saveProduct(){
    if(_controller.text.isEmpty || _flavorController.text.isEmpty || _sizeController.text.isEmpty || _brandController.text.isEmpty) {
      return;
    }
    else{
      Item? item = inventoryService.findItem(_brandController.text);
      if(item == null){
        inventoryService.itemList.add(Item(brand: _brandController.text, sizes: [Size(name: _sizeController.text, products: [Product(name: _controller.text, expirationDate: 0, flavor: _flavorController.text, size:  double.tryParse(_sizeController.text))])]));
      }
      else{
        int? index = inventoryService.findSizeIndex(_sizeController.text, item);
        if(index == null){
          item.sizes.add(Size(name: _sizeController.text, products: [Product(name: _controller.text, expirationDate: 0, flavor: _flavorController.text, size:  double.tryParse(_sizeController.text))]));
        }
        else{
          item.sizes[index].products.add(Product(name: _controller.text, expirationDate: 0, flavor: _flavorController.text, size:  double.tryParse(_sizeController.text)));
        }
      }
      widget.onProductAdded();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: Container(
        height: 450,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Product name",
                  border: OutlineInputBorder(),
                ),
              ),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Brand', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    TypeAheadField<String?>(onSelected: (String? suggestion) {
                      _brandController.text = suggestion.toString();
                    }, builder: (context, controller, focusNode) {
                      return TextField(
                        controller: _brandController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: "Select brand",
                          border: OutlineInputBorder(),
                        ),
                      );
                    }, suggestionsCallback: (value) {
                      return inventoryService.getBrandList();
                    }, itemBuilder: (context, suggestion) {
                      final flavor = suggestion;

                      return ListTile(title: Text(flavor.toString()));
                    }),

                    const SizedBox(height: 10.0,),
                    const Text('Flavor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    TypeAheadField<String?>(onSelected: (String? suggestion) {
                  _flavorController.text = suggestion.toString();
                }, builder: (context, controller, focusNode) {
                    return TextField(
                      controller: _flavorController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: "Select flavor",
                        border: OutlineInputBorder(),
                      ),
                    );
                    }, suggestionsCallback: (value) {
                      return productService.getFlavorsList();
                    }, itemBuilder: (context, suggestion) {
                      final flavor = suggestion;

                      return ListTile(title: Text(flavor.toString()));
                    }),

                    const SizedBox(height: 10.0,),
                    const Text('Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    TypeAheadField<double?>(onSelected: (double? suggestion) {
                      _sizeController.text = suggestion.toString();
                    }, builder: (context, controller, focusNode) {
                      return TextField(
                        controller: _sizeController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: "Select size",
                          border: OutlineInputBorder(),
                        ),
                      );
                    }, suggestionsCallback: (value) {
                      return productService.getSizesList();
                    }, itemBuilder: (context, suggestion) {
                      final size = suggestion;

                      return ListTile(title: Text(size.toString()));
                    }),
                    ],
                    ),

            const SizedBox(height: 20.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                    buttonName: "Save",
                    onPressed: () {saveProduct();},
                ),

                const SizedBox(width: 8),

                MyButton(buttonName: "Cancel", onPressed: widget.onCancel)
              ],
            )
          ],
        ),
        ]
      ),
      )
    );
  }
}

