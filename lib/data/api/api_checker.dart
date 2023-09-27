import 'dart:io';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/data/model/body/error_body.dart';
import 'package:six_cash/data/model/response/user_data.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    UserData? userData =  Get.find<AuthController>().getUserData();

    if(response.statusCode == 401) {
      if(Get.currentRoute != RouteHelper.loginScreen) {
        Get.find<AuthController>().removeCustomerToken();
        Get.offAllNamed(RouteHelper.getLoginRoute(
          countryCode: userData?.countryCode,
          phoneNumber: userData?.phone,
        ));

        showCustomSnackBar(response.body['message'] ?? 'unauthorized'.tr, isIcon: true);

      }

    }
    else if(response.statusCode == 429) {
      showCustomSnackBar('to_money_login_attempts'.tr);

    } else if(response.statusCode == -1){
      Get.find<AuthController>().removeCustomerToken();
      Get.offAllNamed(RouteHelper.getLoginRoute(
        countryCode: userData?.countryCode,
        phoneNumber: userData?.phone,
      ));
      showCustomSnackBar('you are using vpn', isVpn: true, duration: const Duration(minutes: 10));

    }
    else {
      showCustomSnackBar(response.body != null
          ? response.body['message'] ?? ErrorBody.fromJson(response.body).errors!.first.message ?? ''
          : response.statusText, isError: true);
    }
  }

  static Future<bool> isVpnActive() async {
    bool isVpnActive;
    List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false, type: InternetAddressType.any);
    interfaces.isNotEmpty
        ? isVpnActive = interfaces.any((interface) =>
    interface.name.contains("tun") ||
        interface.name.contains("ppp") ||
        interface.name.contains("pptp"))
        : isVpnActive = false;

    return isVpnActive;
  }
}
