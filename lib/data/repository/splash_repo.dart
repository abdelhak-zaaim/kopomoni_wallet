import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> getConfigData() async {
   // Response _response = await apiClient.postData(AppConstants.CONFIG_URI, {'email': 'ashek@gmail.com', 'password': '0123456'});
    Response response = await apiClient.getData(AppConstants.configUri);
    return response;
  }

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(AppConstants.theme)) {
      return sharedPreferences.setBool(AppConstants.theme, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.customerCountryCode)) {
      return sharedPreferences.setString(AppConstants.customerCountryCode, AppConstants.languages[0].countryCode!);
    }
    if(!sharedPreferences.containsKey(AppConstants.languageCode)) {
      return sharedPreferences.setString(AppConstants.languageCode, AppConstants.languages[0].languageCode!);
    }
    if(!sharedPreferences.containsKey(AppConstants.sendMoneySuggestList)) {
      return sharedPreferences.setString(AppConstants.sendMoneySuggestList, '');
    }
    if(!sharedPreferences.containsKey(AppConstants.requestMoneySuggestList)) {
      return sharedPreferences.setString(AppConstants.requestMoneySuggestList, '');
    }
    if(!sharedPreferences.containsKey(AppConstants.recentAgentList)) {
      return sharedPreferences.setString(AppConstants.recentAgentList, '');
    }
    if(!sharedPreferences.containsKey(AppConstants.biometricAuth)) {
      sharedPreferences.setBool(AppConstants.biometricAuth, true);
    }
    if(!sharedPreferences.containsKey(AppConstants.contactPermission)) {
      sharedPreferences.setString(AppConstants.contactPermission, '');
    }


    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }
}
