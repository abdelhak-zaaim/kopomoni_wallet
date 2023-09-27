import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:six_cash/controller/add_money_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';

class DigitalPaymentView extends StatefulWidget {
  const DigitalPaymentView({Key? key}) : super(key: key);

  @override
  State<DigitalPaymentView> createState() => _DigitalPaymentViewState();
}

class _DigitalPaymentViewState extends State<DigitalPaymentView> {
  AutoScrollController? scrollController;

  @override
  void initState() {
    scrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.horizontal,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> paymentList = Get.find<SplashController>().configModel!.activePaymentMethodList ?? [];
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: paymentList.map((method) {
           return AutoScrollTag(
             controller: scrollController!,
             key: ValueKey(paymentList.indexOf(method)),
             index: paymentList.indexOf(method),
             child: GetBuilder<AddMoneyController>(
                  builder: (addMoneyController) {
                  return InkWell(
                    radius: 10,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () async {
                      addMoneyController.setPaymentMethod(addMoneyController.paymentMethod == method ? null : method);
                      await scrollController!.scrollToIndex(paymentList.indexOf(method), preferPosition: AutoScrollPosition.middle);
                    },
                    child: Card(
                      child: Container(
                        width: 130, height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeExtraSmall),

                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  method.replaceAll('_', ' ').toTitleCase(),
                                  maxLines: 1,
                                  style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                ),

                                const SizedBox(height: Dimensions.paddingSizeDefault,),


                                Image.asset(Images.getPaymentImage(method), height: 25, width: 80),



                              ],),

                            if(addMoneyController.paymentMethod == method) Positioned.fill(
                              child:  Align(
                                  alignment: Alignment.centerRight, child: Transform(
                                transform: Matrix4.translationValues(0,10, 0),
                                child: Icon(
                                  Icons.check_circle, color: Theme.of(context).primaryColor,
                                  size: 25,
                                ),
                              )),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
           );
        }).toList(),
      ),
    );
  }
}


extension StringExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}