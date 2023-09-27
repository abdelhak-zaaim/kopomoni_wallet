
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/screens/history/widget/transaction_view_screen.dart';

class CustomExpandableContent extends StatefulWidget {
  const CustomExpandableContent({ Key? key}) : super(key: key);

  @override
  State<CustomExpandableContent> createState() =>
      _CustomExpandableContentState();
}

class _CustomExpandableContentState extends State<CustomExpandableContent> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      height: MediaQuery.of(context).size.height  * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge),
              child: Text(
                'all_transaction'.tr,
                style: rubikMedium.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          Expanded(
            flex: 10,
            child: Container(
              color: ColorResources.getBackgroundColor(),
              child: SingleChildScrollView(
                  child: TransactionViewScreen(
                      scrollController: scrollController, isHome: true)),
            ),
          ),
        ],
      ),
    );
  }
}
