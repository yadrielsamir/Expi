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
