import 'package:country_code_picker/country_code_picker.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController implements GetxService{
  String _countryCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel!.country!).dialCode!;
  String? _phoneNumber;
  String get countryCode => _countryCode;
  String? get phoneNumber => _phoneNumber;

  setCountryCode(String dialCode) {
    _countryCode = dialCode;
    update();
  }

  setPhoneNumber(String phone) {
    _phoneNumber = phone;
    update();
  }
  setInitCountryCode(String code) {
    _countryCode = code;
  }
  sendOtpResponse({required String number}){
    String number0 = number;
    if (number0.isEmpty) {
      showCustomSnackBar('please_give_your_phone_number'.tr, isError: true);
    }
    else if(number0.contains(RegExp(r'[A-Z]'))){
      showCustomSnackBar('phone_number_not_contain_characters'.tr, isError: true);
    }
    else if(number0.contains(RegExp(r'[a-z]'))){
      showCustomSnackBar('phone_number_not_contain_characters'.tr, isError: true);
    }
    else if(number0.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      showCustomSnackBar('phone_number_not_contain_spatial_characters'.tr, isError: true);
    } else if(number0.length!=12&&number0.length!=13){
      showCustomSnackBar('please_input_your_valid_number'.tr, isError: true);
    }
    else{
      setPhoneNumber(number);
      Get.find<AuthController>().checkPhone(number);
    }
  }
}