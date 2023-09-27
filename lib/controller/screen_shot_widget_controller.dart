

import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/transaction_money/widget/share_statement_widget.dart';

class ScreenShootWidgetController extends GetxController implements GetxService{
  ScreenshotController statementController = ScreenshotController();

  Future statementScreenShootFunction({required String amount,  required String? transactionType, required ContactModel? contactModel, required String charge,required String? trxId}) async{
    Uint8List? image;
    Get.to(ShareStatementWidget(amount: amount, transactionType: transactionType, contactModel: contactModel,charge: charge,trxId: trxId));
    Future.delayed(const Duration(milliseconds: 1000)).then((value) async {
      image =  await statementController.capture();

     Navigator.pop(Get.context!);
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/share.png');
      imageFile.writeAsBytesSync(image!);
      await Share.shareXFiles([XFile(imageFile.path)]);
    });

  }
  Future<void> qrCodeDownloadAndShare ({required String qrCode, required String phoneNumber, required bool isShare}) async{
    Uint8List? image;
    Get.toNamed(RouteHelper.getQrCodeDownloadOrShareRoute(qrCode: qrCode,phoneNumber: phoneNumber));
    Future.delayed(const Duration(milliseconds: 100)).then((value) async {
      image =  await statementController.capture();

      Navigator.pop(Get.context!);

      if(isShare == true){
        final directory = await getApplicationDocumentsDirectory();
        final imageFile = File('${directory.path}/share.png');
        imageFile.writeAsBytesSync(image!);
        await Share.shareXFiles([XFile(imageFile.path)]);
      }else{
        final directory = await getApplicationDocumentsDirectory();
        final imageFile = File('${directory.path}/qr.png');
        imageFile.writeAsBytesSync(image!);
        await GallerySaver.saveImage(imageFile.path,albumName: AppConstants.appName).then((value) => showCustomSnackBar('QR code save to your Gallery',isError: false));
      }


    });

  }

}