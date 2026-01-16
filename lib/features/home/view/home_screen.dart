import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vendor_application/features/custom_app_bar.dart';
import 'package:vendor_application/features/home/view_model/products_provider.dart';
import 'package:vendor_application/features/product_detail/view/product_detail_screen.dart';
import 'package:vendor_application/reuse_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String loggedUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SizedBox(height: 17.h),
            Expanded(
              child: Consumer<ProductsProvider>(
                builder: (context, value, child) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 165.w / 240.h,
                    ),
                    itemBuilder: (context, index) {
                      ReuseFunctions.logPrint().i(value);
                      final product = value.productsList[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<ProductsProvider>().setProductDetails(
                            product,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailScreen();
                              },
                            ),
                          );
                        },
                        child: Column(
                          // crossAxisAlignment: .stretch,
                          mainAxisAlignment: .center,
                          children: [
                            Container(
                              height: 170.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(product.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: Alignment.bottomRight,
                              // child:
                            ),

                            SizedBox(height: 8.h),
                            Text(product.name),
                            Text(
                              product.sku,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              ' ₹ . ${product.price}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0xffDD8560),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: value.productsList.length,
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
