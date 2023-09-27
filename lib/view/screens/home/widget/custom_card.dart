import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
class CustomCard extends StatelessWidget {
  final String? image;
  final String? text;
  final VoidCallback? onTap;
  final Color? color;
   const CustomCard({Key? key, this.image, this.text, this.onTap, this.color}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),// color: color,
         boxShadow: [BoxShadow(color: ColorResources.getWhiteAndBlack().withOpacity(0.1), blurRadius: 40, offset: const Offset(0, 4))]),


       child: CustomInkWell(
         onTap: onTap,
         radius: Dimensions.radiusSizeDefault,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             const SizedBox(height: Dimensions.paddingSizeDefault),
             Container(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
               decoration: BoxDecoration(shape: BoxShape.circle, color:  Colors.transparent),
               child: SizedBox(height: 50, width: 50,
                 child: Image.asset(image!, fit: BoxFit.contain))),
             const SizedBox(height: 8),



             Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall+1),
               child: Text(text!, textAlign: TextAlign.center, maxLines: 2, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color),),
             )
           ],
         ),
       ),
     );
  }
}