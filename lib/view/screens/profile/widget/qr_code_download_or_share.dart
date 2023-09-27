
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:six_cash/controller/screen_shot_widget_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_logo.dart';
class QrCodeDownloadOrShareScreen extends StatelessWidget {
  final String qrCode;
  final String phoneNumber;
  const QrCodeDownloadOrShareScreen({Key? key, required this.qrCode, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Screenshot(
        controller: Get.find<ScreenShootWidgetController>().statementController,
        child: Scaffold(
          backgroundColor: ColorResources.backgroundColor,
          body: Center(
            child: Container(
              height: size.height,
              width: size.width,
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: ColorResources.blackColor.withOpacity(0.25), blurRadius: 6)]
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomLogo(height: 70.0, width: 70.0),
                        const SizedBox(width: Dimensions.paddingSizeDefault),

                        Text(
                          Get.find<SplashController>().configModel!.companyName!,
                          style: rubikMedium.copyWith(color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeOverOverLarge),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraOverLarge),

                    SvgPicture.string(qrCode,height: size.width*0.6,width: size.width*0.6),
                    const SizedBox(height: Dimensions.paddingSizeOverLarge),

                    Text(
                      phoneNumber,
                      style: rubikRegular.copyWith(
                        color: ColorResources.phoneNumberColor,
                        fontSize: Dimensions.fontSizeExtraOverLarge,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Divider(
                      color: ColorResources.phoneNumberColor,
                      height: 1,
                      endIndent: size.width * 0.3,
                      indent: size.width * 0.3,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Divider(
                      color: ColorResources.phoneNumberColor,
                      height: 1,
                      endIndent: size.width * 0.4,
                      indent: size.width * 0.4,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text(
                      'scan_the_QR_code_to_send_money'.tr,
                      style: rubikSemiBold.copyWith(
                        color: ColorResources.phoneNumberColor,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),

                    Container(
                      height: 30,
                      width: double.infinity,
                      decoration: const BoxDecoration(gradient: LinearGradient(
                        colors: ColorResources.ssColor,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
