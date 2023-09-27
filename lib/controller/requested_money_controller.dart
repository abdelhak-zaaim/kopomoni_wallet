import 'package:six_cash/data/api/api_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/data/model/withdraw_histroy_model.dart';
import 'package:six_cash/data/repository/requested_money_repo.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';


class RequestedMoneyController extends GetxController implements GetxService {
  final RequestedMoneyRepo requestedMoneyRepo;
  RequestedMoneyController({required this.requestedMoneyRepo});



  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<RequestedMoney> _requestedMoneyList = [];
  List<RequestedMoney> _ownRequestList = [];

  List<RequestedMoney> get requestedMoneyList => _requestedMoneyList;
  List<RequestedMoney> get ownRequestList => _ownRequestList;

  List<RequestedMoney> _pendingRequestedMoneyList =[];
  List<RequestedMoney> _ownPendingRequestedMoneyList =[];

  List<RequestedMoney> get pendingRequestedMoneyList => _pendingRequestedMoneyList;
  List<RequestedMoney> get ownPendingRequestedMoneyList => _ownPendingRequestedMoneyList;

  List<RequestedMoney> _acceptedRequestedMoneyList =[];
  List<RequestedMoney> _ownAcceptedRequestedMoneyList =[];

  List<RequestedMoney> get acceptedRequestedMoneyList =>_acceptedRequestedMoneyList;
  List<RequestedMoney> get ownAcceptedRequestedMoneyList =>_ownAcceptedRequestedMoneyList;

  List<RequestedMoney> _deniedRequestedMoneyList =[];
  List<RequestedMoney> _ownDeniedRequestedMoneyList =[];

  List<RequestedMoney> get deniedRequestedMoneyList => _deniedRequestedMoneyList;
  List<RequestedMoney> get ownDeniedRequestedMoneyList => _ownDeniedRequestedMoneyList;

  WithdrawHistoryModel? _withdrawHistoryModel;
  WithdrawHistoryModel? get withdrawHistoryModel => _withdrawHistoryModel;

  List<WithdrawHistory> pendingWithdraw = [];
  List<WithdrawHistory> acceptedWithdraw = [];
  List<WithdrawHistory> deniedWithdraw = [];
  List<WithdrawHistory> allWithdraw = [];

  int? _pageSize;
  int? get pageSize => _pageSize;

  RequestedMoneyModel? _requestedMoneyModel;
  RequestedMoneyModel? _ownRequestMoneyModel;
  RequestedMoneyModel? get  ownRequestMoneyModel => _ownRequestMoneyModel;


  Future getRequestedMoneyList(bool reload, {bool isUpdate = true}) async{

    if(reload || _requestedMoneyModel == null) {
      _requestedMoneyModel = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }

    if(_requestedMoneyModel == null){
      Response response = await requestedMoneyRepo.getRequestedMoneyList();
      if(response.statusCode == 200){
        _requestedMoneyModel = RequestedMoneyModel.fromJson(response.body);

        _requestedMoneyList = [];
        _pendingRequestedMoneyList =[];
        _acceptedRequestedMoneyList =[];
        _deniedRequestedMoneyList =[];

        _requestedMoneyModel?.requestedMoney?.forEach((req) {
          if(req.sender != null) {
            if(req.type == AppConstants.approved){
              _acceptedRequestedMoneyList.add(req);
            }else if(req.type == AppConstants.pending){
              _pendingRequestedMoneyList.add(req);
            }else if(req.type == AppConstants.denied){
              _deniedRequestedMoneyList.add(req);
            }
            _requestedMoneyList.add(req);
          }
        });

      }else{
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();

    }

  }

  Future getOwnRequestedMoneyList(bool reload, {bool isUpdate = true}) async{

    if(reload || _ownRequestMoneyModel == null) {
      _ownRequestMoneyModel = null;
      _isLoading = true;
      if(isUpdate){
        update();
      }
    }
    if(_ownRequestMoneyModel == null){
      Response response = await requestedMoneyRepo.getOwnRequestedMoneyList();

      if(response.statusCode == 200 && response.body['requested_money'] != null){

        _ownRequestMoneyModel = RequestedMoneyModel.fromJson(response.body);

        _ownRequestList =[];
        _ownPendingRequestedMoneyList = [];
        _ownAcceptedRequestedMoneyList = [];
        _ownDeniedRequestedMoneyList = [];

        _ownRequestMoneyModel?.requestedMoney?.forEach((requested) {

          if(requested.receiver != null){
            _ownRequestList.add(requested);
            if(requested.type == AppConstants.approved){
              _ownAcceptedRequestedMoneyList.add(requested);
            }else if(requested.type == AppConstants.pending){
              _ownPendingRequestedMoneyList.add(requested);
            }else if(requested.type == AppConstants.denied){
              _ownDeniedRequestedMoneyList.add(requested);
            }
          }


        });
      }else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }

  }

  Future<void> acceptRequest(BuildContext context, int? requestId, String pin) async {
    _isLoading = true;
    update();
    Response response = await requestedMoneyRepo.approveRequestedMoney(requestId, pin);

    if(response.statusCode == 200) {
      await getRequestedMoneyList(true);
      Get.back();
      Get.back();
      _isLoading = false;
    }else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
   update();
  }
  Future<void> denyRequest(BuildContext context, int? requestId, String pin ) async {
    _isLoading = true;
    update();
    Response response = await requestedMoneyRepo.denyRequestedMoney(requestId, pin);
    if(response.statusCode == 200) {
      await getRequestedMoneyList(true);
      Get.back();
      showCustomSnackBar('request_denied_successfully'.tr, isError: false);
      _isLoading = false;
    }else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }


  int _requestTypeIndex = 0;
  int get requestTypeIndex => _requestTypeIndex;

  void setIndex(int index, {bool isUpdate = true}) {
    _requestTypeIndex = index;
    if(isUpdate){
      update();
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  Future getWithdrawHistoryList({bool reload = false,  bool isUpdate = true}) async{

    if(reload || _withdrawHistoryModel == null) {
      _withdrawHistoryModel = null;
      _isLoading = true;
      if(isUpdate){
        update();
      }
    }

    if(_withdrawHistoryModel == null) {
      Response response = await requestedMoneyRepo.getWithdrawRequest();
      if(response.body['response_code'] == 'default_200' && response.body['content'] != null){

        pendingWithdraw = [];
        acceptedWithdraw = [];
        deniedWithdraw = [];
        allWithdraw = [];

        _withdrawHistoryModel = WithdrawHistoryModel.fromJson(response.body);

        for (var withdrawHistory in _withdrawHistoryModel!.withdrawHistoryList) {
          pendingWithdraw.addIf(withdrawHistory.requestStatus == AppConstants.pending, withdrawHistory);
          acceptedWithdraw.addIf(withdrawHistory.requestStatus == AppConstants.approved, withdrawHistory);
          deniedWithdraw.addIf(withdrawHistory.requestStatus == AppConstants.denied, withdrawHistory);
          allWithdraw.add(withdrawHistory);
        }

      }
      else{
        ApiChecker.checkApi(response);
      }

    }
    _isLoading = false;
    update();

  }

}