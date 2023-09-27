import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';

class AnimatedButtonView extends StatefulWidget {
  final Function onTap;
  const AnimatedButtonView({Key? key,required this.onTap}) : super(key: key);

  @override
  State<AnimatedButtonView> createState() => _AnimatedButtonViewState();
}

class _AnimatedButtonViewState extends State<AnimatedButtonView> {

  double _width = Get.width * 0.11;
  double _textWidth = 0;
  final double _height = Get.width * 0.11;

  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 500)).then((value){
      setState(() {
        _width = Get.width * 0.25;

      });
    });
    Future.delayed(const Duration(milliseconds: 700)).then((value){
      setState(() {
        _textWidth = Get.width * 0.16;

      });
    });

    Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        _width = Get.width * 0.12;
        _textWidth = 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap as void Function()?,
      child: AnimatedContainer(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_height/2)),
          color: Theme.of(context).cardColor,
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const SizedBox(),
          Image.asset(
            Images.withdraw, height: IconTheme.of(context).size,
          ),

          AnimatedContainer(
            width: _textWidth,
            duration: const Duration(milliseconds: 500),
            child: Text(
              'withdraw_request'.tr, maxLines: 2,
              textAlign: TextAlign.center,
              style: rubikLight.copyWith(fontSize: Dimensions.fontSizeSmall),
            ),
          ),

        ]),
      ),
    );
  }
}
