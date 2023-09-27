import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/response/config_model.dart';
import 'package:six_cash/data/repository/splash_repo.dart';

class SplashController extends GetxController implements GetxService{
   final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  ConfigModel? _configModel;
  bool _isVpn = false;

  final DateTime _currentTime = DateTime.now();

  DateTime get currentTime => _currentTime;
  bool _firstTimeConnectionCheck = true;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  ConfigModel? get configModel => _configModel;
  bool get isVpn => _isVpn;

  Future<Response> getConfigData() async {
    Response response = await splashRepo.getConfigData();
    if(response.statusCode == 200){
      _configModel =  ConfigModel.fromJson(response.body);
    }
   else {
     ApiChecker.checkApi(response);
   }
    update();
    return response;

  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }

  bool isRestaurantClosed() {
    DateTime open = DateFormat('hh:mm').parse('');
    DateTime close = DateFormat('hh:mm').parse('');
    DateTime openTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, open.hour, open.minute);
    DateTime closeTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, close.hour, close.minute);
    if(closeTime.isBefore(openTime)) {
      closeTime = closeTime.add(const Duration(days: 1));
    }
    if(_currentTime.isAfter(openTime) && _currentTime.isBefore(closeTime)) {
      return false;
    }else {
      return true;
    }
  }


  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }


 Future<bool> checkVpn() async {
    _isVpn = await ApiChecker.isVpnActive();
    // if(_isVpn) {
    //   showCustomSnackBar('you are using vpn', isVpn: true, duration: Duration(minutes: 10));
    // }
    return _isVpn;
  }
}
