class Product {

  final String name;
  final int expirationDate;
  final double size;
  final String flavor;

  Product({required this.name, required this.expirationDate, required this.flavor, required this.size});

  String getName(){return name;}

  int getExpirationDate(){return expirationDate;}

  String getFlavor(){return flavor;}

  double getSize(){return size;}
}

class Item {
  Item({
    required this.category,
    required this.sizes,
    this.isExpanded = false
  });

  String category;
  List<Size> sizes;
  bool isExpanded;
}

class Size {
  Size({
    required this.name,
    required this.products,
  });

  String name;
  List<Product> products;
}
