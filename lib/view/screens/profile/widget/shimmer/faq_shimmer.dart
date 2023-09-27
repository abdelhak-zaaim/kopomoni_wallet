import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class FaqShimmer extends StatelessWidget {
  const FaqShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: Colors.grey[200]!,
        child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: size.width*0.5,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
