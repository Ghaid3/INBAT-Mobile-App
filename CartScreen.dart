import 'package:flutter/material.dart';
import 'package:project/SMS_Email_Notification/notification.dart';
import '../data/ProductModel.dart'; // Import the ProductModel
import 'package:project/screens/MapScreen.dart';

class CartScreen extends StatefulWidget {
  final List<ProductModel> cartList;
  final Function(ProductModel) onDelete;

  const CartScreen({Key? key, required this.cartList, required this.onDelete})
      : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // Calculate the total price of items in the cartList
    double totalPrice = widget.cartList.fold(
        0,
        (sum, item) =>
            sum + (item.productDataModel?.price ?? 0) * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: widget.cartList.isEmpty ? const Center(
              child: Text('Your Cart is Empty'),
            )
          : ListView.builder(
              itemCount: widget.cartList.length,
              itemBuilder: (context, index) {
                ProductModel product = widget.cartList[index];

                return ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image(
                      image: NetworkImage(
                          product.productDataModel?.image ?? ''),
                      fit: BoxFit.cover, // Adjust image fit as needed
                    ),
                  ),
                  title: Text(product.productDataModel?.name ?? ''),
                  subtitle: Text('Quantity: ${product.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          widget
                              .onDelete(product); // Call the onDelete function
                        },
                      ),
                      Text(
                        '${(product.productDataModel?.price ?? 0) * product.quantity} OMR',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.cartList.isEmpty
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total: ${totalPrice.toStringAsFixed(2)} OMR',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _displayMap(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 8),
                      Text('Display Shop Location', style: TextStyle(color:Colors.white, fontSize: 18)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Implement your payment logic here
                    // This is just a placeholder
                    print('Payment logic goes here');
                    NotificationWidget.showNotification(title: 'Payment', body: 'Your payment ${totalPrice.toStringAsFixed(2)} OMR done successfully');
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Center(
                      child: Text(
                        'Pay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// Parent widget that holds the CartScreen
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductModel> cartList = []; // Cart list
  double totalPrice = 0; // Total price

  // Function to handle deletion of items from the cart
  void deleteItem(ProductModel product) {
    setState(() {
      // Remove the product from the cart list
      cartList.remove(product);

      // Recalculate the total price
      totalPrice = cartList.fold(
          0,
          (sum, item) =>
              sum + (item.productDataModel?.price ?? 0) * item.quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: CartScreen(
        cartList: cartList,
        onDelete: deleteItem,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen where user can add products to the cart
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _displayMap(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MapScreen()), // Pass the context to MapScreen
  );
}


