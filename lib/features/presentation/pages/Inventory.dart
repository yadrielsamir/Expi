import 'package:flutter/material.dart';
import 'package:expiration_date/features/data/modles.dart';

List<Product> productList(String name, double size, List<String> flavors) {
  return flavors.map((flavor) {
    return Product(name: name, expirationDate: 0, flavor: flavor, size: size);
  }).toList();
}

List<Item> generateItems() {
  return [
    Item(
      category: 'Chobani',
      sizes: [
        Size(name: '5.3 oz', products: productList('Greek Yogurt', 5.3, ['Blueberry', 'Strawberry', 'Coconut', 'Coffee', 'Peach'])),
        Size(name: '32 oz', products: productList('Greek Yogurt', 32.0, ['Plain Whole Milk', 'Plain Whole Milk' 'Vanilla'])),
      ],
    ),
    Item(
      category: 'Yoplait',
      sizes: [
        Size(name: '6 oz', products: productList('Original Yogurt', 6.0, ['Strawberry', 'Peach'])),
        Size(name: '32 oz', products: productList('Original Yogurt', 32.0, ['Plain', 'Vanilla'])),
      ],
    ),
    Item(
      category: 'LaYogurt',
      sizes: [
        Size(name: '7 oz', products: productList('Total Greek Yogurt', 7.0, ['Strawberry', 'Blueberry'])),
        Size(name: '35.3 oz', products: productList('Total Greek Yogurt', 35.3, ['Plain', 'Vanilla'])),
      ],
    ),

    Item(
      category: 'Oikos',
      sizes: [
        Size(name: '7 oz', products: productList('Total Greek Yogurt', 7.0, ['Strawberry', 'Blueberry'])),
        Size(name: '35.3 oz', products: productList('Total Greek Yogurt', 35.3, ['Plain', 'Vanilla'])),
      ],
    ),
  ];
}

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<Item> _data = generateItems();

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
                    title: Text(item.category),
                  );
                },
                body: Column(
                  children: item.sizes.map((size) {
                    return ListTile(
                      title: Text(size.name),
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
