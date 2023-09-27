import 'dart:convert';

class WithdrawHistoryModel {
  WithdrawHistoryModel({
    required this.responseCode,
    required this.message,
    required this.withdrawHistoryList,
    required this.errors,
  });

  String? responseCode;
  String? message;
  List<WithdrawHistory> withdrawHistoryList;
  dynamic errors;

  factory WithdrawHistoryModel.fromRawJson(String str) => WithdrawHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) => WithdrawHistoryModel(
    responseCode: json["response_code"],
    message: json["message"],
    withdrawHistoryList: List<WithdrawHistory>.from(json["content"].map((x) => WithdrawHistory.fromJson(x))),
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "message": message,
    "content": List<dynamic>.from(withdrawHistoryList.map((x) => x.toJson())),
    "errors": errors,
  };
}

class WithdrawHistory {
  WithdrawHistory({
    required this.id,
    required this.userId,
    required this.amount,
    required this.adminCharge,
    required this.requestStatus,
    required this.withdrawalMethodId,
    required this.withdrawalMethodFields,
    required this.createdAt,
    required this.updatedAt,
    required this.methodName,
  });

  String id;
  String userId;
  double? amount;
  double? adminCharge;
  String requestStatus;
  String withdrawalMethodId;
  Map<String, dynamic>? withdrawalMethodFields;
  DateTime createdAt;
  DateTime updatedAt;
  String? methodName;

  factory WithdrawHistory.fromRawJson(String str) => WithdrawHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WithdrawHistory.fromJson(Map<String, dynamic> json) => WithdrawHistory(
    id: '${json["id"]}',
    userId: '${json["user_id"]}',
    amount: double.tryParse('${json["amount"]}'),
    requestStatus: '${json["request_status"]}',
    adminCharge: double.tryParse('${json["admin_charge"]}'),
    withdrawalMethodId: '${json["withdrawal_method_id"]}',
    withdrawalMethodFields: json["withdrawal_method_fields"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    methodName: json["withdrawal_method"] != null ? json["withdrawal_method"]['method_name']:'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "admin_charge": adminCharge,
    "request_status": requestStatus,
    "withdrawal_method_id": withdrawalMethodId,
    "withdrawal_method_fields": withdrawalMethodFields,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "method_name": methodName,
  };
}

class WithdrawalMethodFields {
  WithdrawalMethodFields({
    required this.phoneNumber,
  });

  String? phoneNumber;

  factory WithdrawalMethodFields.fromRawJson(String str) => WithdrawalMethodFields.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WithdrawalMethodFields.fromJson(Map<String, dynamic> json) => WithdrawalMethodFields(
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
  };
}
