import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';

class ContactShimmer extends StatelessWidget {
  const ContactShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: ColorResources.shimmerBaseColor!,
      highlightColor:  ColorResources.shimmerLightColor!,
      child: SizedBox(height: size.height, child: ListView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, item) => Column(children: [
          ListTile(leading: const CircleAvatar(foregroundColor: Colors.red),
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:  Dimensions.paddingSizeExtraExtraLarge),
            child: Container(color: Colors.red, height: Dimensions.dividerSizeSmall),
          ),
        ]),
      )),
    );
  }
}
