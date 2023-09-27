import 'dart:convert';

class ResponseModel {
  ResponseModel({
    required this.responseCode,
    required this.message,
    required this.content,
    required this.errorResponse,
  });

  String? responseCode;
  String? message;
  String? content;
  ErrorResponse errorResponse;

  factory ResponseModel.fromRawJson(String str) => ResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    responseCode: json["response_code"],
    message: json["message"],
    content: json["content"],
    errorResponse: ErrorResponse.fromJson('errors'),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "message": message,
    "content": content,
  };
}


class ErrorResponse {
  List<Errors>? _errors;

  List<Errors>? get errors => _errors;

  ErrorResponse({
      List<Errors>? errors}){
    _errors = errors;
}

  ErrorResponse.fromJson(dynamic json) {
    if (json["errors"] != null) {
      _errors = [];
      json["errors"].forEach((v) {
        _errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_errors != null) {
      map["errors"] = _errors!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// code : "l_name"
/// message : "The last name field is required."

class Errors {
  String? _code;
  String? _message;

  String? get code => _code;
  String? get message => _message;

  Errors({
      String? code, 
      String? message}){
    _code = code;
    _message = message;
}

  Errors.fromJson(dynamic json) {
    _code = json["code"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["message"] = _message;
    return map;
  }

}