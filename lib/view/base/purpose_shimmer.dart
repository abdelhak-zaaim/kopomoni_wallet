import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';

class PurposeShimmer extends StatelessWidget {
  const PurposeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizationController = Get.find<LocalizationController>();
    return Shimmer.fromColors(
        baseColor: Colors.grey, highlightColor: Colors.grey[200]!,
        child: Container(height: 150,
            padding: localizationController.isLtr ? const EdgeInsets.only(
                left: Dimensions.paddingSizeDefault) : const EdgeInsets.only(
                right: Dimensions.paddingSizeDefault),
            child: ListView.builder(physics: const BouncingScrollPhysics(),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0,bottom: 20,top: 10),height: 120,width: 95,

                    child: Column(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusSizeVerySmall),topRight: Radius.circular(Dimensions.radiusSizeVerySmall),),),
                            child: Center(
                                child: Padding(//height: 36,width: 36,
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                                    child: ClipOval(child: Image.asset(Images.placeholder))),
                              // ),
                            ),
                          ),

                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text('title'.tr,textAlign: TextAlign.center,style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                          ),
                        )

                      ],
                    ),

                  );
                }

            )
        ));
  }
}
