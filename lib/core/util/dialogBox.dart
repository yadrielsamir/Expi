import 'button.dart';
import 'package:expiration_date/features/data/modles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:expiration_date/features/services/productService.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Function(DateTime?) onDateSelected;
  final Function(String?) flavor;
  final Function(double?) size;


  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.onDateSelected,
    required this.flavor,
    required this.size
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  final TextEditingController _flavorController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  DateTime? getSelectedDay(){
    return _selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: Container(
        height: 655,
        width: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            const SizedBox(height: 5.0,),
            TypeAheadField<Product?>(onSelected: (Product? suggestion) {
              widget.controller.text = suggestion!.name;
            }, builder: (context, controller, focusNode) {
              return TextField(
                controller: widget.controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  labelText: "Product name",
                  border: OutlineInputBorder(),
                ),
              );
            }, suggestionsCallback: (value) {
              return productService.getSuggestedProductsList();
            }, itemBuilder: (context, Product? suggestion) {
              final product = suggestion!;

              return ListTile(title: Text(product.name));
            }),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 130,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Flavor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      const SizedBox(height: 5.0,),
                      TypeAheadField<String?>(onSelected: (String? suggestion) {
                        _flavorController.text = suggestion.toString();
                        widget.flavor(suggestion.toString());
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
                    ],
                  ),
                ),

                SizedBox(
                  width: 130,
                  height: 100,
                  child: Column(
                    children: [
                      const Text('Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ),),
                      const SizedBox(height: 5.0,),
                      TypeAheadField<double?>(onSelected: (double? suggestion) {
                        _sizeController.text = suggestion.toString();
                        widget.size(suggestion);
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
                ),
              ],
            ),

            const SizedBox(height: 20.0,),

            const Text(
              'Expiration Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Flexible(
              child: TableCalendar(
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 10, 14),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      widget.onDateSelected(_selectedDay);
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // save button
                MyButton(buttonName: "Save", onPressed: (){
                  widget.onSave();
                }),

                const SizedBox(width: 8),
                // cancel button
                MyButton(buttonName: "Cancel", onPressed: widget.onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}

