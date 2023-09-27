import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  size = MediaQuery.of(context).size;
    return Container(
      color: ColorResources.getWhiteAndBlack(),
      child: Shimmer.fromColors(baseColor: ColorResources.shimmerBaseColor!, highlightColor:  ColorResources.shimmerLightColor!,
          child : Container(

            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeDefault),
            child: ListTile(
              leading: const CircleAvatar(maxRadius: Dimensions.radiusProfileAvatar),

              title:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(color: Colors.red, height: Dimensions.paddingSizeSmall, width: size.width * 0.3),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Container(color: Colors.red, height: Dimensions.paddingSizeExtraSmall, width: size.width * 0.5),
                ],
              ),
            ),
          ),
      ),
    );
  }
}






