import 'dart:async';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/repository/auth_repo.dart';
import 'package:get/get.dart';
class VerificationController extends GetxController implements GetxService{
   final AuthRepo authRepo;
  VerificationController({required this.authRepo});

  int maxSecond =  0;
  Timer? _timer;
  bool _visibility = false;
  bool get visibility => _visibility;
  Timer? get timer => _timer;

  void cancelTimer(){
    _timer!.cancel();
  }

  setVisibility(bool value){
    _visibility = value;
    update();
  }
  // otp
   String? _otp;
   String? get otp => _otp;
  void setOtp(String pin)=> _otp = pin;

 void startTimer(){
   _timer?.cancel();
   maxSecond = Get.find<SplashController>().configModel?.otpResendTime ?? 0;
   _timer = Timer.periodic(const Duration(seconds: 1), (_){
     if(maxSecond > 0){
       maxSecond = maxSecond - 1;
       _visibility = false;
     }
     else{
       _visibility = true;
       _timer!.cancel();

     }
     update();
   });
  }


}