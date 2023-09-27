import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class DemoOtpHint extends StatelessWidget {
  const DemoOtpHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppConstants.demo ? Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Text(
        'for_demo_1234'.tr,
        style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).highlightColor),
      ),
    ) : const SizedBox();
  }
}
