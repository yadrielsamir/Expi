import 'package:expiration_date/features/data/modles.dart';
import 'package:flutter/material.dart';

class ChobaniService {
  final List<String> chobaniFlavors = ['Blueberry', 'Strawberry', 'Coconut', 'Coffee', 'Peach'];
  final List<double> chobaniSizes = [5.3, 20.1, 16.7, 6.0];
  final List<Product> _chobaniList = [];

  List<String> getChobaniFlavors(){return chobaniFlavors;}

  List<double> getChobaniSizes(){return chobaniSizes;}

  List<Product> getChobaniList(){
    for(String i in chobaniFlavors){
      _chobaniList.add(Product(name: 'Chobani Yogurt', expirationDate: 0, flavor: i, size: 5.3));
    }
    return _chobaniList;
  }
}

final chobaniService = ChobaniService();
