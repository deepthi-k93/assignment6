import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vendor_application/features/cart/model/cart_product_model.dart';
import 'package:vendor_application/features/cart/view_model/cart_provider.dart';
import 'package:vendor_application/features/custom_app_bar.dart';
import 'package:vendor_application/features/home/model/product_model.dart';
import 'package:vendor_application/features/home/view_model/products_provider.dart';
import 'package:vendor_application/theme/colors.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductDetailScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter <= 0) {
        _counter = 0;
      } else {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = context.watch<ProductsProvider>();
    ProductModel? product = productsProvider.productDetails;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              product?.name ?? "Product Name",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 30,
                fontFamily: "TenorSans",
              ),
            ),
            SizedBox(height: 20),

            Image.network(product?.image ?? "", fit: BoxFit.cover),
            SizedBox(height: 20),

            Text(
              product?.sku ?? "SKU",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 30,
                fontFamily: "TenorSans",
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  backgroundColor: MyColours.buttonBgColour,
                  child: Icon(Icons.remove),
                ),
                SizedBox(width: 30.0),

                Text(
                  '$_counter',
                  style: TextStyle(fontSize: 48.0, color: MyColours.iconsColor),
                ),

                SizedBox(width: 30.0),

                FloatingActionButton(
                  onPressed: _incrementCounter,
                  backgroundColor: MyColours.buttonBgColour,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                var data = "";
                if (_counter > 0) {
                  CartProductModel prod = CartProductModel(
                    id: product?.id,
                    name: product?.name,
                    image: product?.image,
                    sku: product?.sku,
                    price: product?.price,
                    count: _counter,
                  );
                  context.read<CartProvider>().addToCartItems(prod);
                  data = "Added";
                } else {
                  data = "Set count";
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      data,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColours.bgColor,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.h,
                  fontStyle: FontStyle.normal,
                ),
                minimumSize: Size(180.w, 45.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              child: Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 15),
                  Text("Add to cart"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
