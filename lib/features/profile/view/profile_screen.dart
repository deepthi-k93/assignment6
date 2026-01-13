import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_application/features/custom_app_bar.dart';
import 'package:vendor_application/features/register_vendor/model/vendor_model.dart';
import 'package:vendor_application/reuse_functions.dart';
import 'package:vendor_application/theme/values.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

var logger = ReuseFunctions().logPrint();

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getDetails();
    super.initState();
  }

  var box = Hive.box(Values.dbName);
  VendorModel? vendorDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: Text(
        vendorDetails?.username ?? "No Data",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  Future<void> getDetails() async {
    logger.i("start");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs
        .getString("loggedInUser")
        .toString(); // get Shared preference stored value
    String? user1 = box.get(user); // get Hive stored value
    if (user1 == null) {
      return;
    } else {
      logger.i(user1);
    }
    Map<String, dynamic> userMap = jsonDecode(user1) as Map<String, dynamic>;
    vendorDetails = VendorModel.fromJson(userMap);
    logger.i(vendorDetails?.username);
    setState(() {
      
    });
  }
}
