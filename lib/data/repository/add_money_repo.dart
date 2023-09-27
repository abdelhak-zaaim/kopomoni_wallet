
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class AddMoneyRepo {
  final ApiClient apiClient;
  AddMoneyRepo({required this.apiClient});

  Future<Response>  addMoneyApi({required double amount, required String paymentMethod}) async {
    Map<String, Object> body = {
      'amount': '$amount',
      'payment_method': paymentMethod,
    };
    return await apiClient.postData(AppConstants.customerAddMoney,body);
  }



}