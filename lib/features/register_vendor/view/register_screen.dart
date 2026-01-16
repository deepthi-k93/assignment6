import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vendor_application/features/register_vendor/model/vendor_model.dart';
import 'package:vendor_application/reuse_functions.dart';
import 'package:vendor_application/theme/colors.dart';
import 'package:vendor_application/theme/values.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String cusName = '';
  String email = '';
  String phno = '';
  String userName = '';
  String pwd = '';
  String cnfrmPwd = '';
  var box = Hive.box(Values.dbName);

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
          // mainAxisAlignment: .center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter customer name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        cusName = value!;
                      },
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email address",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Phone Number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phno = value!;
                      },
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userName = value!;
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
                      onChanged: (value) {
                        pwd = value;
                        setState(() {});
                      },

                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      obscureText: true,

                      key: Key('password'),
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      obscureText: true,

                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Password is required';
                        } else if (value.trim() != pwd) {
                          return 'Passwords must be same';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        cnfrmPwd = newValue!;
                      },
                    ),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // var uuid = Uuid();
                  // var uuidV8 = uuid.v8();
                  // print("id :$uuidV8");
                  VendorModel user = VendorModel(
                    name: cusName,
                    email: email,
                    phoneNo: phno,
                    username: userName,
                    password: pwd,
                    confirmPassword: cnfrmPwd,
                  );
                  ReuseFunctions.logPrint().i(user);
                  String userJson = jsonEncode(user.toJson());
                  //add
                  box.put(email, userJson);
                  //retrive
                  String? user1 = box.get(email);
                  if (user1 == null) {
                    return;
                  }
                  Map<String, dynamic> userMap =
                      jsonDecode(user1) as Map<String, dynamic>;

                  String msg =
                      "Registered Successfully Name :${VendorModel.fromJson(userMap).name}";

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
                  Navigator.pop(context);
                }
              },
              child: Text(
                "  Register  ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
