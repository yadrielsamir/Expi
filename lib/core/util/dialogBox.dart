import 'button.dart';
import 'package:expiration_date/features/data/modles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:expiration_date/features/services/productService.dart';
import 'package:expiration_date/features/services/chobaniService.dart';

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
  String? _selectedFlavor;
  double? _selectedSize;


  DateTime? getSelectedDay(){
    return _selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: Container(
        height: 600,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TypeAheadField<Product?>(onSelected: (Product? suggestion) {
              widget.controller.text = suggestion!.name;
            }, builder: (context, controller, focusNode) {
              return TextField(
                controller: widget.controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  labelText: "Select product",
                  border: OutlineInputBorder(),
                ),
              );
            }, suggestionsCallback: (value) {
              return productService.productList;
            }, itemBuilder: (context, Product? suggestion) {
              final product = suggestion!;

              return ListTile(title: Text(product.name));
            }),
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
                          widget.flavor(_selectedFlavor);
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
                          widget.size(_selectedSize);
                        });
                      },
                    ),
                  ],
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

