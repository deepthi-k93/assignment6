class ProductModel {
  final int id;
  final String name;
  final int price;
  final String sku;
  final String image;
  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.sku,
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
