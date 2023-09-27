import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/dimensions.dart';
class WebSiteShimmer extends StatelessWidget {
  const WebSiteShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[200]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: size.width*0.3,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
         const SizedBox(height: 10,),
          Container(
            height: 86,
            width: double.infinity,
            color: Colors.black12,
            child:  ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeLarge),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,vertical:  Dimensions.paddingSizeSmall),
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 50,

                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Container(
                                height: 10,width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            ],
                          ),
                        );
                      }
          ),),
        ],
      ),
    );
  }
}
