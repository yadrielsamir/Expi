import 'package:expiration_date/features/presentation/pages/Inventory.dart';
import 'package:expiration_date/features/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:expiration_date/features/data/modles.dart';


class ExpiredPage extends StatelessWidget {
  final List<Product> expiredList;

  const ExpiredPage({
    super.key,
    required this.expiredList
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productService.getExpiredProductsList(expiredList).length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${productService.getExpiredProductsList(expiredList)[index].getName()} (${productService.getExpiredProductsList(expiredList)[index].getFlavor()}) (${productService.getExpiredProductsList(expiredList)[index].getSize()}oz)',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        });;
  }
}
