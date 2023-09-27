// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

class ConfigModel {
  ConfigModel({
    this.companyName,
    this.companyLogo,
    this.companyAddress,
    this.companyPhone,
    this.companyEmail,
    this.baseUrls,
    this.currencySymbol,
    this.currencyPosition,
    this.cashOutChargePercent,
    this.sendMoneyChargeFlat,
    this.withdrawChargePercent,
    this.twoFactor,
    this.phoneVerification,
    this.country,
    this.languageCode,
    this.termsAndConditions,
    this.privacyPolicy,
    this.aboutUs,
    this.themeIndex,
    this.activePaymentMethodList,
    this.otpResendTime,
    this.customerAddMoneyLimit,
    this.customerCashOutLimit,
    this.customerSendMoneyLimit,
    this.customerWithdrawLimit,
    this.customerRequestMoneyLimit,
    this.systemFeature,
  });

  String? companyName;
  String? companyLogo;
  String? companyAddress;
  String? companyPhone;
  String? companyEmail;
  BaseUrls? baseUrls;
  String? currencySymbol;
  String? currencyPosition;
  double? cashOutChargePercent;
  double? sendMoneyChargeFlat;
  double? withdrawChargePercent;
  bool? twoFactor;
  bool? phoneVerification;
  String? country;
  String? languageCode;
  String? termsAndConditions;
  String? privacyPolicy;
  String? aboutUs;
  int? themeIndex;
  List<String>? activePaymentMethodList;
  int? otpResendTime;
  CustomerLimit? customerSendMoneyLimit;
  CustomerLimit? customerAddMoneyLimit;
  CustomerLimit? customerRequestMoneyLimit;
  CustomerLimit? customerWithdrawLimit;
  CustomerLimit? customerCashOutLimit;
  SystemFeature? systemFeature;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    companyName: json["company_name"],
    companyLogo: json["company_logo"],
    companyAddress: json["company_address"],
    companyPhone: json["company_phone"].toString(),
    companyEmail: json["company_email"],
    baseUrls: BaseUrls.fromJson(json["base_urls"]),
    currencySymbol: json["currency_symbol"],
    currencyPosition: json["currency_position"] ?? 'left',
    cashOutChargePercent: double.tryParse('${json["cashout_charge_percent"]}') ?? 0,
    sendMoneyChargeFlat: double.tryParse('${json["sendmoney_charge_flat"]}') ?? 0,
    withdrawChargePercent: double.tryParse('${json["withdraw_charge_percent"]}') ?? 0,
    twoFactor: int.parse(json["two_factor"].toString()) == 1 ? true: false,
    phoneVerification: json["phone_verification"] == 1 ? true: false,
    country: json["country"] ?? 'BD',
    languageCode: json["language_code"] ?? 'en',
    termsAndConditions: json["terms_and_conditions"],
    privacyPolicy: json["privacy_policy"],
    aboutUs: json["about_us"],
    themeIndex: int.tryParse('${json["user_app_theme"]}'),
    activePaymentMethodList: json['active_payment_method_list'].cast<String>(),
    otpResendTime: int.tryParse('${json['otp_resend_time']}'),
    customerSendMoneyLimit: CustomerLimit.fromJson(json['customer_send_money_limit']),
    customerAddMoneyLimit: CustomerLimit.fromJson(json['customer_add_money_limit']),
    customerRequestMoneyLimit: CustomerLimit.fromJson(json['customer_send_money_request_limit']),
    customerWithdrawLimit: CustomerLimit.fromJson(json['customer_withdraw_request_limit']),
    customerCashOutLimit: CustomerLimit.fromJson(json['customer_cash_out_limit']),
    systemFeature: SystemFeature.fromJson(json['system_feature']),

  );
}

class BaseUrls {
  BaseUrls({
    this.customerImageUrl,
    this.agentImageUrl,
    this.linkedWebsiteImageUrl,
    this.purposeImageUrl,
    this.notificationImageUrl,
    this.companyImageUrl,
    this.bannerImageUrl,
  });

  String? customerImageUrl;
  String? agentImageUrl;
  String? linkedWebsiteImageUrl;
  String? purposeImageUrl;
  String? notificationImageUrl;
  String? companyImageUrl;
  String? bannerImageUrl;

  factory BaseUrls.fromJson(Map<String, dynamic> json) => BaseUrls(
    customerImageUrl: json["customer_image_url"],
    agentImageUrl: json["agent_image_url"],
    linkedWebsiteImageUrl: json["linked_website_image_url"],
    purposeImageUrl: json["purpose_image_url"],
    notificationImageUrl: json["notification_image_url"],
    companyImageUrl: json["company_image_url"],
    bannerImageUrl: json["banner_image_url"],
  );
}



class CustomerLimit {
  bool status;
  int transactionLimitPerDay;
  double maxAmountPerTransaction;
  double totalTransactionAmountPerDay;
  int transactionLimitPerMonth;
  double totalTransactionAmountPerMonth;

  CustomerLimit({
    required this.status,
    required this.transactionLimitPerDay,
    required this.maxAmountPerTransaction,
    required this.totalTransactionAmountPerDay,
    required this.transactionLimitPerMonth,
    required this.totalTransactionAmountPerMonth,
  });

  factory CustomerLimit.fromJson(Map<String, dynamic> json) => CustomerLimit(
    status: '${json["status"]}'.contains('1'),
    transactionLimitPerDay: int.parse('${json["transaction_limit_per_day"]}'),
    maxAmountPerTransaction: double.parse('${json["max_amount_per_transaction"]}'),
    totalTransactionAmountPerDay: double.parse('${json["total_transaction_amount_per_day"]}'),
    transactionLimitPerMonth: int.parse('${json["transaction_limit_per_month"]}'),
    totalTransactionAmountPerMonth: double.parse('${json["total_transaction_amount_per_month"]}'),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "transaction_limit_per_day": transactionLimitPerDay,
    "max_amount_per_transaction": maxAmountPerTransaction,
    "total_transaction_amount_per_day": totalTransactionAmountPerDay,
    "transaction_limit_per_month": transactionLimitPerMonth,
    "total_transaction_amount_per_month": totalTransactionAmountPerMonth,
  };
}


class SystemFeature {
  bool? addMoneyStatus;
  bool? sendMoneyStatus;
  bool? cashOutStatus;
  bool? sendMoneyRequestStatus;
  bool? withdrawRequestStatus;
  bool? linkedWebSiteStatus;
  bool? bannerStatus;

  SystemFeature({
    required this.addMoneyStatus,
    required this.sendMoneyStatus,
    required this.cashOutStatus,
    required this.sendMoneyRequestStatus,
    required this.withdrawRequestStatus,
    required this.linkedWebSiteStatus,
    required this.bannerStatus,
  });

  factory SystemFeature.fromJson(Map<String, dynamic> json) => SystemFeature(
    addMoneyStatus: '${json["add_money_status"]}'.contains('1'),
    sendMoneyStatus: '${json["send_money_status"]}'.contains('1'),
    cashOutStatus: '${json["cash_out_status"]}'.contains('1'),
    sendMoneyRequestStatus: '${json["send_money_request_status"]}'.contains('1'),
    withdrawRequestStatus: '${json["withdraw_request_status"]}'.contains('1'),
    bannerStatus: '${json["banner_status"]}'.contains('1'),
    linkedWebSiteStatus: '${json["linked_website_status"]}'.contains('1'),
  );

}
