
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/data/model/money_paper.dart';
import 'package:six_cash/data/model/response/language_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

class MoneyPaperWidget extends StatelessWidget {

final MoneyPaperModel item;
  final int index;



  Function? selectedPaperMoney;

   MoneyPaperWidget({Key? key,   required this.index, required this.item, required  this.selectedPaperMoney}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: ColorResources.getWhiteAndBlack(),
        borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraSmall),
        boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, blurRadius: 5, spreadRadius: 1)],
      ),
      child: CustomInkWell(
        onTap: (){
          selectedPaperMoney!(item.amount);
        },
        radius: Dimensions.radiusSizeExtraSmall,
        child: Stack(children: [

          Center(

            child: Column(mainAxisSize: MainAxisSize.min,

                children: [
              Container(
                height: 100, width: 200,
                decoration: BoxDecoration(
                //  borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraSmall),
               // border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!, width: 1),
                ),
                alignment: Alignment.center,
                child: Image.asset(item.image, width: 200, height: 100,),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Text("${item.amount} SLL", style: rubikMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color,fontSize: 18)),
            ]),
          ),

      //    2 == index ? Positioned(
      //      top: 10, right: 10,
      //      child: Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 25),
      //    ) : const SizedBox(),

        ]),
      ),
    );
  }
}
