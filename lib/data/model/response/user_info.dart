
import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

enum KycVerification {
  approve,
  pending,
  denied,
  needApply,
}


class UserInfo {
  UserInfo({
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.image,
    this.type,
    this.gender,
    this.occupation,
    this.twoFactor,
    this.fcmToken,
    this.balance,
    this.uniqueId,
    this.qrCode,
    this.kycStatus,
    this.pendingBalance,
    this.pendingWithdrawCount,
    this.transactionLimits,

  });

  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  int? type;
  String? gender;
  String? occupation;
  bool? twoFactor;
  String? fcmToken;
  double? balance;
  String? uniqueId;
  String? qrCode;
  KycVerification? kycStatus;
  double? pendingBalance;
  int? pendingWithdrawCount;
  TransactionLimit? transactionLimits;


  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    fName: json["f_name"],
    lName: json["l_name"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    type: json["type"],
    gender: json["gender"],
    occupation: json["occupation"],
    twoFactor: json["two_factor"]== 1 ? true : false,
    fcmToken: json["fcm_token"],
    balance: json["balance"].toDouble() ?? 0.0,
    uniqueId: json["unique_id"],
    qrCode: json["qr_code"],
    kycStatus:  _getStatusType('${json['is_kyc_verified']}'),
    pendingBalance: json["pending_balance"] != null ? json["pending_balance"].toDouble() : 0,
    pendingWithdrawCount: json["pending_withdraw_count"] != null
        ? int.parse(json["pending_withdraw_count"].toString()): 0,
    transactionLimits: TransactionLimit.fromJson(json["transaction_limits"]),
  );


}

KycVerification _getStatusType(String value) {
  switch(value) {
    case '0': {
      return KycVerification.pending;
    }
    case '1': {
      return KycVerification.approve;
    }
    case '2': {
      return KycVerification.denied;

    }
    default: {
      return KycVerification.needApply;
    }
  }
}

class Transaction{
  final int dailyCount;

  Transaction(
      this.dailyCount, this.monthlyCount, this.dailyAmount, this.monthlyAmount);

  final int monthlyCount;
  final double dailyAmount;
  final double monthlyAmount;

}


class TransactionLimit {
  double? dailyAddMoneyAmount;
  double? monthlyAddMoneyAmount;
  int? dailyAddMoneyCount;
  int? monthlyAddMoneyCount;
  int? dailySendMoneyCount;
  int? monthlySendMoneyCount;
  double? dailySendMoneyAmount;
  double? monthlySendMoneyAmount;
  int? dailyCashOutCount;
  int? monthlyCashOutCount;
  double? dailyCashOutAmount;
  double? monthlyCashOutAmount;
  int? dailySendMoneyRequestCount;
  int? monthlySendMoneyRequestCount;
  double? dailySendMoneyRequestAmount;
  double? monthlySendMoneyRequestAmount;
  int? dailyWithdrawRequestCount;
  int? monthlyWithdrawRequestCount;
  double? dailyWithdrawRequestAmount;
  double? monthlyWithdrawRequestAmount;

  TransactionLimit(
      {
         this.dailyAddMoneyCount,
         this.monthlyAddMoneyCount,
         this.dailyAddMoneyAmount,
         this.monthlyAddMoneyAmount,
         this.dailySendMoneyCount,
         this.monthlySendMoneyCount,
         this.dailySendMoneyAmount,
         this.monthlySendMoneyAmount,
         this.dailyCashOutCount,
         this.monthlyCashOutCount,
         this.dailyCashOutAmount,
         this.monthlyCashOutAmount,
         this.dailySendMoneyRequestCount,
         this.monthlySendMoneyRequestCount,
         this.dailySendMoneyRequestAmount,
         this.monthlySendMoneyRequestAmount,
         this.dailyWithdrawRequestCount,
         this.monthlyWithdrawRequestCount,
         this.dailyWithdrawRequestAmount,
         this.monthlyWithdrawRequestAmount,
      });

 factory TransactionLimit.fromJson(Map<String, dynamic> json) => TransactionLimit(
   dailyAddMoneyCount: int.parse('${json["daily_add_money_count"]}'),
   monthlyAddMoneyCount: int.parse('${json["monthly_add_money_count"]}'),
   dailyAddMoneyAmount: double.parse('${json["daily_add_money_amount"]}'),
   monthlyAddMoneyAmount: double.parse('${json["monthly_add_money_amount"]}'),

   dailySendMoneyCount: int.parse('${json["daily_send_money_count"]}'),
   monthlySendMoneyCount: int.parse('${json["monthly_send_money_count"]}'),
   dailySendMoneyAmount: double.parse('${json["daily_send_money_amount"]}'),
   monthlySendMoneyAmount: double.parse('${json["monthly_send_money_amount"]}'),

   dailyCashOutCount: int.parse('${json["daily_cash_out_count"]}'),
   monthlyCashOutCount: int.parse('${json["monthly_cash_out_count"]}'),
   dailyCashOutAmount: double.parse('${json["daily_cash_out_amount"]}'),
   monthlyCashOutAmount: double.parse('${json["monthly_cash_out_amount"]}'),

   dailySendMoneyRequestCount: int.parse('${json["daily_send_money_request_count"]}'),
   monthlySendMoneyRequestCount: int.parse('${json["monthly_send_money_request_count"]}'),
   dailySendMoneyRequestAmount: double.parse('${json["daily_send_money_request_amount"]}'),
   monthlySendMoneyRequestAmount: double.parse('${json["monthly_send_money_request_amount"]}'),

   dailyWithdrawRequestCount: int.parse('${json["daily_withdraw_request_count"]}'),
   monthlyWithdrawRequestCount: int.parse('${json["monthly_withdraw_request_count"]}'),
   dailyWithdrawRequestAmount: double.parse('${json["daily_withdraw_request_amount"]}'),
   monthlyWithdrawRequestAmount: double.parse('${json["monthly_withdraw_request_amount"]}'),

 );
}



