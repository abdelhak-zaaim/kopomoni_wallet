
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:six_cash/controller/camera_screen_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

import '../../../../util/images.dart';
import '../../../base/custom_app_bar.dart';
import '../../profile/widget/edit_profile_screen.dart';
import '../other_info/information_screen.dart';

class CameraScreen extends StatefulWidget {
  final bool fromEditProfile;
  final bool isBarCodeScan;
  final bool isHome;
  final String? transactionType;
  const CameraScreen({
    Key? key,
    required this.fromEditProfile,
    this.isBarCodeScan = false,
    this.isHome = false,
    this.transactionType = '',
  }) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {


  @override
  void dispose() {
    Get.find<CameraScreenController>().stopLiveFeed();
    super.dispose();
  }
  @override
  void initState() {
    Get.find<CameraScreenController>().valueInitialize(widget.fromEditProfile);
    Get.find<CameraScreenController>().startLiveFeed(
      isQrCodeScan: widget.isBarCodeScan,
      isHome: widget.isHome,
      transactionType: widget.transactionType,
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppbar(title: widget.isBarCodeScan ? 'scanner'.tr : 'face_verification'.tr, isSkip: (!widget.isBarCodeScan && true && !widget.fromEditProfile), function: () {
        if(widget.fromEditProfile) {
          Get.off(() => const EditProfileScreen());
        }else{
          Get.off(() => const InformationScreen());
        }
      }),
      body:  Column(children: [
        Flexible(flex: 2, child: Stack(children: [
          GetBuilder<CameraScreenController>(
              builder: (cameraController) {
                if (cameraController.controller == null ||
                    cameraController.controller?.value.isInitialized == false) {
                  return const SizedBox();
                }

                return Container(
                  color: Colors.black,
                  height: size.height * 0.7,
                  width: size.width,
                  child: AspectRatio(
                    aspectRatio: cameraController.controller!.value.aspectRatio,
                    child: CameraPreview(cameraController.controller!),
                  ),
                );
              }
          ),

          FractionallySizedBox(
            child: Align(
              alignment: Alignment.center,
              child: DottedBorder(
                strokeWidth: 3,borderType: BorderType.Rect, dashPattern: const [10],color: Colors.white,
                child: const FractionallySizedBox(heightFactor: 0.7, widthFactor: 0.8),
              ),
            ),
          ),
        ])),

        Flexible(
          flex: 1,
          child: HintView(isBarCodeScan: widget.isBarCodeScan),
        ),
      ]),
    );
  }

}

class HintView extends StatelessWidget {
  const HintView({
    Key? key, required this.isBarCodeScan,
  }) : super(key: key);

  final bool isBarCodeScan;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraScreenController>(
        builder: (cameraScreenController) {
          return SingleChildScrollView(
            child: isBarCodeScan ? Center(
              child: Image.asset(
                  Images.qrScanAnimation,
                  width: 120,
                  fit: BoxFit.contain,
                  alignment: Alignment.center
              ),
            ) :
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 5.0,
                  percent: cameraScreenController.eyeBlink / 2,
                  center: Image.asset(Images.eyeIcon, width: 40),
                  progressColor: Theme.of(context).primaryColor,
                ),

                const SizedBox(height: Dimensions.paddingSizeDefault),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Text(cameraScreenController.eyeBlink < 2 ? 'straighten_your_face'.tr : 'processing_image'.tr,
                    style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault), maxLines: 2, textAlign: TextAlign.center,
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
}
