import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
class PriceConverter {
  static String convertPrice(double price, {double? discount, String? discountType}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price - discount;
      }else if(discountType == 'percent') {
        price = price - ((discount / 100) * price);
      }
    }
    return '${Get.find<SplashController>().configModel!.currencySymbol}${(price).toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  static double convertWithDiscount(BuildContext context, double price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double? calculation(double? amount, double? discount, String type) {
    double? calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount;
    }else if(type == 'percent') {
      calculatedAmount = (discount! / 100) * amount!;
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : '\$'} OFF';
  }


  static double balanceWithCharge(double? amount, double? charge, bool isPercent){
    double newBalance = 0;
    if(isPercent){
     newBalance = (amount! * charge!) / 100 + amount;
    }else{
     newBalance =  amount! + charge!;
    }
    return newBalance;
  }

  static String availableBalance(){
    String? currencySymbol = Get.find<SplashController>().configModel!.currencySymbol;
    String currentBalance = Get.find<ProfileController>().userInfo!.balance!.toStringAsFixed(2);
    return Get.find<SplashController>().configModel!.currencyPosition == 'left' ?  '$currencySymbol$currentBalance' : '$currentBalance$currencySymbol';

  }
  static String newBalanceWithDebit({required double inputBalance, required double charge}){
    String? currencySymbol = Get.find<SplashController>().configModel!.currencySymbol;
    String currentBalance = (Get.find<ProfileController>().userInfo!.balance!  - (inputBalance+charge)).toStringAsFixed(2);
    return Get.find<SplashController>().configModel!.currencyPosition == 'left' ?  '$currencySymbol$currentBalance' : '$currentBalance$currencySymbol';

  }

  static String newBalanceWithCredit({required double inputBalance}){
    String? currencySymbol = Get.find<SplashController>().configModel!.currencySymbol;
    String currentBalance = (Get.find<ProfileController>().userInfo!.balance! + inputBalance).toStringAsFixed(2);
    return Get.find<SplashController>().configModel!.currencyPosition == 'left' ?  '$currencySymbol$currentBalance' : '$currentBalance$currencySymbol';

  }

  static String balanceInputHint(){
    String? currencySymbol = Get.find<SplashController>().configModel!.currencySymbol;
    String balance = '0';
    return Get.find<SplashController>().configModel!.currencyPosition == 'left' ?  '$currencySymbol$balance' : '$balance$currencySymbol';

  }
  static String balanceWithSymbol({String? balance}){
    String? currencySymbol = Get.find<SplashController>().configModel!.currencySymbol;
    return Get.find<SplashController>().configModel!.currencyPosition == 'left' ?  '$currencySymbol$balance' : '$balance$currencySymbol';


  }
}