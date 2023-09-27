import 'dart:convert';

TransactionBody transactionBodyFromJson(String str) => TransactionBody.fromJson(json.decode(str));

class TransactionBody {
  TransactionBody({
    this.message,
  });

  String? message;

  factory TransactionBody.fromJson(Map<String, dynamic> json) => TransactionBody(
    message: json["message"].toString().toUpperCase(),
  );
}
