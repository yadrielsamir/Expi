import 'package:expiration_date/features/data/modles.dart';
import 'package:expiration_date/features/services/chobaniService.dart';

class ProductService {
   final List<Product> _productList = chobaniService.getChobaniList();

  List<Product> get productList => _productList;

  void addProduct(Product product) {
    _productList.add(product);
  }

  void removeProduct(Product product) {
    _productList.remove(product);
  }

   bool productInList(String productName) {
     for (var i in _productList) {
       if (i.name == productName) {
         return true;
       }
     }
     return false;
   }

   int productDate(DateTime date){
    return date.difference(DateTime.now()).inDays;
   }

  List<Product> searchProducts(String query) {
    return _productList.where((product) {
      final productNameLower = product.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return productNameLower.contains(queryLower);
    }).toList();
  }
}

final productService = ProductService();

