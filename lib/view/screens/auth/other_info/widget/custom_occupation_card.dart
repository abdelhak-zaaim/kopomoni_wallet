import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';

class CustomOccupationCard extends StatelessWidget {
  final String? icon, text;
  final bool? check;
  const CustomOccupationCard({Key? key, this.icon, this.text, this.check}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: Dimensions.paddingSizeDefault,
            top: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeLarge,
          ),
          height: 75,
          width: 84,
          decoration: BoxDecoration(
            color: ColorResources.getOccupationCardColor(),
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
            boxShadow: [
              BoxShadow(
                color: ColorResources.getShadowColor().withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 26.81,
                width: 26.81,
                child: Image.asset(icon!),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraSmall,
              ),
              Text(
                text!,
                textAlign: TextAlign.center,
                style: rubikRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Visibility(
            visible: check!,
            child: Container(
              height: 16,width: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check,color: Colors.white,size: 12,),
            ),
          ),
        ),
      ],
    );
  }
}
