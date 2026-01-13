class VendorModel {
  // late String id;
  late String name;
  late String email;
  late String phoneNo;
  late String username;
  late String password;
  late String confirmPassword;

  VendorModel(
      {
        // required this.id,
      required this.name,
      required this.email,
      required this.phoneNo,
      required this.username,
      required this.password,
      required this.confirmPassword});

  VendorModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    username = json['username'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    data['username'] = username;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}