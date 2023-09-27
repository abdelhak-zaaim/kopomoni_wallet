import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_logo.dart';

class InformationView extends StatelessWidget {
  final String? phoneNumber;
  const InformationView({Key? key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomLogo(
          height: 70,
          width: 70,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeLarge),
          child: Text(
            'phone_number_verification'.tr,
            style: rubikMedium.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: Dimensions.fontSizeExtraOverLarge,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeExtraOverLarge),
          child: Text(
            'we_have_send_the_code'.tr,
            style: rubikLight.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: Dimensions.fontSizeLarge,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeExtraExtraLarge,
        ),
        if(phoneNumber != null && phoneNumber != 'null') Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              phoneNumber!,
              style: rubikRegular.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeExtraLarge,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),

            InkWell(
              onTap: (){
                Get.back();
              },
              child: Text(
                '(${'change_number'.tr})',
                style: rubikRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Dimensions.fontSizeDefault,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        if(phoneNumber == null || phoneNumber == 'null')
          GetBuilder<CreateAccountController>(
            builder: (createAccountController)=>  createAccountController.phoneNumber != null ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  createAccountController.phoneNumber!,
                  style: rubikRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: Dimensions.paddingSizeExtraSmall,
                ),
                InkWell(
                  onTap: (){
                    Get.back();
                    Get.find<VerificationController>().cancelTimer();
                    Get.find<VerificationController>().setVisibility(false);
                  },
                  child: Text(
                    '(${'change_number'.tr})',
                    style: rubikRegular.copyWith(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ) : const SizedBox()),
      ],
    );
  }
}
