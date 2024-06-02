import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/data/ProductModel.dart';
import 'package:project/data/DatabaseHelper.dart';
import 'package:project/main.dart';

class addUpdateProductForm extends StatefulWidget {
  final bool isUpdate;
  final ProductModel? productModel;

  const addUpdateProductForm(
      {super.key, required this.isUpdate, this.productModel});

  @override
  State<addUpdateProductForm> createState() => _addUpdateProductFormState();
}

class _addUpdateProductFormState extends State<addUpdateProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  List<String> categoryOptions = ['Outdoor', 'Indoor', 'Seed', 'Accessory'];
  String selectedCategory = 'Outdoor'; // Initially selected value

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate && widget.productModel != null) {
      // Pre-fill form fields if isUpdate is true and castle is provided
      _nameController.text = widget.productModel!.productDataModel?.name ?? '';
      _imageController.text =
          widget.productModel!.productDataModel?.image ?? '';
      _categoryController.text =
          widget.productModel!.productDataModel?.category ?? '';
      _priceController.text =
          widget.productModel!.productDataModel?.price.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Product")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.yard),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: widget.productModel?.productDataModel?.category?? null,
              items: categoryOptions.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _categoryController.text = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Category', // Label text
                prefixIcon: Icon(Icons.category), // Prefix icon
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select product category';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                prefixIcon: Icon(Icons.image),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixIcon: Icon(Icons.monetization_on_outlined),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product price';
                }
                if ((double.tryParse(value)!) <= 0) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            // Latitude TextFormField
            ElevatedButton(
                onPressed: _submitForm,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.update),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Submit")
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ProductDataModel productDataModel = ProductDataModel(
        _imageController.text,
        _nameController.text,
        _categoryController.text,
        double.tryParse(_priceController.text),
      );

      if (widget.isUpdate) {
        // Update the existing castle
        DatabaseHelper.update(
            widget.productModel!.key!, productDataModel, context);
      } else {
        // Add a new castle
        DatabaseHelper.create(productDataModel);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );

      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Castle added successfully!')),
      );*/

      //Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
