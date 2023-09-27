import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/view/screens/home/widget/animated_card/custom_rect_tween.dart';

class LoginQrPopupCard extends StatelessWidget {
  const LoginQrPopupCard({Key? key}) : super(key: key);
  final String _heroQrTag = 'hero-qr-tag';


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroQrTag,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GetBuilder<AuthController>(builder: (controller){
                  return controller.getUserData()?.qrCode != null ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SvgPicture.string(controller.getUserData()!.qrCode!,fit: BoxFit.contain,),
                  ) : const SizedBox();
                },)
            ),
          ),
        ),
      ),
    );
  }
}
