import 'package:flutter/material.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? buttonText;
  final Color? color;
  const CustomButton({Key? key, this.onTap, required this.buttonText, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
      ),
      child: CustomInkWell(
        onTap: onTap as void Function()?,
        radius: Dimensions.radiusSizeSmall,
        child: Padding(

          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(child: Text(buttonText!,maxLines: 1,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.white),)),

        ),
      ),
    );
  }
}
