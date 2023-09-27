
import 'package:flutter/material.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class CustomSmallButton extends StatelessWidget {
  final String? text;
  final Function onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double textSize;
  const CustomSmallButton({Key? key, 
    this.backgroundColor,
    required this.onTap,
    this.text,
    required this.textColor,
    this.textSize = Dimensions.fontSizeLarge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeDefault),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
        ),
      ),
      child:  Text(
        text!,
        style: rubikRegular.copyWith(
          color: textColor,
          fontSize: textSize,
        ),
      ),
    );
  }
  //Dimensions.FONT_SIZE_EXTRA_LARGE
}
