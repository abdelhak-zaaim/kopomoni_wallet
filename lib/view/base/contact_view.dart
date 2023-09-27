import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/contact_shimmer.dart';
import 'package:six_cash/view/screens/transaction_money/widget/contact_tile.dart';

import 'custom_ink_well.dart';

class ContactView extends StatelessWidget{
  final String? transactionType;
  const ContactView({ Key? key, this.transactionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionMoneyController>(builder: (contactController) {
      if(contactController.getContactPermissionStatus) {
        return SliverToBoxAdapter(
          child: Column( children: [
            InkWell(
              onTap: () async => await contactController.fetchContact(),
              child: Lottie.asset(
                  Images.contactPermissionDeniAnimation,
                  width: 120.0,
                  fit: BoxFit.contain,
                  alignment: Alignment.center),
            ),
            SizedBox(height: 50, child: Text('please_allow_permission'.tr))
          ]),
        );
      }

      if(contactController.permissionStatus == PermissionStatus.permanentlyDenied) {
        return SliverToBoxAdapter(child: Column(children: [
          Lottie.asset(
            Images.contactPermissionDeniAnimation,
            width: 120.0,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),

          TextButton(
            onPressed: () => openAppSettings(),
            child: Text('you_have_to_grand_permission_to_see_contact'.tr),
          ),

        ]));
      }
      if(contactController.contactIsLoading) {
        return const SliverToBoxAdapter(child: ContactShimmer());
      }
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) => contactController.filterdContacts[index].contact != null ? const SizedBox() : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(index == 0) Container(
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('phone_book'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                ],
              ),
            ),

            Padding( padding: contactController.filterdContacts[index].isShowSuspension ?
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall) :
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Offstage(offstage: !contactController.filterdContacts[index].isShowSuspension,
                child: Text(
                  contactController.filterdContacts[index].getSuspensionTag(),
                  style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getGreyBaseGray1()),
                ),
              ),
            ),

            CustomInkWell(
              highlightColor: Theme.of(context).textTheme.titleLarge!.color!.withOpacity(0.3),
              onTap:() => contactController.isButtonClick
                  ? null : contactController.contactOnTap(index, transactionType),
              child: ContactTile(transactionMoneyController: contactController, index: index),
            ),

            Padding(
              padding: const EdgeInsets.only(left:  65.0,right: 35.0),
              child: Divider(color: Theme.of(context).dividerColor, height: Dimensions.dividerSizeExtraSmall),
            ),
          ],
        ),
          childCount: contactController.filterdContacts.length,
        ),
      );
    });
  }
}