import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:six_cash/controller/banner_controller.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/controller/edit_profile_controller.dart';
import 'package:six_cash/controller/faq_controller.dart';
import 'package:six_cash/controller/forget_password_controller.dart';
import 'package:six_cash/controller/bootom_slider_controller.dart';
import 'package:six_cash/controller/add_money_controller.dart';
import 'package:six_cash/controller/kyc_verify_controller.dart';
import 'package:six_cash/controller/menu_controller.dart';
import 'package:six_cash/controller/notification_controller.dart';
import 'package:six_cash/controller/qr_code_scanner_controller.dart';
import 'package:six_cash/controller/screen_shot_widget_controller.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/controller/camera_screen_controller.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/language_controller.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/theme_controller.dart';
import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/controller/websitelink_controller.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/repository/add_money_repo.dart';
import 'package:six_cash/data/repository/auth_repo.dart';
import 'package:six_cash/data/repository/banner_repo.dart';
import 'package:six_cash/data/repository/faq_repo.dart';
import 'package:six_cash/data/repository/language_repo.dart';
import 'package:six_cash/data/repository/notification_repo.dart';
import 'package:six_cash/data/repository/profile_repo.dart';
import 'package:six_cash/data/repository/requested_money_repo.dart';
import 'package:six_cash/data/repository/transaction_repo.dart';
import 'package:six_cash/data/repository/transaction_history_repo.dart';
import 'package:six_cash/data/repository/websitelink_repo.dart';
import 'package:six_cash/data/repository/splash_repo.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/data/model/response/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../data/repository/kyc_verify_repo.dart';


Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  final BaseDeviceInfo deviceInfo =  await DeviceInfoPlugin().deviceInfo;
  String? uniqueId = await  UniqueIdentifier.serial ?? '';

  Get.lazyPut(() => uniqueId);
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => deviceInfo);


  Get.lazyPut(() => ApiClient(
    appBaseUrl: AppConstants.baseUrl,
    sharedPreferences: Get.find(),
    uniqueId: Get.find(),
    deiceInfo: Get.find(),
  ));

  // Repository
   Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => TransactionRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => WebsiteLinkRepo(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
  Get.lazyPut(() => AddMoneyRepo(apiClient: Get.find()));
  Get.lazyPut(() => FaqRepo(apiClient: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find()));
  Get.lazyPut(() => RequestedMoneyRepo(apiClient: Get.find()));
  Get.lazyPut(() => TransactionHistoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => KycVerifyRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => TransactionMoneyController(transactionRepo: Get.find(), authRepo: Get.find()));
  Get.lazyPut(() => AddMoneyController(addMoneyRepo:Get.find() ));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => FaqController(faqrepo: Get.find()));
  Get.lazyPut(() => BottomSliderController());

  Get.lazyPut(() => MenuItemController());
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => CreateAccountController());
  Get.lazyPut(() => VerificationController(authRepo: Get.find()));
  Get.lazyPut(() => CameraScreenController());
  Get.lazyPut(() => ForgetPassController());
  Get.lazyPut(() => WebsiteLinkController(websiteLinkRepo: Get.find()));
  Get.lazyPut(() => QrCodeScannerController());
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
  Get.lazyPut(() => TransactionHistoryController(transactionHistoryRepo: Get.find()));
  Get.lazyPut(() => EditProfileController(authRepo: Get.find()));
  Get.lazyPut(() => RequestedMoneyController(requestedMoneyRepo: Get.find()));
  Get.lazyPut(() => ScreenShootWidgetController());
  Get.lazyPut(() => KycVerifyController(kycVerifyRepo: Get.find()));



  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = json;
  }
  return languages;
}
