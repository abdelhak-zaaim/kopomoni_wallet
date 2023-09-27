import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/dimensions.dart';

class SelfieAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showIcon;
  final Function? onTap;
  final bool fromEditProfile;
   const SelfieAppbar({Key? key,  this.onTap,required this.showIcon, required this.fromEditProfile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
      child: Padding(
        padding: const EdgeInsets.only(
            top: Dimensions.paddingSizeExtraExtraLarge,
            bottom: Dimensions.paddingSizeLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onTap as void Function()?,
             child: showIcon ?  const Icon(Icons.clear,color: Colors.white,)
             : Container(),
            ),
            Container(
              alignment: Alignment.center,
              child: showIcon ? IconButton(
                onPressed: () {
                  fromEditProfile  ? Get.offNamed(RouteHelper.getEditProfileRoute()) : Get.offNamed(RouteHelper.getOtherInformationRoute()) ;
                },
                icon: const Icon(Icons.check,color: Colors.white,),
              ) : Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size(double.maxFinite, 70);
}
