import 'package:flutter/material.dart';
import 'package:project/SMS_Email_Notification/notification.dart';
import 'package:project/screens/addUpdateProductForm.dart';
import '../data/ProductModel.dart';
import '../data/DatabaseHelper.dart';
import 'CartScreen.dart'; // Import the CartScreen

enum SortingOption { None, Ascending, Descending }

class ProductListScreen extends StatefulWidget {
  final String category;
  const ProductListScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductModel> productList = [];
  List<ProductModel> filteredProductList = [];
  List<ProductModel> cartList = [];
  List<int> selectedQuantities =
      []; // List to store selected quantity for each product
  int shoppingBagCount = 0;
  SortingOption sortingOption = SortingOption.None;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    NotificationWidget.init();
    DatabaseHelper.readByCategory(widget.category, (productsList) {
      setState(() {
        productList = productsList;
        filteredProductList = productList;
        // Initialize selected quantities list with default value of 1
        selectedQuantities = List<int>.filled(productList.length, 1);
      });
    });
  }

  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProductList = productList;
      } else {
        filteredProductList = productList
            .where((product) =>
        product.productDataModel?.name
            ?.toLowerCase()
            .contains(query.toLowerCase()) ?? false)
            .toList();
      }
    });
  }

  void sortProducts() {
    setState(() {
      switch (sortingOption) {
        case SortingOption.None:
          break;
        case SortingOption.Ascending:
          filteredProductList.sort((a, b) =>
              (a.productDataModel?.price ?? 0).compareTo(b.productDataModel?.price ?? 0));
          break;
        case SortingOption.Descending:
          filteredProductList.sort((a, b) =>
              (b.productDataModel?.price ?? 0).compareTo(a.productDataModel?.price ?? 0));
          break;
      }
    });
  }

  void addToCart(ProductModel productModel, int quantity) {
    setState(() {
      if (quantity > 0) {
        bool productAlreadyInCart = false;

        // Check if the product is already in the cart list
        for (var item in cartList) {
          if (item.productDataModel?.name ==
              productModel.productDataModel?.name) {
            // If the product is found, update its quantity
            item.quantity += quantity;
            productAlreadyInCart = true;
            break; // Exit the loop since the product is found
          }
        }

        // If the product is not already in the cart list, add it
        if (!productAlreadyInCart) {
          for (int i = 0; i < quantity; i++) {
            cartList.add(ProductModel(
                productModel.key, productModel.productDataModel, 1));
          }
        }

        // Update shopping bag count, ensuring it's always positive or zero
        shoppingBagCount =
            (shoppingBagCount + quantity).clamp(0, double.infinity).toInt();
      } else {
        // If the quantity is negative or zero, do not add the product to the cart
        // You can show an error message here if needed
        print('Invalid quantity');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen(
                            cartList: cartList,
                            onDelete: (product) {
                              setState(() {
                                cartList.remove(product);
                                shoppingBagCount -= product.quantity;
                              });
                            })), // Pass the updated CartList and onDelete function
                  );
                },
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    shoppingBagCount.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
                controller: searchController,
                onChanged: filterProducts,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            Row(
              children: [
                const Text("Sort:"),
                const SizedBox(width: 20),
                DropdownButton<SortingOption>(
                  value: sortingOption,
                  onChanged: (value) {
                    setState(() {
                      sortingOption = value!;
                      sortProducts();
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: SortingOption.None,
                      child: Text('None'),
                    ),
                    DropdownMenuItem(
                      value: SortingOption.Ascending,
                      child: Text('Price: Low to High'),
                    ),
                    DropdownMenuItem(
                      value: SortingOption.Descending,
                      child: Text('Price: High to Low'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProductList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Image(
                            width: 110,
                            image: NetworkImage(
                              filteredProductList[index].productDataModel?.image ?? '',
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredProductList[index].productDataModel?.name ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${filteredProductList[index].productDataModel?.price?.toString()} OMR",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text('Quantity: '),
                                    DropdownButton<int>(
                                      value: selectedQuantities[index],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedQuantities[index] = value!;
                                        });
                                      },
                                      items: List.generate(
                                        10,
                                        (index) => index + 1,
                                      )
                                          .map(
                                            (value) => DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(value.toString()),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          addUpdateProductForm(
                                              isUpdate: true,
                                              productModel: filteredProductList[index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Update',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (filteredProductList[index].key != null &&
                                      filteredProductList[index]
                                              .productDataModel
                                              ?.name !=
                                          null) {
                                    String productName = filteredProductList[index]
                                        .productDataModel!
                                        .name!;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Deletion'),
                                          content: Text(
                                              'Are you sure you want to delete the product ${productList[index].productDataModel!.name!}?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                DatabaseHelper.delete(
                                                    filteredProductList[index].key!);
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          '$productName product deleted')),
                                                );
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductListScreen(
                                                              category: widget
                                                                  .category)),
                                                  (Route<dynamic> route) =>
                                                      false,
                                                );
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  addToCart(productList[index],
                                      selectedQuantities[index]);
                                  NotificationWidget.showNotification(title: 'Added to Cart', body: 'Product added successfully');
                                },
                                child: Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Add to Cart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
