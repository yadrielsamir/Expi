import 'package:expiration_date/features/data/modles.dart';

class ProductService {

   final List<Product> _suggestedProductsList = [
     Product(name: 'Chobani Yogurt', expirationDate: 0, flavor: 'NA', size: 0),
     Product(name: 'LaYogurt Yogurt', expirationDate: 0, flavor: 'NA', size: 0),
     Product(name: 'Oiko Yogurt', expirationDate: 0, flavor: 'NA', size: 0),
     Product(name: 'Chobani Yogurt', expirationDate: 0, flavor: 'NA', size: 0),
     Product(name: 'Owi Yogurt', expirationDate: 0, flavor: 'NA', size: 0),
     Product(name: 'Activia Yogurt', expirationDate: 0, flavor: 'NA', size: 0)
   ];

   final List<double> _sizesList = [5.3, 20.1, 16.7, 6.0];

   final List<String> _flavorsList = ['Blueberry', 'Strawberry', 'Coconut', 'Coffee', 'Peach'];

   final List<Product> _expiredProductsList = [];

   List<Product> getExpiredProductsList(List<Product> list){
    _expiredProductsList.clear();
    for(Product product in list){
      if(product.getExpirationDate() == 0){
        _expiredProductsList.add(product);
      }
    }
    return _expiredProductsList;
  }

  List<Product> getSuggestedProductsList(){
    return _suggestedProductsList;
  }

   List<double> getSizesList(){
     return _sizesList;
   }

   List<String> getFlavorsList(){
     return _flavorsList;
   }

  void addSuggestedProduct(Product product){
    _suggestedProductsList.add(product);
  }

   int productDate(DateTime date){
    return date.difference(DateTime.now()).inDays + 1;
   }
}

final productService = ProductService();

