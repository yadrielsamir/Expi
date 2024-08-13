class Product {

  final String name;
  final int expirationDate;

  Product({required this.name, required this.expirationDate});

  String getName(){return name;}

  int getExpirationDate(){return expirationDate;}
}
