import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vendor_application/features/cart/view/success_page.dart';
import 'package:vendor_application/features/cart/view_model/cart_provider.dart';
import 'package:vendor_application/features/custom_app_bar.dart';
import 'package:vendor_application/features/product_detail/view/product_detail_screen.dart';
import 'package:vendor_application/reuse_functions.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}
List cartItems = [];

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: Column(
        mainAxisAlignment: .start,
        children: [
          Text(
            "Products : ",
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  padding: EdgeInsetsGeometry.all(5),
                  itemBuilder: (context, index) {
                    final product = value.cartItems[index];
                    cartItems = value.cartItems;
                    ReuseFunctions.logPrint().i(cartItems.length.toString());
                    return GestureDetector(
                      onTap: () {
                        context.read<CartProvider>().setProductDetails(product);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailScreen();
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(10),
                        child: Row(
                          // crossAxisAlignment: .start,
                          children: [
                            Container(
                              height: 100.h,
                              width: 100.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(product.image.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // alignment: Alignment.bottomRight,
                              /*   child: IconButton(
                              onPressed: () {
                                if (cartItems.contains(product.id)) {
                                  cartItems.remove(product.id);
                                } else {
                                  cartItems.add(product.id);
                                }
                                setState(() {});
                              },
                              icon: Icon(
                                cartItems.contains(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                         */
                            ),

                            SizedBox(width: 8.h),
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(product.name.toString()),
                                Text(
                                  product.sku.toString(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Rs. ${product.price}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Color(0xffDD8560),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Quantity : ${product.count?.toInt()}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Color.fromARGB(255, 121, 96, 221),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Sub Total :  Rs. ${context.read<CartProvider>().calculateSubTotal(product)}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Color.fromARGB(255, 121, 96, 221),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: value.cartItems.length,
                );
              },
            ),
          ),
          Text("Total : ${context.read<CartProvider>().calculateTotal()}"),
         
          ElevatedButton(onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SuccessPage()),
            );
          }, child: Text("Confirm the cart"))
        ],
      ),
    );
  }
}
