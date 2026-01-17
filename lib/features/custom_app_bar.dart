import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';
import 'package:vendor_application/features/cart/view/cart_screen.dart';
import 'package:vendor_application/features/cart/view/empty_cart.dart';
import 'package:vendor_application/features/cart/view_model/cart_provider.dart';
import 'package:vendor_application/features/profile/view/profile_screen.dart';
import 'package:vendor_application/theme/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    int cartProducts = 0;
    return AppBar(
      backgroundColor: MyColours.bgColor,
      actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu, color: MyColours.iconsColor),
      ),
      title: Image.asset("images/logo/vendoor-logo-transparent.png"),

      centerTitle: true,

      actions: [
        Badge(
          position: BadgePosition.topEnd(top: 1, end: 1),
          badgeAnimation: BadgeAnimation.slide(
            animationDuration: Duration(milliseconds: 300),
            toAnimate: true,
          ),
          badgeStyle: BadgeStyle(
            badgeColor: MyColours.iconsColor,
            padding: EdgeInsetsGeometry.all(5),
          ),
          badgeContent: Consumer<CartProvider>(
            builder: (context, cartCounter, child) {
              cartProducts = cartCounter.countProducts();
              return Text(
                cartProducts.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          child: IconButton(
            onPressed: () {
              if (cartProducts > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              } else {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmptyCart()),
                );
              }
            },
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: MyColours.iconsColor,
            ),
          ),
        ),

        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          icon: Icon(
            Icons.account_circle_outlined,
            color: MyColours.iconsColor,
          ),
        ),
      ],
    );
  }
}
