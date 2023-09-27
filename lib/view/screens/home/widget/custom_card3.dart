import 'package:flutter/material.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
class CustomCard3 extends StatelessWidget {
  final String? image;
  final String? text;
   final VoidCallback? onTap;
   final double? height;
  final double? width;
   const CustomCard3({Key? key, this.image, this.text, this.onTap,this.height,this.width}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
     return CustomInkWell(onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: height, width: width, child: Image.asset(image!, fit: BoxFit.contain)),

            const SizedBox(height: 10),
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),

              child: Text(text!, textAlign: TextAlign.center, maxLines: 2,
                style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}