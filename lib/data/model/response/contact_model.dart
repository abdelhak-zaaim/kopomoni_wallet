
import 'dart:convert';

List<ContactModel> contactModelFromJson(String str) => List<ContactModel>.from(json.decode(str).map((x) => ContactModel.fromJson(x)));

String contactModelToJson(List<ContactModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactModel {
  ContactModel({
    this.phoneNumber,
    this.name,
    this.avatarImage,
  });

  String? phoneNumber;
  String? name;
  String? avatarImage;

  factory ContactModel.fromJson(Map<String, dynamic> json)=> ContactModel(
    phoneNumber: json["phoneNumber"],
    name: json["name"],
    avatarImage: json["avatarImage"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "name": name,
    "avatarImage": avatarImage,
  };
}
