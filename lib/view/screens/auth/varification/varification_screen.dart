import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_pin_code_field.dart';
import 'package:six_cash/view/base/demo_otp_hint.dart';
import 'package:six_cash/view/screens/auth/varification/widget/information_view.dart';
import 'package:six_cash/view/screens/auth/varification/widget/timer_section.dart';

class VerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  const VerificationScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  @override
  void initState() {
    Get.find<VerificationController>().startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isForgetPassword = widget.phoneNumber != null;
    return Scaffold(
      backgroundColor: ColorResources.getWhiteAndBlack(),
      appBar: CustomAppbar(title: 'phone_verification'.tr, onTap:() {
        Get.find<VerificationController>().cancelTimer();
        Get.back();
      }),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                InformationView(phoneNumber: widget.phoneNumber),
                const SizedBox(height: Dimensions.paddingSizeOverLarge),

                GetBuilder<VerificationController>(builder: (verificationController){
                  return CustomPinCodeField(
                    padding: Dimensions.paddingSizeOverLarge,
                    onCompleted: (pin){
                      verificationController.setOtp(pin);

                      String? phoneNumber = isForgetPassword ? widget.phoneNumber : Get.find<CreateAccountController>().phoneNumber!;

                      if(isForgetPassword){
                        Get.find<AuthController>().verificationForForgetPass(phoneNumber, pin);
                      }else{
                        Get.find<AuthController>().phoneVerify(phoneNumber!, pin);
                      }
                    },
                  );
                }),

                const DemoOtpHint(),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                TimerSection(
                  isForgetPassword: isForgetPassword,
                  phoneNumber: widget.phoneNumber
                      ?? Get.find<CreateAccountController>().phoneNumber!,
                ),
              ],
            ),
          )),

          GetBuilder<AuthController>(builder: (controller)=>SizedBox(
            height: 100,
            child: controller.isLoading ?
            Center(
              child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
            ): const SizedBox(),
          ))

        ],
      ),

    );
  }
}
