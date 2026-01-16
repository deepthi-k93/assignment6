import 'package:flutter/material.dart';
import 'package:vendor_application/features/home/model/product_model.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> productsList = [
    ProductModel(
      id: 1,
      name: 'Essence Mascara Lash Princess',
      sku: "BEA-ESS-ESS-001",
      image:
          "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp",
      price: 299,
    ),

    ProductModel(
      id: 2,
      name: "Eyeshadow Palette with Mirror",
      sku: "BEA-GLA-EYE-002",
      image:
          "https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/1.webp",
      price: 450,
    ),
    ProductModel(
      id: 3,
      name: 'Red Lipstick',
      image:
          "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/1.webp",
      sku: 'BEA-CHI-LIP-004',
      price: 499,
    ),
    ProductModel(
      id: 4,
      name: 'Red Nail Polish',
      image:
          "https://cdn.dummyjson.com/product-images/beauty/red-nail-polish/1.webp",
      sku: "BEA-NAI-NAI-005",
      price: 70,
    ),
    ProductModel(
      id: 5,
      name: 'Calvin Klein CK One',
      image:
          "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/1.webp",
      sku: 'FRA-CAL-CAL-006',
      price: 999,
    ),
    ProductModel(
      id: 6,
      name: 'Gucci Bloom Eau de',
      image:
          "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/1.webp",

      sku: 'FRA-GUC-GUC-010',
      price: 1999,
    ),
     ProductModel(
      id: 7,
      name: 'Red Nail Polish',
      image:
          "https://cdn.dummyjson.com/product-images/beauty/red-nail-polish/1.webp",
      sku: "BEA-NAI-NAI-006",
      price: 70,
    ),
    ProductModel(
      id: 8,
      name: 'Calvin Klein CK One',
      image:
          "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/1.webp",
      sku: 'FRA-CAL-CAL-007',
      price: 999,
    ),
    ProductModel(
      id: 9,
      name: 'Gucci Bloom Eau de',
      image:
          "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/1.webp",

      sku: 'FRA-GUC-GUC-011',
      price: 1999,
    ),
     ProductModel(
      id: 10,
      name: "Eyeshadow Palette with Mirror",
      sku: "BEA-GLA-EYE-003",
      image:
          "https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/1.webp",
      price: 450,
    ),
    
  ];
  ProductModel? productDetails;
  void setProductDetails(ProductModel product) {
    productDetails = product;
    notifyListeners();
  }
}
