import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_logo.dart';

class WelcomeScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;
  final String? password;

  const WelcomeScreen({
    Key? key, this.phoneNumber, this.countryCode, this.password,
  }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Get.find<AuthController>().authenticateWithBiometric(false,  widget.password).then((value) {
      Get.offAllNamed(RouteHelper.getLoginRoute(
        countryCode: widget.countryCode,
        phoneNumber: widget.phoneNumber,
      ));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: size.height * 0.7,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraLarge),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            bottomLeft:
                Radius.circular(Dimensions.radiusSizeExtraExtraLarge),
            bottomRight:
                Radius.circular(Dimensions.radiusSizeExtraExtraLarge),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomLogo(
              height: 90,
              width: 90,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
             Text(
                '${'welcome_to'.tr} ${AppConstants.appName} !',
                textAlign: TextAlign.center,
                style: rubikMedium.copyWith(
                  color: Theme.of(context).textTheme.titleLarge!.color,
                  fontSize: Dimensions.fontSizeOverOverLarge,
                ),
              ),
              const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
              const SizedBox(
              height: Dimensions.paddingSizeOverLarge,
            ),
             Text(
                'start_exploring_the_amazing_ways_to_take_your_lifestyle_upward'.tr,
                textAlign: TextAlign.center,
                style: rubikLight.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
              ),
               const SizedBox(
              height: Dimensions.paddingSizeOverLarge,
            ),
          ],
        ),
      ),
    );
  }
}
