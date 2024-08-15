import 'package:flutter/material.dart';
import 'package:expiration_date/features/data/modles.dart';
import 'package:expiration_date/features/services/inventoryService.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final List<Item> _data = inventoryService.generateItems();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionPanelList(
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                _data[panelIndex].isExpanded = isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.brand),
                  );
                },
                body: Column(
                  children: item.sizes.map((size) {
                    return ListTile(
                      title: Text('${size.products[0].name} -'  ' ${size.name}oz'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: size.products.map((product) {
                          return Text("${product.flavor} (${product.size} oz)");
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
