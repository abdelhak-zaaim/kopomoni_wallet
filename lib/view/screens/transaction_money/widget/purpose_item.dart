import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

class PurposeItem extends StatelessWidget {
  const PurposeItem({Key? key, required this.image, required this.title, required this.color,required this.onTap}) : super(key: key);
  final String? image;
  final String? title;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0,bottom: 20,top: 10),height: 120,width: 95,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 20.0,color: ColorResources.blackColor.withOpacity(0.05),spreadRadius: 0.0,offset: const Offset(0.0, 4.0)),]
        ),
      child: CustomInkWell(
        onTap: onTap as void Function()?,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusSizeVerySmall),topRight: Radius.circular(Dimensions.radiusSizeVerySmall),),),
                  child: Center(
                    child: Padding(//height: 36,width: 36,
                      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        child: CustomImage(
                            placeholder: Images.placeholder,
                            image: '${Get.find<SplashController>().configModel!.baseUrls!.purposeImageUrl}/$image', fit: BoxFit.cover))
                  // ),
                ),
              ),

            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(title!,textAlign: TextAlign.center,style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: ColorResources.getGreyColor()),),
              ),
            )

          ],
        ),
      ),

    );
  }
}