// To parse this JSON data, do
//
//     final withdrawModel = withdrawModelFromJson(jsonString);

import 'dart:convert';

class WithdrawModel {
  WithdrawModel({
     this.message,
    required this.withdrawalMethods,
  });

  String? message;
  List<WithdrawalMethod> withdrawalMethods;

  factory WithdrawModel.fromRawJson(String str) => WithdrawModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WithdrawModel.fromJson(Map<String, dynamic> json) => WithdrawModel(
    withdrawalMethods: List<WithdrawalMethod>.from(json["content"].map((x) => WithdrawalMethod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "withdrawal_methods": List<dynamic>.from(withdrawalMethods.map((x) => x.toJson())),
  };
}

class WithdrawalMethod {
  WithdrawalMethod({
    this.id,
    required this.methodName,
    required this.methodFields,
  });

  int? id;
  String? methodName;
  List<MethodField> methodFields;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory WithdrawalMethod.fromRawJson(String str) => WithdrawalMethod.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WithdrawalMethod.fromJson(Map<String, dynamic> json) => WithdrawalMethod(
    id: json["id"],
    methodName: json["method_name"],
    methodFields: List<MethodField>.from(json["method_fields"].map((x) => MethodField.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method_name": methodName,
    "method_fields": List<dynamic>.from(methodFields.map((x) => x.toJson())),
  };
}

class MethodField {
  MethodField({
    required this.inputName,
    required this.inputType,
    required this.placeHolder,
    this.inputValue,
  });

  String? inputName;
  String? inputType;
  String? inputValue;
  String? placeHolder;

  MethodField copyWith(String value) {
    inputValue = value;
    return this;
  }

  factory MethodField.fromRawJson(String str) => MethodField.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MethodField.fromJson(Map<String, dynamic> json) => MethodField(
    inputName: json["input_name"],
    inputType: json["input_type"],
    inputValue: json["input_value"],
    placeHolder: json["placeholder"],
  );

  Map<String, dynamic> toJson() => {
    "input_name": inputName,
    "input_type": inputType,
    "input_value": inputValue,
    "placeholder": placeHolder,
  };
}
