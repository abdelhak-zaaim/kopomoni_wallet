
import 'package:country_code_picker/country_code_picker.dart';
import 'package:phone_number/phone_number.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/forget_password_controller.dart';
import 'package:six_cash/helper/phone_cheker.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_country_code_picker.dart';
import 'package:six_cash/view/base/custom_logo.dart';
import 'package:six_cash/view/base/custom_large_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
class ForgetPassword extends StatefulWidget {
  final String? phoneNumber, countryCode;
  const ForgetPassword({Key? key, this.phoneNumber, this.countryCode}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController phoneNumberController = TextEditingController();
  String? countryDialCode;


  @override
  void initState() {
     super.initState();
     countryDialCode =  widget.countryCode;
     phoneNumberController.text = widget.phoneNumber!;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'forget_pin'.tr),
      body: Column(
        children: [
          Expanded(
            // flex: 10,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraExtraLarge,
                  ),
                  const CustomLogo(
                    height: 70.0,
                    width: 70.0,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraLarge),
                    child: Text(
                      'forget_pass_long_text'.tr,
                      style: rubikRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  Container(
                    height: 52,
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Center(
                      child: TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusSizeSmall),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusSizeSmall),
                            borderSide: BorderSide(
                              color: ColorResources.textFieldBorderColor,
                              width: 1,
                            ),
                          ),
                          prefixIcon: CustomCountryCodePiker(
                            initSelect: countryDialCode,
                            onChanged: (CountryCode countryCode) {
                              countryDialCode = countryCode.dialCode;
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          GetBuilder<AuthController>(builder: (controller){
            return SizedBox(
              height: 110,
              child: !controller.isLoading ? CustomLargeButton(
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                text: 'Send_for_otp'.tr,
                onTap: () async{
                  PhoneNumber? number = await PhoneChecker.isNumberValid('$countryDialCode${phoneNumberController.text}');
                  if(number != null ){
                    Get.find<ForgetPassController>().sendForOtpResponse(phoneNumber: number.e164);
                  }
                  else{
                    showCustomSnackBar('please_input_your_valid_number'.tr,isError: true);
                  }
                },
              ) : Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor),),
            );
          }),
        ],
      ),
    );

  }

}
