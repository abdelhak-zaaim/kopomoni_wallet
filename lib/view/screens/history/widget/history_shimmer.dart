import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/dimensions.dart';

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  size = MediaQuery.of(context).size;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 10, padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.grey[200]!,
            child: Container(
              margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              color: Colors.black26,
              child: Row(
                children: [
                  SizedBox(
                      height: Dimensions.radiusSizeExtraExtraLarge,
                      width: Dimensions.radiusSizeExtraExtraLarge,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSizeOverLarge),
                        child: Container(color: Colors.black45,),
                      )
                  ),
                  const SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,width: size.width*0.3,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        height: 20,width: size.width*0.4,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        height: 10,width: size.width*0.3,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 20,width: size.width*0.2,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    /*return Expanded(
      child: Shimmer.fromColors(baseColor: ColorResources.shimmerBaseColor, highlightColor:  ColorResources.shimmerLightColor,
        child: ListView.builder( itemCount: 20, itemBuilder: (context, item) =>
            Column(
              children: [
                if(item == 0) Padding(
                  padding: Get.find<LocalizationController>().isLtr ? const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL, bottom: Dimensions.PADDING_SIZE_SMALL) :
                  const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL, bottom: Dimensions.PADDING_SIZE_SMALL),
                  child: Container(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE, child: ListView.builder( itemCount: 5, scrollDirection: Axis.horizontal, itemBuilder: (context, item) =>
                    Padding(
                      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                      child: Container(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE, width: 90.0,
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_LARGE)),),
                    )
                  )),
                ),
                Column(
                  children: [
                    ListTile(leading: CircleAvatar(foregroundColor: Colors.red),
                      title:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(color: Colors.red, height: Dimensions.PADDING_SIZE_SMALL, width: size.width * 0.3),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Container(color: Colors.red, height: Dimensions.PADDING_SIZE_EXTRA_SMALL, width: size.width * 0.5),
                        ],
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Container(color: Colors.red, height: Dimensions.PADDING_SIZE_DEFAULT, width: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                      child: Container(color: Colors.red, height: Dimensions.DIVIDER_SIZE_SMALL),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
    );*/
  }
}
