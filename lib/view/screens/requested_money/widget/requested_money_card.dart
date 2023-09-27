import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/data/model/withdraw_histroy_model.dart';
import 'package:six_cash/helper/date_converter.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/requested_money/requested_money_list_screen.dart';

import 'confirmation_dialog.dart';

class RequestedMoneyCard extends StatefulWidget {
  final RequestedMoney? requestedMoney;
  final bool? isHome;
  final RequestType? requestType;
  final WithdrawHistory? withdrawHistory;
  final List<FieldItem>? itemList;

  const RequestedMoneyCard(
      {Key? key,
      this.requestedMoney,
      this.isHome,
      this.requestType,
      this.withdrawHistory,
      this.itemList})
      : super(key: key);

  @override
  State<RequestedMoneyCard> createState() => _RequestedMoneyCardState();
}

class _RequestedMoneyCardState extends State<RequestedMoneyCard> {
  final TextEditingController reqPasswordController = TextEditingController();

  FlutterTts flutterTts = FlutterTts();
  Future<bool> getText2Speak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool myBool = prefs.getBool(AppConstants.text2speach) ?? true;
    return myBool;
  }
  Future<void> speak(String text) async {
    if(await getText2Speak()) {
      await flutterTts
          .setLanguage("en-US"); // Replace with your desired language code
      await flutterTts.setPitch(0.8); // Adjust pitch if needed
      await flutterTts.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? name;
    String? phoneNumber;
    if (widget.requestType != RequestType.withdraw) {
      try {
        if (widget.requestType == RequestType.sendRequest) {
          name = widget.requestedMoney!.receiver!.name;
          phoneNumber = widget.requestedMoney!.receiver!.phone;
        } else {
          name = widget.requestedMoney!.sender!.name;
          phoneNumber = widget.requestedMoney!.sender!.phone;
        }
      } catch (e) {
        name = 'user_unavailable'.tr;
        phoneNumber = 'user_unavailable'.tr;
      }
    }
    return widget.requestType == RequestType.withdraw
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      MethodFieldView(
                          type: 'withdraw_method'.tr,
                          value: '${widget.withdrawHistory!.methodName}'),
                      MethodFieldView(
                          type: 'request_status'.tr,
                          value: widget.withdrawHistory!.requestStatus.tr),
                      MethodFieldView(
                          type: 'amount'.tr,
                          value: PriceConverter.balanceWithSymbol(
                              balance: '${widget.withdrawHistory!.amount}')),
                      if (widget.requestType == RequestType.withdraw)
                        MethodFieldView(
                            type: 'charge'.tr,
                            value: PriceConverter.balanceWithSymbol(
                                balance:
                                    '${widget.withdrawHistory!.adminCharge}')),
                      if (widget.requestType == RequestType.withdraw)
                        MethodFieldView(
                            type: 'total_amount'.tr,
                            value: PriceConverter.balanceWithSymbol(
                                balance:
                                    '${widget.withdrawHistory!.amount! + widget.withdrawHistory!.adminCharge!}')),
                    ],
                  ),
                ),
                if (widget.itemList != null)
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Column(
                        children: widget.itemList!
                            .map((item) => Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: MethodFieldView(
                                    type: item.key
                                        .replaceAll('_', ' ')
                                        .capitalizeFirst!,
                                    value: item.value,
                                  ),
                                ))
                            .toList()),
                  )
              ],
            ),
          )
        : !(name == 'user_unavailable'.tr &&
                phoneNumber == 'user_unavailable'.tr)
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$name',
                                  style: rubikMedium.copyWith(
                                      color: ColorResources.getTextColor(),
                                      fontSize: Dimensions.fontSizeLarge)),
                              const SizedBox(
                                  height:
                                      Dimensions.paddingSizeSuperExtraSmall),
                              Text('$phoneNumber',
                                  style: rubikMedium.copyWith(
                                      color: ColorResources.getTextColor(),
                                      fontSize: Dimensions.fontSizeSmall)),
                              const SizedBox(
                                  height:
                                      Dimensions.paddingSizeSuperExtraSmall),
                              Text(
                                  '${'amount'.tr} - ${PriceConverter.balanceWithSymbol(balance: widget.requestedMoney!.amount.toString())}',
                                  style: rubikMedium.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color,
                                      fontSize: Dimensions.fontSizeDefault)),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              Text(
                                  DateConverter.localDateToIsoStringAMPM(
                                      DateTime.parse(
                                          widget.requestedMoney!.createdAt!)),
                                  style: rubikLight.copyWith(
                                      color: ColorResources.getTextColor(),
                                      fontSize: Dimensions.fontSizeSmall)),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Row(
                                children: [
                                  Text('${'note'.tr} - ',
                                      style: rubikSemiBold.copyWith(
                                          color: ColorResources.getTextColor(),
                                          fontSize: Dimensions.fontSizeLarge)),
                                  Text(
                                      widget.requestedMoney!.note ??
                                          'no_note_available'.tr,
                                      maxLines: widget.isHome! ? 1 : 10,
                                      overflow: TextOverflow.ellipsis,
                                      style: rubikLight.copyWith(
                                          color: ColorResources.getHintColor(),
                                          fontSize:
                                              Dimensions.fontSizeDefault)),
                                ],
                              ),
                            ]),
                        const Spacer(),
                        widget.requestedMoney!.type == AppConstants.pending &&
                                widget.requestType == RequestType.request
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(Dimensions
                                                .radiusSizeExtraLarge)),
                                        color: ColorResources.getAcceptBtn()),
                                    child: CustomInkWell(
                                        onTap: () {
                                          speak(
                                              '${'are_you_sure_want_to_accept'.tr} \n ${widget.requestedMoney!.sender!.name} \n ${widget.requestedMoney!.sender!.phone}');

                                          showAnimatedDialog(
                                              context,
                                              ConfirmationDialog(
                                                  passController:
                                                      reqPasswordController,
                                                  icon: Images.successIcon,
                                                  isAccept: true,
                                                  description:
                                                      '${'are_you_sure_want_to_accept'.tr} \n ${widget.requestedMoney!.sender!.name} \n ${widget.requestedMoney!.sender!.phone}',
                                                  onYesPressed: () {
                                                    Get.find<
                                                            RequestedMoneyController>()
                                                        .acceptRequest(
                                                            context,
                                                            widget
                                                                .requestedMoney!
                                                                .id,
                                                            reqPasswordController
                                                                .text
                                                                .trim());
                                                  }),
                                              dismissible: false,
                                              isFlip: true);
                                        },
                                        radius: Dimensions.radiusSizeExtraLarge,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall,
                                              vertical: Dimensions
                                                  .paddingSizeExtraSmall),
                                          child: Text('accept'.tr,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        )),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(Dimensions
                                                .radiusSizeExtraLarge)),
                                        border: Border.all(
                                            width: 1,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error
                                                .withOpacity(0.7))),
                                    child: CustomInkWell(
                                      onTap: () {
                                        speak(
                                            '${'are_you_sure_want_to_denied'.tr} \n ${widget.requestedMoney!.sender!.name} \n ${widget.requestedMoney!.sender!.phone}');

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ConfirmationDialog(
                                                  icon: Images.failedIcon,
                                                  passController:
                                                      reqPasswordController,
                                                  description:
                                                      '${'are_you_sure_want_to_denied'.tr} \n ${widget.requestedMoney!.sender!.name} \n ${widget.requestedMoney!.sender!.phone}',
                                                  onYesPressed: () {
                                                    Get.find<RequestedMoneyController>()
                                                            .isLoading
                                                        ? Center(
                                                            child: CircularProgressIndicator(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor))
                                                        : Get.find<
                                                                RequestedMoneyController>()
                                                            .denyRequest(
                                                                context,
                                                                widget
                                                                    .requestedMoney!
                                                                    .id,
                                                                reqPasswordController
                                                                    .text
                                                                    .trim());
                                                  });
                                            });
                                      },
                                      radius: Dimensions.radiusSizeExtraLarge,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4),
                                        child: Text('deny'.tr,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error
                                                    .withOpacity(0.7))),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                widget.requestedMoney!.type!.tr,
                                style: rubikRegular.copyWith(
                                    color: ColorResources.getAcceptBtn()),
                              )
                      ],
                    ),
                    const SizedBox(height: 5),
                    widget.isHome!
                        ? const SizedBox()
                        : Divider(
                            height: .5, color: ColorResources.getGreyColor()),
                  ],
                ),
              )
            : const SizedBox();
  }
}

class FieldItem {
  final String key;
  final String value;

  FieldItem(this.key, this.value);
}

class MethodFieldView extends StatelessWidget {
  final String type;
  final String value;

  const MethodFieldView({Key? key, required this.type, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: rubikLight.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
          Text(value),
        ],
      ),
    );
  }
}
