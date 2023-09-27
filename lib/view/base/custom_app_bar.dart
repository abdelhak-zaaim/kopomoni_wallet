import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/rounded_button.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onTap;
  final bool isSkip;
  final Function? function;
  const CustomAppbar({Key? key, required this.title, this.onTap,this.isSkip = false, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomInkWell(
                  onTap: onTap == null ? () {
                    Get.back();
                  } : onTap as void Function()?,
                  radius: Dimensions.radiusSizeSmall,
                  child: Container(
                    height: 40,width: 40,
                    // padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    decoration: BoxDecoration(
                     // border: Border.all(color: Colors.white.withOpacity(0.7), width: 0.5),
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back_ios_new, size: Dimensions.fontSizeExtraOverLarge, color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Text(title, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white),
                ),

                isSkip ? const Spacer() : const SizedBox(),

                isSkip ? SizedBox(child: RoundedButton(buttonText: 'skip'.tr, onTap: function, isSkip: true,)) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
