
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/data/model/response/language_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  const LanguageWidget({Key? key, required this.languageModel, required this.localizationController, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: ColorResources.getWhiteAndBlack(),
        borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraSmall),
        boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, blurRadius: 5, spreadRadius: 1)],
      ),
      child: CustomInkWell(
        onTap: (){
          localizationController.setSelectIndex(index);
        },
        radius: Dimensions.radiusSizeExtraSmall,
        child: Stack(children: [

          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 65, width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraSmall),
                  border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!, width: 1),
                ),
                alignment: Alignment.center,
                child: Image.asset(languageModel.imageUrl!, width: 36, height: 36,color: Get.isDarkMode? Colors.white: Theme.of(context).primaryColor,),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Text(languageModel.languageName!, style: rubikMedium.copyWith(color: Theme.of(context).textTheme.titleLarge!.color)),
            ]),
          ),

          localizationController.selectedIndex == index ? Positioned(
            top: 10, right: 10,
            child: Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 25),
          ) : const SizedBox(),

        ]),
      ),
    );
  }
}
