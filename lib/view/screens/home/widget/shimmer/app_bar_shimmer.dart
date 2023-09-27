import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/dimensions.dart';
class AppBarShimmer extends StatelessWidget {
  const AppBarShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        padding: const EdgeInsets.only(
            top: 54,
            left: Dimensions.paddingSizeLarge,
            right: Dimensions.paddingSizeLarge,
            bottom: Dimensions.paddingSizeSmall),
        decoration: const BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.radiusSizeExtraLarge),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: Dimensions.radiusSizeOverLarge,
              width: Dimensions.radiusSizeOverLarge,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius:
                BorderRadius.circular(Dimensions.radiusSizeDefault),
              ),
            ),
            const SizedBox(
              width: Dimensions.paddingSizeSmall,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.fontSizeDefault,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: Dimensions.fontSizeExtraLarge,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              height: 45,width: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
