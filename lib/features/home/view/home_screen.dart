import 'package:flutter/material.dart';
import 'package:vendor_application/features/custom_app_bar.dart';

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
      body: Text("Profile", style: TextStyle(color: Colors.purple)),
    );
  }
}
