import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/home/widget/banner_view.dart';
import 'package:six_cash/view/screens/home/widget/custom_card.dart';
import 'package:six_cash/view/screens/requested_money/requested_money_list_screen.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_screen.dart';

class FirstCardPortion extends StatelessWidget {
  const FirstCardPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Stack(children: [
        Container(
          height: 190.0,
          // color: Theme.of(context).primaryColor,
        ),
        Positioned(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 90.0,
              margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge,
                vertical: Dimensions.paddingSizeLarge,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSizeLarge),
                color: const Color(0xFF68B0B9),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeLarge,
                    ),
                    child: GetBuilder<ProfileController>(
                        builder: (profileController) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'your_balance'.tr,
                            style: rubikLight.copyWith(
                              color: ColorResources.getBalanceTextColor(),
                              fontSize: Dimensions.fontSizeExtraLarge,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
                          ),
                          profileController.userInfo != null
                              ? Text(
                            PriceConverter.balanceWithSymbol(
                              balance: profileController.userInfo!.balance.toString(),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0, // Increase font size
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          )
                              : Text(
                                  PriceConverter.convertPrice(0.00),
                                  style: rubikMedium.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color,
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                  ),
                                ),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          profileController.userInfo != null
                              ? Text(
                                  '(${'sent'.tr} ${PriceConverter.balanceWithSymbol(balance: profileController.userInfo!.pendingBalance != null ? profileController.userInfo!.pendingBalance.toString() : 0 as String?)} ${'withdraw_req'.tr})',
                                  style: rubikMedium.copyWith(
                                    fontSize: Dimensions.fontSizeSmall
                                  ))
                              : const SizedBox(),
                        ],
                      );
                    }),
                  ),
                  const Spacer(),
                  if (splashController
                      .configModel!.systemFeature!.addMoneyStatus!)
                    Container(
                      height: 90.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeLarge),
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      child: CustomInkWell(
                        onTap: () => Get.to(const TransactionMoneyBalanceInput(
                            transactionType: 'add_money')),
                        radius: Dimensions.radiusSizeLarge,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeLarge , ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 34,
                                  child: Image.asset(Images.walletLogo)),
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraSmall,
                              ),
                              Text(
                                'add_money'.tr,
                                style: rubikRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            /// Cards...
            SizedBox(
              // height: 130.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.fontSizeExtraSmall),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (splashController
                            .configModel!.systemFeature!.sendMoneyStatus!)
                          Expanded(
                              child: CustomCard(
                            image: Images.sendMoneyLogo,
                            text: 'send_money'.tr.replaceAll(' ', '\n'),
                            color: Theme.of(context).secondaryHeaderColor,
                            onTap: () =>
                                Get.to(() => const TransactionMoneyScreen(
                                      fromEdit: false,
                                      transactionType:
                                          TransactionType.sendMoney,
                                    )),
                          )),
                        if (splashController
                            .configModel!.systemFeature!.cashOutStatus!)
                          Expanded(
                              child: CustomCard(
                            image: Images.cashOutLogo,
                            text: 'cash_out'.tr.replaceAll(' ', '\n'),
                            color: ColorResources.getCashOutCardColor(),
                            onTap: () =>
                                Get.to(() => const TransactionMoneyScreen(
                                      fromEdit: false,
                                      transactionType: TransactionType.cashOut,
                                    )),
                          )),
                        if (splashController.configModel!.systemFeature!
                            .sendMoneyRequestStatus!)
                          Expanded(
                              child: CustomCard(
                            image: Images.requestMoneyLogo,
                            text: 'request_money'.tr,
                            color: ColorResources.getRequestMoneyCardColor(),
                            onTap: () =>
                                Get.to(() => const TransactionMoneyScreen(
                                      fromEdit: false,
                                      transactionType:
                                          TransactionType.requestMoney,
                                    )),
                          )),
/*
                      if(splashController.configModel!.systemFeature!.sendMoneyRequestStatus!)Expanded(child: CustomCard(
                        image: Images.requestListImage2,
                        text: 'requests'.tr,
                        color: ColorResources.getReferFriendCardColor(),
                        onTap: () => Get.to(()=> const RequestedMoneyListScreen(requestType: RequestType.request)),
                      ),
                      ),*/
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Image.asset(
                      Images.logo_splash,
                      fit: BoxFit.contain,
                      height: 200,
                      width: 200,
                    )
                  ],
                ),
              ),
            ),

            const BannerView(),
          ],
        )),
      ]);
    });
  }
}
