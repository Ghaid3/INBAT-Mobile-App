class ProductModel {
  String? key;
  ProductDataModel? productDataModel;
  int quantity; // Add quantity property

  ProductModel(this.key, this.productDataModel, this.quantity); // Update constructor
}

class ProductDataModel{
  String? image;
  String? name;
  String? category;
  double? price;


  ProductDataModel(this.image, this.name, this.category, this.price);

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "name": name,
      "category": category,
      "price": price,

    };
  }

  ProductDataModel.fromJson(Map<dynamic, dynamic> json) {
    image = json["image"];
    name = json["name"];
    category = json["category"];
    price = checkDouble(json["price"]);

  }

  double? checkDouble(value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return double.parse(value.toString());
    } else {
      return 0.0;
    }
  }
}