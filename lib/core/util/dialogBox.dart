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


  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.onDateSelected
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  DateTime? getSelectedDay(){
    return _selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: Container(
        height: 500,
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

