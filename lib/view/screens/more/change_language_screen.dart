
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_logo.dart';
import 'package:six_cash/view/base/custom_small_button.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/more/widget/language_widget.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  
  @override
  void initState() {
    Get.find<LocalizationController>().loadCurrentLanguage().then((index) =>
        Get.find<LocalizationController>().setSelectIndex(index, isUpdate: false)
    );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'language'.tr),
      body: GetBuilder<LocalizationController>(
          builder: (localizationController) {
        return Column(children: [
          Expanded(
              child: Center(child: Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Center(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: CustomLogo(
                            height: 150,
                            width: 150,
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeOverLarge,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  Dimensions.paddingSizeExtraSmall),
                          child:
                              Text('select_language'.tr, style: rubikMedium.copyWith(color: Theme.of(context).textTheme.titleLarge!.color,fontSize: Dimensions.fontSizeExtraLarge)),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (1 / 1),
                          ),
                          itemCount: localizationController.languages.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => LanguageWidget(
                            languageModel: localizationController.languages[index],
                            localizationController: localizationController,
                            index: index,
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),

                        Text('* ${'you_can_change_language'.tr}',
                            style: rubikRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor,
                            )),
                      ]),
                )),
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeExtraExtraLarge),
            child: Row(
              children: [
                Expanded(
                  child: CustomSmallButton(
                    onTap: () {
                      if (localizationController.languages.isNotEmpty &&
                          localizationController.selectedIndex != -1) {
                        localizationController.setLanguage(Locale(
                          AppConstants.languages[localizationController.selectedIndex]
                              .languageCode!,
                          AppConstants.languages[localizationController.selectedIndex]
                              .countryCode,
                        ));
                        Get.back();
                      } else {
                        showCustomSnackBar('select_a_language'.tr,isError: false);
                      }
                    },
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    text: 'save'.tr,
                    textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ],
            ),
          ),
        ]);
      }),
    );
  }
}
