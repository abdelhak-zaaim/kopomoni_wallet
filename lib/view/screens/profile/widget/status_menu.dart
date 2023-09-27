import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

import 'confirm_pin_bottom_sheet.dart';

class StatusMenu extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final bool isAuth;
  const StatusMenu({Key? key,
   this.title, this.leading, this.isAuth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final authController = Get.find<AuthController>();

    return CustomInkWell(
      onTap: () => Get.defaultDialog(barrierDismissible: false, title: '4digit_pin'.tr, content: ConfirmPinBottomSheet(
        callBack: isAuth ? authController.setBiometric : profileController.twoFactorOnTap, isAuth: isAuth,
      ),),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeDefault),
        child: Row(children: [
          leading!,
          const SizedBox(width: Dimensions.paddingSizeDefault),
          Text(title!,style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
          const Spacer(),
          GetBuilder<AuthController>(builder: (authController) {
              return GetBuilder<ProfileController>(builder: (profController) {

                bool? isOn = isAuth ? (authController.biometric && authController.bioList.isNotEmpty) : profController.userInfo!.twoFactor;
               return profController.isLoading ? Center(child: Text('off'.tr))
                   : Text(isOn! ? 'on'.tr : 'off'.tr);

            });
          })],
        ),
      ),

    );
  }
}


class TwoFactorShimmer extends StatelessWidget {
  const TwoFactorShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Shimmer.fromColors(baseColor: ColorResources.shimmerBaseColor!, highlightColor:  ColorResources.shimmerLightColor!,
        child : Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeDefault),
          child: Row(children: [
            Image.asset(Images.twoFactorAuthentication,width: 28.0),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Text('two_factor_authentication'.tr,style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
            const Spacer(),
            GetBuilder<ProfileController>(builder: (profController)=> profController.isLoading ? Center(child: Text('off'.tr)) : Text(profController.userInfo!.twoFactor! ? 'on'.tr : 'off'.tr)),
            //Image.asset(Images.arrow_right_logo,width: 32.0,)

          ],),
        ),
      ),
    );
  }
}
