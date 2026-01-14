// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_application/features/custom_app_bar.dart';
import 'package:vendor_application/features/register_vendor/model/vendor_model.dart';
import 'package:vendor_application/features/splash_screen/splash_screen.dart';
import 'package:vendor_application/reuse_functions.dart';
import 'package:vendor_application/theme/colors.dart';
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
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: .spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "Profile Details",
                    style: TextStyle(fontSize: 45.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove("loggedIn");
                    await prefs.remove("loggedInUser");
                    await prefs.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Logged Out",
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SplashScreen(title: 'Vendoors'),
                      ),
                    );
                  },
                  child: Icon(Icons.logout),
                ),
              ],
            ),

            Divider(color: MyColours.iconsColor, thickness: 1),

            Container(
              height: 60,
              decoration: BoxDecoration(
                color: MyColours.buttonBgColour,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: .spaceAround,

                children: [
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "Name :",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    vendorDetails?.name ?? "No Data",
                    style: TextStyle(fontSize: 25, color: MyColours.purple),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: MyColours.buttonBgColour,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: .spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "Email \n Address :",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    vendorDetails?.email ?? "No Data",
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25, color: MyColours.purple),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: MyColours.buttonBgColour,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: .spaceAround,

                children: [
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "Phone No. :",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    vendorDetails?.phoneNo ?? "No Data",
                    style: TextStyle(fontSize: 25, color: MyColours.purple),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: MyColours.buttonBgColour,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: .spaceAround,

                children: [
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "User Name :",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    vendorDetails?.username ?? "No Data",
                    style: TextStyle(fontSize: 25, color: MyColours.purple),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
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
    setState(() {});
  }
}
