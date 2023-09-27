import 'package:country_code_picker/country_code_picker.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController implements GetxService{
  String? _countryCode /*= Get.find<LoginController>().countryCode*/;
  String? get countryCode => _countryCode;
  String? _initNumber ;
  String? get initNumber => _initNumber;

  setInitialCode(String? code){
    _countryCode = code;
    update();
  }


  setCountryCode(CountryCode code){
    _countryCode = code.toString();
    update();
  }




  resetPassword(TextEditingController newPassController, TextEditingController confirmPassController, String? phoneNumber, String? otp){
    if(newPassController.text.isEmpty || confirmPassController.text.isEmpty){
      showCustomSnackBar('please_enter_your_valid_pin'.tr, isError: true);
    }
    else if(newPassController.text.length < 4){
      showCustomSnackBar('pin_should_be_4_digit'.tr, isError: true);
    }
    else if(newPassController.text == confirmPassController.text){
      // write code
      String? number = phoneNumber;
      Get.find<AuthController>().resetPassword(number, otp, newPassController.text, confirmPassController.text);
    }
    else{
      showCustomSnackBar('pin_not_matched'.tr, isError: true);
    }
  }


  sendForOtpResponse({required String phoneNumber}) async {
    if (phoneNumber.isEmpty) {
      showCustomSnackBar('please_give_your_phone_number'.tr,
          isError: true);
    } else{
      Get.find<AuthController>().otpForForgetPass(phoneNumber);

    }
  }

}