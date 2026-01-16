class CartProductModel {
  final int? id;
  final String? name;
  final String? sku;
  final int? price;
  final String? image;
  final int? count;
  CartProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.sku,
    required this.price, 
    required this.count,
  });
  // ProductModel(this. id ,this.name, this.description, this.price, this.image);
  // factory ProductModel.fromMap(Map<String, dynamic> json) {
  //   return ProductModel(
  //     json['id'],
  //     json['name'],
  //     json['description'],
  //     json['price'],
  //     json['image'],
  //   );
  // }
}
