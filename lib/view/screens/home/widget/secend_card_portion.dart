
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/screens/home/widget/banner_view.dart';
import 'package:six_cash/view/screens/home/widget/custom_card.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_screen.dart';

class SecondCardPortion extends StatelessWidget {
  const SecondCardPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return Stack(children: [
          Container(height: 75, color: Theme.of(context).primaryColor),

          Positioned(child: Column(children: [


            Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall),
              child: Row(
                children: [
                  if(splashController.configModel!.systemFeature!.sendMoneyStatus!) Expanded(
                    child: CustomCard(
                      image: Images.sendMoneyLogo,
                      text: 'send_money'.tr,
                      color: Theme.of(context).secondaryHeaderColor,
                      onTap: () {
                        Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'send_money'));
                      },
                    ),
                  ),

                  if(splashController.configModel!.systemFeature!.cashOutStatus!) Expanded(
                    child: CustomCard(
                      image: Images.cashOutLogo,
                      text: 'cash_out'.tr,
                      color: ColorResources.getCashOutCardColor(),
                      onTap: () {
                        Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'cash_out'));
                      },
                    ),
                  ),

                  if(splashController.configModel!.systemFeature!.addMoneyStatus!)Expanded(
                    child: CustomCard(
                      image: Images.walletLogo,
                      text: 'add_money'.tr,
                      color: ColorResources.getAddMoneyCardColor(),
                      onTap: () => Get.to(const TransactionMoneyBalanceInput(
                        transactionType: TransactionType.addMoney,
                      )),
                    ),
                  ),

                ],
              ),
            ),

            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall),
              child: Row(
                children: [
                  if(splashController.configModel!.systemFeature!.sendMoneyRequestStatus!) Expanded(
                    child: CustomCard(
                      image: Images.receivedMoneyLogo,
                      text: 'request_money'.tr,
                      color: ColorResources.getRequestMoneyCardColor(),
                      onTap: () {
                        Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'request_money'));
                      },
                    ),
                  ),


                ],
              ),
            ),
            /// Banner..
            const BannerView(),
          ],
          )),
        ]);
      }
    );
  }

}
