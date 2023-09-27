import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/screens/transaction_money/widget/preview_contact_tile.dart';

class ForPersonWidget extends StatelessWidget {
  final ContactModel? contactModel;
  const ForPersonWidget({Key? key, this.contactModel, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.getBackgroundColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge),
            child: Text('for_person'.tr, style: rubikSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getGreyBaseGray1())),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: PreviewContactTile(contactModel: contactModel)),
            ],
          ),
              
          Container(height: Dimensions.dividerSizeMedium, color: Theme.of(context).cardColor),


        ],
      ),
    );
  }
}
