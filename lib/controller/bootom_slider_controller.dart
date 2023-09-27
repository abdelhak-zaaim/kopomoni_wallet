import 'dart:developer';
import 'package:get/get.dart';
import 'package:six_cash/data/model/body/transaction_body.dart';
import 'package:six_cash/helper/route_helper.dart';

class BottomSliderController extends GetxController implements GetxService {
  bool _isFloatingActionButton = false;
  bool _isNextBottomSheet = false;
  bool _isPinCompleted = false;
  bool _alinmentRightIndicator = false;
  bool _isStop = false;
  bool _isLoading = false;
  bool _isNextButtonLoading = false;
  bool _isOtpSheet = false;
  int _statusCode = 200;
  bool isPinVerified= false;
  String? _pin;
  TransactionBody? _transactionBody;
  String? _newBalance; //todo: profile data balance
  Response? response;

  bool get isFloatingActionButton => _isFloatingActionButton;
  bool get isNextBottomSheet => _isNextBottomSheet;
  bool get isPinCompleted => _isPinCompleted;
  bool get alinmentRightIndicator => _alinmentRightIndicator;
  bool get isStop => _isStop;
  bool get isLoading => _isLoading;
  bool get isNextButtonLoading => _isNextButtonLoading;
  bool get isOtpSheet => _isOtpSheet;
  TransactionBody? get transactionBody => _transactionBody;
  String? get newBalance => _newBalance;
  int get statusCode => _statusCode;

  String? get pin => _pin;

  set setTransactionBody(TransactionBody transactionBody){
    _transactionBody = transactionBody;
    update();
  }
  set setNewBalance(String setBalance){
    _newBalance = setBalance;
  }
  set setResponse(Response getResponse){
    response = getResponse;
  }
  set setIsLoading(bool value){
    _isLoading =  value;
    update();
  }
  set setStatusCode(int value){
    _statusCode =  value;
    update();
  }
  set setIsNextButtonLoading(bool value){
    _isNextButtonLoading =  value;
    update();
  }
  set setIsNextButtonSheet(bool value){
    _isNextBottomSheet =  value;
    update();
  }

  void setIsPinCompleted({required bool isCompleted, required bool isNotify}){
    _isPinCompleted =  isCompleted;
    if(isNotify) {
      update();
    }
  }



  changeFloatingActionButtonFun(bool state) {
    _isFloatingActionButton = state;
    update();

  }
  changeIsNextBottomSheetFun() {
    _isNextBottomSheet = !_isNextBottomSheet;
    update();

  }
  changeBottomSheetToOtp(){
    _isOtpSheet = true;
    update();

  }

  changePinComleted(String value){
    if (value.length==4) {
      _isPinCompleted = true;
      _pin = value;

    }else{
      _isPinCompleted = false;

    }

    update();
  }

  isStopFun(){
    _isStop = !_isStop;
  }
  resetPinField(){
    _pin = '';
    _isPinCompleted = false;
    update();
    Get.back(closeOverlays: true);
  }

  changeAlignmentValue(){
    if (_isStop) {
      Future.delayed(const Duration(seconds: 1)).then((value){
        _alinmentRightIndicator = !_alinmentRightIndicator;
        log(alinmentRightIndicator.toString());
        update();
        changeAlignmentValue();
      });

    }
  }

  void goBackButton(){
    // Get.find<ProfileController>().setUserInfo = null;
    changeIsNextBottomSheetFun();
    _isPinCompleted = false;
    Get.offAllNamed(RouteHelper.getNavBarRoute(), arguments:  true);
  }

}