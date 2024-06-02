import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/SMS_Email_Notification/notification.dart';

import 'ProductModel.dart';

class DatabaseHelper {
  static Future<void> delete(String key) async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    await db.child("Products").child(key).remove();
  }

  static Future<void> update(String key, ProductDataModel productDataModel,
      BuildContext context) async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    await db
        .child("Products")
        .child(key)
        .update(productDataModel.toJson())
        .then((_) {
      NotificationWidget.showNotification(title: 'Product Updation', body: 'Product updated successfully');
      // Show a snack bar on successful update
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product data updated successfully')),
      );
    }).catchError((error) {
      // Handle errors and show a different snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to update product data: ${error.toString()}')),
      );
    });
  }

  static Future<void> create(ProductDataModel productDataModel) {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    return db
        .child("Products")
        .push()
        .set(productDataModel.toJson())
        .then((value) => NotificationWidget.showNotification(title: 'Product Creation', body: 'Product created successfully'))
        .catchError((error) => print("Failed to create product data: $error"));
  }

  static void read(Function(List<ProductModel>) productsListCallback) {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    db.child("Products").onValue.listen((productsDataJson) {
      if (productsDataJson.snapshot.exists) {
        ProductDataModel productDataModel;
        ProductModel productModel;
        List<ProductModel> productsList = [];
        productsDataJson.snapshot.children.forEach((element) {
          productDataModel = ProductDataModel.fromJson(element.value as Map);
          productModel = ProductModel(element.key, productDataModel, 0);
          productsList.add(productModel);
        });
        productsListCallback(productsList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }

  static void readByCategory(String category, Function(List<ProductModel>) productsListCallback) {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    db.child("Products").orderByChild("category").equalTo(category).onValue.listen((productsDataJson) {
      if (productsDataJson.snapshot.exists) {
        ProductDataModel productDataModel;
        ProductModel productModel;
        List<ProductModel> productsList = [];
        productsDataJson.snapshot.children.forEach((element) {
          productDataModel = ProductDataModel.fromJson(element.value as Map);
          productModel = ProductModel(element.key, productDataModel,0);
          productsList.add(productModel);
        });
        productsListCallback(productsList);
      } else {
        print("No products found with category: $category");
        // Call the callback with an empty list if no products are found
        productsListCallback([]);
      }
    });
  }

  static void createNewDBWithUniqueIDs(
      String mainNodeName, List<Map<String, dynamic>> productsList) {
    DatabaseReference db = FirebaseDatabase.instance.ref(mainNodeName);
    if (productsList.isNotEmpty) {
      productsList.forEach((fort) {
        db
            .push()
            .set(fort)
            .then((value) => print("Products data successfully saved!"))
            .catchError(
                (error) => print("Failed to save products data: $error"));
      });
    } else {
      print("Products list is empty!");
    }
  }
}
