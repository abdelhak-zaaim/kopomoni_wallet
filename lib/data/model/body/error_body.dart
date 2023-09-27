// To parse this JSON data, do
//
//     final errorBody = errorBodyFromJson(jsonString);

import 'dart:convert';

ErrorBody errorBodyFromJson(String str) => ErrorBody.fromJson(json.decode(str));

String errorBodyToJson(ErrorBody data) => json.encode(data.toJson());

class ErrorBody {
  ErrorBody({
    this.errors,
  });

  List<Error>? errors;

  factory ErrorBody.fromJson(Map<String, dynamic> json) => ErrorBody(
    errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors!.map((x) => x.toJson())),
  };
}

class Error {
  Error({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
