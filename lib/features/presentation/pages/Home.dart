import 'package:expiration_date/core/util/addDialogBox.dart';
import 'package:expiration_date/core/util/dialogBox.dart';
import 'package:expiration_date/features/presentation/pages/Expired.dart';
import 'package:expiration_date/features/presentation/pages/Inventory.dart';
import 'package:expiration_date/features/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:expiration_date/features/data/modles.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Product> showingProducts = [];

  final _controller = TextEditingController();
  DateTime? _selectedDate;
  String? _flavor;
  double? _size;
  int currentPageIndex = 0;



  void saveNewProduct() {
    if (_controller.text.isEmpty || _selectedDate == null || _selectedDate!.difference(DateTime.now()).inHours < 0 || _flavor == null || _size == null) {
      return;
    }
    else {
      setState(() {
        showingProducts.add(Product(name: _controller.text, expirationDate: productService.productDate(_selectedDate!), flavor: _flavor!, size: _size!));
        if (!productService.productInList(_controller.text)) {
          productService.addProduct(Product(name: _controller.text, expirationDate: 0, flavor: 'none', size: 0));
        }
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void addNewProduct() {
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onDateSelected: (selectedDate){
          _selectedDate = selectedDate;
        },
        onSave: saveNewProduct,
        onCancel: () => Navigator.of(context).pop(),
        flavor: (flavor){
          _flavor = flavor;
        },
        size: (size){
          _size = size;
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
        TextButton(
          child: const Text('Add product to inventory', style: TextStyle(color: Colors.black, fontSize: 16),),
          onPressed: () {
            showDialog(context: context, builder: (context) {
              return AddDialogBox(
                  controller: _controller,
                  onCancel: () => Navigator.of(context).pop()
              );
            });
          },
        )],
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
        backgroundColor: Colors.grey[300]
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
            currentPageIndex = index;
          });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.inventory)),
              label: 'Inventory',

            ),
            NavigationDestination(
              icon: Badge(
              child: Icon(Icons.delete_forever_sharp),),
              label: 'Expired'
              ,)
          ]
      ),

      body: <Widget>[
         Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10.0),

            Expanded(
              child: showingProducts.isNotEmpty
            ? ListView.builder(
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
                          Text(
                              '${showingProducts[index].getName()}(${showingProducts[index].getFlavor()})(${showingProducts[index].getSize()}oz)',
                              style: const TextStyle(fontSize: 16)),

                          Text('${showingProducts[index].getExpirationDate()} days left', style: const TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                  );
                },
              )
              : const Center(
                  child: Text(
                  'No available products',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),

        InventoryPage(),

        ExpiredPage(expiredList: showingProducts,)
      ][currentPageIndex],
    );
  }
}