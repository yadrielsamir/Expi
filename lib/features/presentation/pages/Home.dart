import 'package:expiration_date/core/util/dialogBox.dart';
import 'package:expiration_date/features/presentation/pages/Expired.dart';
import 'package:expiration_date/features/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:expiration_date/features/data/modles.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Product> showingProducts = [Product(name: 'Butter', expirationDate: 2)];

  final _controller = TextEditingController();
  DateTime? _selectedDate;



  void saveNewProduct() {
    if (_controller.text.isEmpty || _selectedDate == null) {
      return;
    }
    else {
      setState(() {
        showingProducts.add(Product(
            name: _controller.text, expirationDate: productService.productDate(_selectedDate!)));
        if (!productService.productInList(_controller.text)) {
          productService.addProduct(Product(name: _controller.text, expirationDate: productService.productDate(_selectedDate!)));
        }
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void addNewProduct(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewProduct,
        onCancel: () => Navigator.of(context).pop(),
        onDateSelected: (selectedDate){
          _selectedDate = selectedDate;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Expi',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight:FontWeight.bold,
                  fontSize: 25
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewProduct,
        backgroundColor: Colors.grey,
        child:const Icon(Icons.add),
      ),

      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.grey[500],
          onDestinationSelected: (int index){
          setState(() {

          });
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.inventory)),
              label: 'Products',

            ),
            NavigationDestination(
              icon: Badge(
              child: Icon(Icons.delete_forever_sharp),),
              label: 'Expired'
              ,)
          ]
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10.0),

          Expanded(
            child: ListView.builder(
              itemCount: showingProducts.length,
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
                        Text(showingProducts[index].getName(), style: const TextStyle(fontSize: 16)),

                        Text('${showingProducts[index].getExpirationDate()} days left', style: const TextStyle(fontSize: 16),),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}