import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/controller/bootom_slider_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/screen_shot_widget_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import '../../../../util/app_constants.dart';
import 'avator_section.dart';

class BottomSheetWithSlider extends StatefulWidget {
  final String amount;
  final String? pinCode;
  final String? transactionType;
  final String? purpose;
  final ContactModel? contactModel;
  const BottomSheetWithSlider({Key? key, required this.amount, this.pinCode, this.transactionType, this.purpose, this.contactModel}) : super(key: key);

  @override
  State<BottomSheetWithSlider> createState() => _BottomSheetWithSliderState();
}

class _BottomSheetWithSliderState extends State<BottomSheetWithSlider> {
  String? transactionId ;
  FlutterTts flutterTts = FlutterTts();

  Future<bool> getText2Speak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool myBool = prefs.getBool(AppConstants.text2speach) ?? true;
    return myBool;
  }

  Future<void> speak(String text) async {


if(await getText2Speak()) {
  await flutterTts.setLanguage(
      "en-US"); // Replace with your desired language code
  await flutterTts.setPitch(0.8); // Adjust pitch if needed
  await flutterTts.speak(text);
}
  }
  @override
  void initState() {




    Get.find<TransactionMoneyController>().changeTrueFalse();
    super.initState();
  }

  Future<bool> pop() async {
    Get.offAllNamed(RouteHelper.getNavBarRoute());
    return true;
  }

  @override
  Widget build(BuildContext context) {

    String type = widget.transactionType=='send_money'?'send_money'.tr : widget.transactionType=='cash_out'?'cash_out'.tr  :'request_money'.tr;
    double cashOutCharge = double.parse(widget.amount.toString()) * (double.parse(Get.find<SplashController>().configModel!.cashOutChargePercent.toString())/100);
    String customerImage = '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${widget.contactModel!.avatarImage}';
    String agentImage = '${Get.find<SplashController>().configModel!.baseUrls!.agentImageUrl}/${widget.contactModel!.avatarImage}';
    return WillPopScope(
      onWillPop: ()=> pop(),
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.getBackgroundColor(),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusSizeLarge), topRight:Radius.circular(Dimensions.radiusSizeLarge) ),
        ),

        child: GetBuilder<TransactionMoneyController>(
          builder: (transactionMoneyController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                      decoration: BoxDecoration(
                        color: ColorResources.getLightGray().withOpacity(0.8),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSizeLarge) ),
                      ),
                      child: Text('${'confirm_to'.tr} $type', style: rubikSemiBold.copyWith(),),
                    ),
                    !transactionMoneyController.isLoading?
                    Visibility(
                      visible: !transactionMoneyController.isNextBottomSheet,
                      child: Positioned(
                        top: Dimensions.paddingSizeSmall,
                        right: 8.0,
                        child: GestureDetector(onTap: ()=> Get.back(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: ColorResources.getGreyBaseGray6()),
                                child: const Icon(Icons.clear,size: Dimensions.paddingSizeDefault,))),
                      ),
                    ) : const SizedBox(),
                  ],
                ),

                transactionMoneyController.isNextBottomSheet?
                Column(
                  children: [
                    transactionMoneyController.isNextBottomSheet ? Lottie.asset(
                      Images.successAnimation,
                      width: 120.0,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ) : Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall), child: Lottie.asset(
                      Images.failedAnimation,
                      width: 80.0,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                    ),
                  ],
                ): AvatarSection(image: widget.transactionType != 'cash_out'? customerImage : agentImage),

                Container(
                  color: ColorResources.getBackgroundColor(),
                  child: Column(
                    children: [
                      !transactionMoneyController.isNextBottomSheet && widget.transactionType != "request_money"?
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('charge'.tr,
                              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                          Text(widget.transactionType=='send_money'? PriceConverter.balanceWithSymbol(balance: Get.find<SplashController>().configModel!.sendMoneyChargeFlat.toString()) :
                          PriceConverter.balanceWithSymbol(balance: cashOutCharge.toString()), style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        ],
                      ):const SizedBox(),

                      transactionMoneyController.isNextBottomSheet ?
                      Text(widget.transactionType=='send_money'? 'send_money_successful'.tr : widget.transactionType=='request_money'?'request_send_successful'.tr:'cash_out_successful'.tr,
                          style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.titleLarge!.color)):const SizedBox(),

                      const SizedBox(height: Dimensions.paddingSizeExtraExtraLarge),

                      Text(PriceConverter.balanceWithSymbol(balance: widget.amount), style: rubikMedium.copyWith(fontSize: 34.0)),
                      const SizedBox(height: Dimensions.paddingSizeLarge),

                      GetBuilder<ProfileController>(builder: (profileController) {
                          return profileController.isLoading ? const SizedBox() : Text(
                            '${'new_balance'.tr} ${
                                  transactionMoneyController.isNextBottomSheet ?
                                  PriceConverter.balanceWithSymbol(balance: '${profileController.userInfo!.balance}') :
                                  widget.transactionType == 'request_money'
                                ? PriceConverter.newBalanceWithCredit(inputBalance: double.parse(widget.amount))
                                : PriceConverter.newBalanceWithDebit(inputBalance: double.parse(widget.amount),

                                charge: widget.transactionType =='send_money'
                                    ? double.parse(Get.find<SplashController>().configModel!.sendMoneyChargeFlat.toString())
                                    : cashOutCharge)
                            }',

                            style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                          );
                        }
                      ),

                      const SizedBox(height: Dimensions.paddingSizeDefault),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: Divider(height: Dimensions.dividerSizeSmall),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeDefault,
                          horizontal: Dimensions.paddingSizeDefault,
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.transactionType != "cash_out"?  widget.purpose! : 'cash_out'.tr,
                              style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.contactModel!.name == null?'(unknown )' :'(${widget.contactModel!.name}) ',
                                  style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                ),

                                Text(
                                  widget.contactModel!.phoneNumber == null
                                      ? '' : '${widget.contactModel!.phoneNumber}',
                                  style: rubikSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                                ),
                              ],
                            ),

                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                            transactionMoneyController.isNextBottomSheet ?
                            transactionId != null? Text(
                              'TrxID: $transactionId',
                              style: rubikLight.copyWith(fontSize: Dimensions.fontSizeDefault),
                            ): const SizedBox() : const SizedBox(),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),


                transactionMoneyController.isNextBottomSheet?
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault / 1.7),
                      child: Divider(height: Dimensions.dividerSizeSmall),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    CustomInkWell(
                      onTap:() async => await  Get.find<ScreenShootWidgetController>().statementScreenShootFunction(
                        amount: widget.amount,
                        transactionType: widget.transactionType,
                        contactModel: widget.contactModel,
                        charge: widget.transactionType=='send_money'
                            ? Get.find<SplashController>().configModel!.sendMoneyChargeFlat.toString()
                            :  cashOutCharge.toString(),trxId: transactionId,
                      ),
                      child: Text('share_statement'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    ),

                    const SizedBox(height: Dimensions.paddingSizeDefault),
                  ],
                ) : const SizedBox(),



                transactionMoneyController.isNextBottomSheet ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraLarge),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                    ),
                    child: CustomInkWell(
                      onTap: (){
                        Get.find<BottomSliderController>().goBackButton();
                      },
                      radius: Dimensions.radiusSizeSmall,
                      highlightColor: Theme.of(context).textTheme.titleLarge!.color!.withOpacity(0.1),
                      child: SizedBox(
                        height: 50.0,
                        child: Center(child: Text(
                          'back_to_home'.tr,
                          style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                        )),

                      ),
                    ),
                  ),
                ):
                transactionMoneyController.isLoading
                    ? Center(child: CircularProgressIndicator(color: Theme.of(context).textTheme.titleLarge!.color,))
                    : ConfirmationSlider(
                        height: 60.0,
                        backgroundColor: ColorResources.getGreyBaseGray6(),
                        text: 'swipe_to_confirm'.tr,
                        textStyle: rubikRegular.copyWith(fontSize: Dimensions.paddingSizeLarge),
                        shadow: const BoxShadow(),
                        sliderButtonContent: Container(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(Images.slideRightIcon),

                        ),
                        onConfirmation: ()async{
                          if( widget.transactionType == "send_money"){
                            transactionMoneyController.sendMoney(
                              contactModel: widget.contactModel!,
                              amount: double.parse(widget.amount),
                              purpose: widget.purpose,
                              pinCode: widget.pinCode,
                            ).then((value) {
                              transactionId = value.body['transaction_id'];
                            });
                          }else if(widget.transactionType == "request_money"){
                            transactionMoneyController.requestMoney(
                              contactModel: widget.contactModel!,
                              amount: double.parse(widget.amount),
                            );
                          }else if(widget.transactionType == "cash_out"){
                            transactionMoneyController.cashOutMoney(
                              contactModel: widget.contactModel!,
                              amount: double.parse(widget.amount),
                              pinCode: widget.pinCode,
                            ).then((value) {

                              speak(widget.transactionType=='send_money'? 'send_money_successful'.tr : widget.transactionType=='request_money'?'request_send_successful'.tr:'cash_out_successful'.tr);

                              transactionId = value.body['transaction_id'];
                            });
                          }


                       },

                ),
                const SizedBox(height: 40.0),

              ],
            );
          }
        ),
      ),
    );
  }
}