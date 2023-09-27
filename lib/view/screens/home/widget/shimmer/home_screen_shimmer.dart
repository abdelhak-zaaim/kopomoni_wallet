import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/app_bar_shimmer.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/banner_shimmer.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/web_site_shimmer.dart';
class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarShimmer(),
        Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey[200]!,
          child: Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.black12,
              ),
              Positioned(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 90,
                      margin: const  EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge,
                          vertical: Dimensions.paddingSizeLarge),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radiusSizeLarge),
                        color: Colors.black26,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeLarge,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: Dimensions.fontSizeLarge,
                                  width: size.width*0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.black26,
                                  ),
                                ),

                                const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall,
                                ),
                                Container(
                                  height: Dimensions.fontSizeExtraLarge,
                                  width: size.width*0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.black26,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 90,
                            width: size.width *0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeLarge),
                              color: Colors.black26,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),

                          ),
                        ],
                      ),
                    ),

                    /// Cards...
                    SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.fontSizeExtraSmall),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),

                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Banner..
                    const BannerShimmer(),
                    const WebSiteShimmer(),

                  ],
                ),
              ),
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}
