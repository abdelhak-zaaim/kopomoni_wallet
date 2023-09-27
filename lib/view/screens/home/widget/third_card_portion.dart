
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/screens/home/widget/banner_view.dart';
import 'package:six_cash/view/screens/home/widget/custom_card3.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_screen.dart';

class ThirdCardPortion extends StatelessWidget {
  const ThirdCardPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (splashController) {
          return Stack(children: [
            Container(height: 180.0, color: Theme.of(context).primaryColor,),

            Positioned(child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(
                    top: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeDefault,
                  ),
                  child: Row(children: [
                    splashController.configModel!.systemFeature!.sendMoneyStatus! ?
                      Expanded(child: CustomCard3(
                        image: Images.sendMoneyLogo3,
                        text: 'send_money'.tr,
                        height: 38, width: 38,
                        onTap: ()=> Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'send_money')),
                      )) : const SizedBox(height: 38),

                    if(splashController.configModel!.systemFeature!.cashOutStatus!)
                      Expanded(child: CustomCard3(
                        image: Images.cashOutLogo3,
                        text: 'cash_out'.tr, height: 37, width: 37,
                        onTap: ()=> Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'cash_out')),
                      )),

                    if(splashController.configModel!.systemFeature!.addMoneyStatus!) Expanded(
                      child: CustomCard3(
                        image: Images.addMoneyLogo3,
                        text: 'add_money'.tr, height: 35, width: 30,
                        onTap: () => Get.to(const TransactionMoneyBalanceInput(transactionType: 'add_money')),
                      ),
                    ),

                    if(splashController.configModel!.systemFeature!.sendMoneyRequestStatus!) Expanded(child: CustomCard3(
                      image: Images.receivedMoneyLogo,
                      text: 'request_money'.tr, height: 32, width: 48,
                      onTap: ()=> Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'request_money')),
                    )),


                  ])),





              /// Banner..
              const BannerView(),
            ],
            )),
          ]);
        }
    );

  }

}
