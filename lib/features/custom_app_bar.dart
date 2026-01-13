import 'package:flutter/material.dart';
import 'package:vendor_application/features/cart/view/cart_screen.dart';
import 'package:vendor_application/features/profile/view/profile_screen.dart';
import 'package:vendor_application/theme/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  

  @override
  Widget build(BuildContext context) {
     

    return AppBar(
      backgroundColor: MyColours().bgColor,
      actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu, color: MyColours().iconsColor),
      ),
      title:Image.asset("images/logo/vendoor-logo-transparent.png") ,
     
      centerTitle: true,

      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
          icon: Icon(Icons.shopping_bag_outlined, color: MyColours().iconsColor),
        ),
         IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          icon: Icon(Icons.account_circle_outlined, color: MyColours().iconsColor),
        )
      ],
    );
  }
}
