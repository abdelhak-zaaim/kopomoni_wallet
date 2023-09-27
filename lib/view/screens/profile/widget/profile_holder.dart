import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).canvasColor,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, top: 30.0, bottom: 8.0,right: Dimensions.paddingSizeDefault),
            child: Text(title,style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getGreyBaseGray1())),
          ),
        ),
        Container(
          height: Dimensions.dividerSizeSmall,
          color: Theme.of(context).dividerColor,
        ),

      ],
    );
  }
}