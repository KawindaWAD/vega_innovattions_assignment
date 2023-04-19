import 'dart:convert';

import 'package:equatable/equatable.dart';

List<RegisteredUserModel> registeredUserModelFromJson(String str) =>
    List<RegisteredUserModel>.from(
        json.decode(str).map((x) => RegisteredUserModel.fromJson(x)));

String registeredUserModelToJson(List<RegisteredUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisteredUserModel extends Equatable {
  const RegisteredUserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  factory RegisteredUserModel.fromJson(Map<String, dynamic> json) =>
      RegisteredUserModel(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
      };

  @override
  List<Object> get props => [name, email, phoneNumber, password];
}
