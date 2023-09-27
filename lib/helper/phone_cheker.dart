
import 'package:flutter/cupertino.dart';
import 'package:phone_number/phone_number.dart';

class PhoneChecker {
  static Future<PhoneNumber?> isNumberValid(String phone) async {
    PhoneNumber? num;
    try{
      num = await PhoneNumberUtil().parse(phone);

    }catch(e){
      debugPrint('error ---> $e');
    }
    return num ;
  }
}