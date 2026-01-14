// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_application/features/home/view/home_screen.dart';
import 'package:vendor_application/features/register_vendor/model/vendor_model.dart';
import 'package:vendor_application/features/register_vendor/view/register_screen.dart';
import 'package:vendor_application/reuse_functions.dart';
import 'package:vendor_application/theme/colors.dart';
import 'package:vendor_application/theme/values.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();
String email = '';
String pwd = '';
bool obscureText = true;

class _LoginScreenState extends State<LoginScreen> {
  var box = Hive.box(Values.dbName);

  @override
  void initState() {
    ReuseFunctions().logPrint().i(box.keyAt(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: MyColours.bgColor,
        title: Image.asset("images/logo/vendoor-logo-transparent.png"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "User Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColours.iconsColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColours.iconsColor),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        pwd = value!;
                      },

                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(Icons.visibility_off),
                        ),
                      ),
                      obscureText: obscureText,
                      key: Key('password'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite, // Set the desired width
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          bool pr = box.containsKey(email);
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String msg = "";
                          // To write data
                          if (pr) {
                            msg = "Logged In ";
                            // To write data
                            await prefs.setBool("loggedIn", true);
                            await prefs.setString("loggedInUser", email);
                            // String? em = prefs
                            //     .getString("loggedInUser")
                            //     .toString();
                            String? user1 = box.get(email);
                            if (user1 == null) {
                              return;
                            }
                            Map<String, dynamic> userMap =
                                jsonDecode(user1) as Map<String, dynamic>;
                            var userName = VendorModel.fromJson(
                              userMap,
                            ).username;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(loggedUser: userName),
                              ),
                            );
                          } else {
                            msg = "User not present";
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  msg,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );
                          }
                          // To read data
                        }
                      },
                      child: Text(
                        "  Login  ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.maxFinite, // Set the desired width
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "  Create Account  ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
