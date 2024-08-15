import 'package:flutter/material.dart';
import 'package:expiration_date/features/data/modles.dart';

class InventoryService{

  List<Item> itemList = [];

  List<Product> productList(String name, double size, List<String> flavors) {
    return flavors.map((flavor) {
      return Product(name: name, expirationDate: 0, flavor: flavor, size: size);
    }).toList();
  }

  List<String> getBrandList(){
    List<String> categoryList = [];
    List<Item> list = generateItems();
    for(Item item in list){
      categoryList.add(item.brand);
    }
    return categoryList;
  }

  Item? findItem(String brand){
    for(Item item in itemList){
      if(item.brand == brand){
        return item;
      }
    }
    return null;
  }

  int? findSizeIndex(String name, Item item){
    List list = item.sizes;
    for(int i = 0; i < list.length; i++){
      if(list[i].name == name){
        return i;
      }
    }
    return null;
  }

  List<Item> generateItems() {
    List<Item> list = [
      Item(
        brand: 'Chobani',
        sizes: [
          Size(name: '5.3', products: productList('Greek Yogurt', 5.3, ['Blueberry', 'Strawberry', 'Coconut', 'Coffee', 'Peach'])),
          Size(name: '32.0', products: productList('Greek Yogurt', 32.0, ['Plain Whole Milk', 'Nonfat Plain ', 'Vanilla'])),
          Size(name: '4.5', products: productList('Chobani Flip', 4.5, ['Salted Caramel Crunch', 'Key Lime Crumble', 'Almond Coco Loco', 'Chocolate Haze Craze'])),
        ],
      ),
      Item(
        brand: 'Yoplait',
        sizes: [
          Size(name: '6.0', products: productList('Original Yogurt', 6.0, ['Strawberry', 'Peach'])),
          Size(name: '32.0', products: productList('Original Yogurt', 32.0, ['Plain', 'Vanilla'])),
        ],
      ),
      Item(
        brand: 'LaYogurt',
        sizes: [
          Size(name: '7.0', products: productList('Greek Yogurt', 7.0, ['Blueberry', 'Strawberry', 'Piña Colada', 'Coffee', 'Peach'])),
          Size(name: '35.3', products: productList('Greek Yogurt', 35.3, ['Plain', 'Vanilla'])),
        ],
      ),

      Item(
        brand: 'Oikos',
        sizes: [
          Size(name: '5.3', products: productList(' Greek Yogurt', 5.3, ['Strawberry', 'Mixed Berry', 'Vanilla'])),
          Size(name: '32.0', products: productList(' Greek Yogurt', 32.0, ['Plain', 'Vanilla'])),
        ],
      ),

      Item(
        brand: 'Danimals',
        sizes: [
          Size(name: '3.1', products: productList(' Greek Yogurt', 3.1, ['Strawberry', 'Strawberry Banana'])),
        ],
      ),

      Item(
        brand: 'Oikos',
        sizes: [
          Size(name: '7.0', products: productList('Total Greek Yogurt', 7.0, ['Strawberry', 'Blueberry'])),
          Size(name: '32.0', products: productList('Total Greek Yogurt', 35.3, ['Plain', 'Vanilla'])),
        ],
      ),

      Item(
        brand: 'Oikos',
        sizes: [
          Size(name: '7.0', products: productList('Total Greek Yogurt', 7.0, ['Strawberry', 'Blueberry'])),
          Size(name: '35.3', products: productList('Total Greek Yogurt', 35.3, ['Plain', 'Vanilla'])),
        ],
      ),
    ];

    if(itemList.isEmpty){
      itemList.addAll(list);
    }
    return itemList;
  }
}

final inventoryService = InventoryService();
