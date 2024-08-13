import 'package:flutter/material.dart';
import 'package:expiration_date/features/services/productService.dart';


class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: productService.productList.length,
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
                        '${productService.productList[index].getName()} (${productService.productList[index].getFlavor()}) (${productService.productList[index].getSize()}oz)',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          });
  }
}
