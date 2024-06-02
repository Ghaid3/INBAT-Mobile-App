import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/addUpdateProductForm.dart';
import 'ProductListScreen.dart'; // Import the IndoorPlantScreen class

class ProductCategoryList extends StatefulWidget {
  const ProductCategoryList({Key? key}) : super(key: key);

  @override
  State<ProductCategoryList> createState() => _ProductCategoryListState();
}

class _ProductCategoryListState extends State<ProductCategoryList> {
  @override
  Widget build(BuildContext context) {
    // Create an instance of ProductModel to pass to IndoorPlantScreen
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Opacity(
            opacity: 0.8,
            child: Image.asset(
              'images/back.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of the background image
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0, bottom: 100),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 400,
                          height: 120,
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to indoor plant list screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductListScreen(
                                      category:
                                          "Indoor"), // Pass the plant model
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Background Image with Border Radius and Shadow
                                Container(
                                  width: 400,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Image.asset(
                                        'images/try.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                // Text on top of the image
                                const Text(
                                  'Indoor plants',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            blurRadius: 30, color: Colors.black)
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        // Other buttons go here
                        SizedBox(
                          width: 400,
                          height: 120,
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to indoor plant list screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductListScreen(
                                      category:
                                          "Outdoor"), // Pass the plant model
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Background Image with Border Radius and Shadow
                                Container(
                                  width: 400,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Image.asset(
                                        'images/out.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                // Text on top of the image
                                const Text(
                                  'Outdoor plants',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            blurRadius: 30, color: Colors.black)
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 400,
                          height: 120,
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to indoor plant list screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductListScreen(
                                      category: "Seed"), // Pass the plant model
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Background Image with Border Radius and Shadow
                                Container(
                                  width: 400,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Image.asset(
                                        'images/seeds.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                // Text on top of the image
                                const Text(
                                  'Seeds',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            blurRadius: 30, color: Colors.black)
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 400,
                          height: 120,
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to indoor plant list screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductListScreen(
                                      category:
                                          "Accessory"), // Pass the plant model
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Background Image with Border Radius and Shadow
                                Container(
                                  width: 400,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Image.asset(
                                        'images/accessories.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                // Text on top of the image
                                const Text(
                                  'Accessories',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            blurRadius: 30, color: Colors.black)
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        onPressed: addNewProduct,
        tooltip: 'addNewCastle',
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void addNewProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const addUpdateProductForm(isUpdate: false),
        //builder: (context) => const StaticImageListScreen(),
      ),
    );
  }
}
