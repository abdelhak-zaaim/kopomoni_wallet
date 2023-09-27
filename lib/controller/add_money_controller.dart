import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/agent_model.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/data/repository/add_money_repo.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/screens/add_money/web_screen.dart';

import '../data/model/money_paper.dart';

class AddMoneyController extends GetxController implements GetxService {
  final AddMoneyRepo addMoneyRepo;
  AddMoneyController({required this.addMoneyRepo});

  List<AgentModel>? _agentList;
 bool  _isLoading = false;
  List<String> filterdBankList= [];
  String? _selectedBank;
  ContactModel? _contact;
  String? _addMoneyWebLink;
  List<AgentModel>? get agentList => _agentList;
  bool get isLoading => _isLoading;
  ContactModel? get contact => _contact;
  String? get selectedBank => _selectedBank;
  String? get addMoneyWebLink => _addMoneyWebLink;

  String? _paymentMethod;
  String? get paymentMethod => _paymentMethod;




  Future<void> addMoney(double amount) async{
    _isLoading = true;
    update();
    Response response = await addMoneyRepo.addMoneyApi(amount : amount, paymentMethod: _paymentMethod!);
    if(response.statusCode == 200){
     _addMoneyWebLink =  response.body['link'];
     if(_addMoneyWebLink != null){
       Get.to(WebScreen(selectedUrl: _addMoneyWebLink!, isPaymentUrl: true));
     }
    }else{
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();


  }

  Future<bool?> getBackScreen()async{
    Get.offAndToNamed(RouteHelper.navbar, arguments: false);
    return null;
  }

  void setPaymentMethod(String? method, {isUpdate = true}) {
    _paymentMethod = method;
   if(isUpdate){
     update();
   }
  }

}