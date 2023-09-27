import 'package:get/get.dart';
import 'package:six_cash/data/model/response/language_model.dart';
import 'package:six_cash/data/model/response/on_boarding_model.dart';

import 'images.dart';

class AppConstants {
  static const String appName = 'Kopomoni';
  static const String baseUrl = 'https://zaaimpro.site';

  static const bool demo = false;
   static const double appVersion = 4.0;

  static const String customerPhoneCheckUri = '/api/v1/customer/auth/check-phone';
  static const String customerPhoneVerifyUri = '/api/v1/customer/auth/verify-phone';
  static const String customerRegistrationUri = '/api/v1/customer/auth/register';
  static const String customerUpdateProfile = '/api/v1/customer/update-profile';
  static const String customerLoginUri = '/api/v1/customer/auth/login';
  static const String customerLogoutUri = '/api/v1/customer/logout';
  static const String customerForgetPassOtpUri = '/api/v1/customer/auth/forgot-password';
  static const String customerForgetPassVerification = '/api/v1/customer/auth/verify-token';
  static const String customerForgetPassReset = '/api/v1/customer/auth/reset-password';
  static const String customerLinkedWebsite= '/api/v1/customer/linked-website';
  static const String customerBanner= '/api/v1/customer/get-banner';
  static const String customerTransactionHistory= '/api/v1/customer/transaction-history';
  static const String customerPurposeUrl = '/api/v1/customer/get-purpose';
  static const String configUri = '/api/v1/config';
  static const String imageConfigUrlApiNeed = '/storage/app/public/purpose/';
  static const String customerProfileInfo = '/api/v1/customer/get-customer';
  static const String customerCheckOtp = '/api/v1/customer/check-otp';
  static const String customerVerifyOtp = '/api/v1/customer/verify-otp';
  static const String customerChangePin = '/api/v1/customer/change-pin';
  static const String customerUpdateTwoFactor = '/api/v1/customer/update-two-factor';
  static const String customerSendMoney = '/api/v1/customer/send-money';
  static const String customerRequestMoney = '/api/v1/customer/request-money';
  static const String customerCashOut = '/api/v1/customer/cash-out';
  static const String customerPinVerify = '/api/v1/customer/verify-pin';
  static const String customerAddMoney = '/api/v1/customer/add-money';
  static const String faqUri = '/api/v1/faq';
  static const String notificationUri = '/api/v1/customer/get-notification';
  static const String transactionHistoryUri = '/api/v1/customer/transaction-history';
  static const String requestedMoneyUri = '/api/v1/customer/get-requested-money';
  static const String acceptedRequestedMoneyUri = '/api/v1/customer/request-money/approve';
  static const String deniedRequestedMoneyUri = '/api/v1/customer/request-money/deny';
  static const String tokenUri = '/api/v1/customer/update-fcm-token';
  static const String checkCustomerUri = '/api/v1/check-customer';
  static const String checkAgentUri = '/api/v1/check-agent';
  static const String wonRequestedMoney = '/api/v1/customer/get-own-requested-money';
  static const String customerRemove = '/api/v1/customer/remove-account';
  static const String updateKycInformation = '/api/v1/customer/update-kyc-information';
  static const String withdrawMethodList = '/api/v1/customer/withdrawal-methods';
  static const String withdrawRequest = '/api/v1/customer/withdraw';
  static const String getWithdrawalRequest = '/api/v1/customer/withdrawal-requests';


  // Shared Key
  static const String theme = 'theme';
  static const String text2speach = 'text2speach';


  static const String token = 'token';
  static const String customerCountryCode = 'customer_country_code';//not in project
  static const String languageCode = 'language_code';
  static const String topic = 'notify';
  static const String sendMoneySuggestList = 'send_money_suggest';
  static const String requestMoneySuggestList = 'request_money_suggest';
  static const String recentAgentList = 'recent_agent_list';

  static const String pending = 'pending';
  static const String approved = 'approved';
  static const String denied = 'denied';
  static const String cashIn = 'cash_in';
  static const String cashOut = 'cash_out';
  static const String sendMoney = 'send_money';
  static const String receivedMoney = 'received_money';
  static const String adminCharge = 'admin_charge';
  static const String addMoney = 'add_money';
  static const String withdraw = 'withdraw';
  static const String payment = 'payment';

  static const String biometricAuth = 'biometric_auth';
  static const String biometricPin = 'biometric';
  static const String contactPermission = '';
  static const String userData = 'user';



  //topic
  static const String all = 'all';
  static const String users = 'customers';

  // App Theme
  static const String theme1 = 'theme_1';
  static const String theme2 = 'theme_2';
  static const String theme3 = 'theme_3';

  //input balance digit length
  static const int balanceInputLen = 10;

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.english, languageName: 'krio', countryCode: 'KRI', languageCode: 'kr'),


  ];

  static  List<OnboardModel> onboardList = [
    OnboardModel(
      Images.onboardImage1,
      Images.onboardBackground1,
      'on_boarding_title_1'.tr,
      '${'send_money_from'.tr} $appName ${'easily_at_anytime'.tr}',
    ),

    OnboardModel(
      Images.onboardImage2, Images.onboardBackground2,
      'on_boarding_title_2'.tr,
      'withdraw_money_is_even_more'.tr,
    ),
    OnboardModel(
      Images.onboardImage3,
      Images.onboardBackground3,
      'on_boarding_title_3'.tr,
      '${'request_for_money_using'.tr} $appName ${'account_to_any_friend'.tr}',
    ),
  ];
}
