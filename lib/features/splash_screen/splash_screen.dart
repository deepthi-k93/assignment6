import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_application/features/home/view/home_screen.dart';
import 'package:vendor_application/features/login/view/login_screen.dart';
import 'package:vendor_application/features/register_vendor/model/vendor_model.dart';
import 'package:vendor_application/reuse_functions.dart';
import 'package:vendor_application/theme/colors.dart';
import 'package:vendor_application/theme/values.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required String title});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

bool userIsLoggedIn = false;
var logger = ReuseFunctions().logPrint();

class _SplashScreenState extends State<SplashScreen> {
  var box = Hive.box(Values.dbName);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => homeOrLogin());
  }

  Future<void> homeOrLogin() async {
    Iterable<dynamic> keys = box.keys;
    logger.i(keys);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userIsLoggedIn = prefs.containsKey("loggedIn");

    Timer(Duration(seconds: 10), () {
      if (userIsLoggedIn) {
        String? user = prefs.getString("loggedInUser").toString();

        String? user1 = box.get(user);

        // String? user1 = prefs.getString(user);
        if (user1 == null) {
          return;
        } else {
          logger.i(user1);
        }
        Map<String, dynamic> userMap =
            jsonDecode(user1) as Map<String, dynamic>;
        var userName = VendorModel.fromJson(userMap).username;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(loggedUser: userName),
          ),
        );
      } else {
        // Call setState() or update state here

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.bgColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Image.asset(
            "images/logo/vendoor-logo.png",
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
