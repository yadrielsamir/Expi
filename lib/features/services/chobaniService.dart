import 'package:expiration_date/features/data/modles.dart';
import 'package:flutter/material.dart';

class ChobaniService {
  final List chobaniFlavors = ['Blueberry', 'Strawberry', 'Coconut', 'Coffee', 'Peach'];
  final List<Product> _chobaniList = [];

  List<Product> getChobaniList(){
    for(String i in chobaniFlavors){
      _chobaniList.add(Product(name: 'Chobani Yogurt', expirationDate: 0, flavor: i, size: 5.3));
    }
    return _chobaniList;
  }
}

final chobaniService = ChobaniService();
