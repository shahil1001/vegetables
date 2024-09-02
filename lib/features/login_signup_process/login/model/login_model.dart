class LoginModel {
  String? title;
  String? message;
  Data? data;

  // Constructor
  LoginModel({this.title, this.message, this.data});

  // Named constructor to create an instance from JSON
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      title: json['title'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (title != null) data['title'] = title;
    if (message != null) data['message'] = message;
    if (this.data != null) data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  String userToken;
  String id;
  String name;
  String mobile;
  String email;

  // Constructor
  Data({
    required this.userToken,
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
  });

  // Named constructor to create an instance from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userToken: json['user_token'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_token'] = userToken;
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}
