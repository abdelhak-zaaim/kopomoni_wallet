import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/util/app_constants.dart';

class TransactionRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TransactionRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response>  getPurposeListApi() async {
    return await apiClient.getData(AppConstants.customerPurposeUrl );
  }

  Future<Response>  sendMoneyApi({required String? phoneNumber, required double amount,required String? purpose,required String? pin }) async {
    return await apiClient.postData(AppConstants.customerSendMoney,{'phone': phoneNumber, 'amount': amount, 'purpose':purpose, 'pin': pin});
  }

  Future<Response>  requestMoneyApi({required String? phoneNumber, required double amount}) async {
    return await apiClient.postData(AppConstants.customerRequestMoney,  {'phone' : phoneNumber, 'amount' : amount});
  }
  Future<Response>  cashOutApi({required String? phoneNumber, required double amount, required String? pin}) async {
    return await apiClient.postData(AppConstants.customerCashOut, {'phone' : phoneNumber, 'amount' : amount, 'pin' : pin});
  }

  Future<Response>  checkCustomerNumber({required String phoneNumber}) async {
    return await apiClient.postData(AppConstants.checkCustomerUri, {'phone' : phoneNumber});
  }
  Future<Response>  checkAgentNumber({required String phoneNumber}) async {
    return await apiClient.postData(AppConstants.checkAgentUri, {'phone' : phoneNumber});
  }


  List<ContactModel>? getRecentList({required String? type})  {
    String? recent = '';
    String key = type == AppConstants.sendMoney ?
      AppConstants.sendMoneySuggestList : type == AppConstants.cashOut ?
      AppConstants.recentAgentList : AppConstants.requestMoneySuggestList;

    if(sharedPreferences.containsKey(key)){
      try {
        recent =  sharedPreferences.get(key) as String?;
      }catch(error) {
        recent = '';
      }
    }
    if(recent != null && recent != '' && recent != 'null'){
      return  contactModelFromJson(utf8.decode(base64Url.decode(recent.replaceAll(' ', '+'))));
    }
    return null;

  }

  void addToSuggestList(List<ContactModel> contactModelList,{required String type}) async {
    String suggests = base64Url.encode(utf8.encode(contactModelToJson(contactModelList)));
    if(type == 'send_money') {
     await sharedPreferences.setString(AppConstants.sendMoneySuggestList, suggests);
    }
    else if(type == 'request_money'){
     await sharedPreferences.setString(AppConstants.requestMoneySuggestList, suggests);
    }
    else if(type == "cash_out"){
     await sharedPreferences.setString(AppConstants.recentAgentList, suggests);
    }
  }

  Future<Response> getWithdrawMethods() async {
    return await apiClient.getData(AppConstants.withdrawMethodList);
  }

  Future<Response>  withdrawRequest({required Map<String, String?>? placeBody}) async {
    return await apiClient.postData(AppConstants.withdrawRequest, placeBody);
  }




}