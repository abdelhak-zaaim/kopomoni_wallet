import 'package:flutter/material.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
class AppbarHomeElement extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarHomeElement({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: rubikSemiBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,color: Colors.white,),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault,)

        ],
      ),
      
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60.0);
}