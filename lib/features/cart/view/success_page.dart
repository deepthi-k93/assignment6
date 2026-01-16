import 'package:flutter/material.dart';
import 'package:vendor_application/features/custom_app_bar.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: Padding(padding: const EdgeInsetsGeometry.all(10),child:Image.asset("images/success_image.jpg") ,)
          );
  }
}
