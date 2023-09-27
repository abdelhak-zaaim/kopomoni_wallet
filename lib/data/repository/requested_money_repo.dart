import 'package:get/get_connect/http/src/response/response.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class RequestedMoneyRepo{
  final ApiClient apiClient;

  RequestedMoneyRepo({required this.apiClient});

  Future<Response> getRequestedMoneyList() async {
    return await apiClient.getData(AppConstants.requestedMoneyUri);
  }
  Future<Response> getOwnRequestedMoneyList() async {
    return await apiClient.getData(AppConstants.wonRequestedMoney);
  }
  Future<Response> approveRequestedMoney(int? id, String pin) async {
    return await apiClient.postData(AppConstants.acceptedRequestedMoneyUri,{"id": id, "pin" :pin});
  }
  Future<Response> denyRequestedMoney(int? id, String pin) async {
    return await apiClient.postData(AppConstants.deniedRequestedMoneyUri,{"id": id, "pin" :pin});
  }
  Future<Response> getWithdrawRequest() async {
    return await apiClient.getData(AppConstants.getWithdrawalRequest);
  }
}