import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController implements GetxService{

  ///Hero tag
   final String _heroShowQr = 'show-qr-hero';
   String get heroShowQr => _heroShowQr;

   ///Greetings

   String greetingMessage(){

     var timeNow = DateTime.now().hour;

     if (timeNow <= 12) {
       return 'good_morning'.tr;
     } else if ((timeNow > 12) && (timeNow <= 16)) {
       return 'good_afternoon'.tr;
     } else if ((timeNow > 16) && (timeNow < 20)) {
       return 'good_evening'.tr;
     } else {
       return 'good_night'.tr;
     }
   }


  /// For web site
  String _webSiteLink = '';
  String get webSiteLink => _webSiteLink;
  setWebLink(String link){
    _webSiteLink = '';
    _webSiteLink = link;
    update();
  }
   void launchURL(String url) async {
     if (await canLaunchUrl(Uri.parse(url))) {
       await launchUrl(Uri.parse(url), webOnlyWindowName: 'web');
     } else {
       showCustomSnackBar('Could not launch $url', isError: true);
     }
   }

  /// Sliding Banner
  int _activeIndicator = 0;
  int get activeIndicator => _activeIndicator;

  indicateIndex(int index) {
    _activeIndicator = index;
    update();
  }

  ///controlling bottom sheet
  GlobalKey<ExpandableBottomSheetState> expadedKey = GlobalKey();
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;
  expanded(bool state){
    _isExpanded = state;
  }


  int? _selectItem = 0;

  int? get selectedItem => _selectItem;

  itemSelect({int? index}){
    _selectItem = index;
    update();
  }


}