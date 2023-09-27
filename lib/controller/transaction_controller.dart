import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/bootom_slider_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/az_model.dart';
import 'package:six_cash/data/model/purpose_models.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/data/model/withdraw_model.dart';
import 'package:six_cash/data/repository/auth_repo.dart';
import 'package:six_cash/data/repository/transaction_repo.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/base/logout_dialog.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_confirmation.dart';

class TransactionMoneyController extends GetxController implements GetxService {
  final TransactionRepo transactionRepo;
  final AuthRepo authRepo;

  TransactionMoneyController({required this.transactionRepo, required this.authRepo});
  BottomSliderController bottomSliderController = Get.find<BottomSliderController>();
  SplashController splashController = Get.find<SplashController>();
  ProfileController profileController = Get.find<ProfileController>();
  List<Contact> contactList = [];
  List<AzItem> filterdContacts = [];
  List<AzItem> azItemList = [];
  List<ContactModel> _sendMoneySuggestList = [];
  List<ContactModel> _requestMoneySuggestList = [];
  List<ContactModel> _cashOutSuggestList = [];

  List<Purpose>? _purposeList;
  Purpose? _selectedPurpose;
  int _selectItem = 0;
  final double _cashOutCharge = 0;

  bool _isLoading = false;
  bool purposeLoading = true;
  final bool _isOtpFieldLoading = false;
  final bool _isSuggestLoading = false;
  bool _isFutureSave = false;

  bool _isNextBottomSheet = false;
  bool _includeCharge = false;
  PermissionStatus? permissionStatus;
  final String _searchControllerValue = '';
  double? _inputAmountControllerValue;
  WithdrawModel? _withdrawModel;

  List<Purpose>? get purposeList => _purposeList;
  Purpose? get selectedPurpose => _selectedPurpose;
  int get selectedItem => _selectItem;
  String get searchControllerValue => _searchControllerValue;
  double? get inputAmountControllerValue => _inputAmountControllerValue;

  bool get isLoading => _isLoading;
  bool get  isOtpFieldLoading => _isOtpFieldLoading;
  bool get isSuggestLoading => _isSuggestLoading;

  bool get isNextBottomSheet => _isNextBottomSheet;
  bool get includeCharge => _includeCharge;
  double get cashOutCharge => _cashOutCharge;
  List<ContactModel> get sendMoneySuggestList => _sendMoneySuggestList;
  List<ContactModel> get requestMoneySuggestList => _requestMoneySuggestList;
  List<ContactModel> get cashOutSuggestList => _cashOutSuggestList;
  bool get isFutureSave => _isFutureSave;
  bool _isPinCompleted = false;
  bool get isPinCompleted => _isPinCompleted;
  String? _pin;
  String? get pin => _pin;
  bool _contactIsLoading = false;
  bool get contactIsLoading => _contactIsLoading;
  bool _isButtonClick = false;
  bool get isButtonClick => _isButtonClick;
  WithdrawModel? get withdrawModel => _withdrawModel;
  bool get getContactPermissionStatus => authRepo.sharedPreferences.getString(AppConstants.contactPermission) != PermissionStatus.granted.name;



  cupertinoSwitchOnChange(bool value) {
    _isFutureSave = value;
    update();
  }

  void setIsPinCompleted({required bool isCompleted, required bool isNotify}){
    _isPinCompleted =  isCompleted;
    if(isNotify) {
      update();
    }
  }
  changePinCompleted(String value){
    if (value.length==4) {
      _isPinCompleted = true;
      _pin = value;
    }else{
      _isPinCompleted = false;
    }
    update();
  }


  Future<void> getPurposeList(bool reload, {bool isUpdate = true})async{
    if(_purposeList == null || reload){
      _purposeList = null;
      _isLoading = true;
      if(isUpdate){
        update();
      }
    }

    if(_purposeList == null){
      Response response = await transactionRepo.getPurposeListApi();

      if(response.body != null && response.statusCode == 200){
        _purposeList = [];
        var data =  response.body.map((a)=> Purpose.fromJson(a)).toList();
        for (var purpose in data) {
          _purposeList?.add( Purpose(title: purpose.title,logo: purpose.logo, color: purpose.color));
        }
        _selectedPurpose = _purposeList!.isEmpty ? Purpose() : _purposeList![0];
      }else{
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }

  }




  Future<void> fetchContact() async {
    _contactIsLoading = true;
    update();
    if(getContactPermissionStatus && !GetPlatform.isIOS){
      return Get.dialog(
        CustomDialog(
          description: '${AppConstants.appName} ${'use_the_information_you'.tr}',
          icon: Icons.question_mark,
          onTapFalse:() {
            _contactIsLoading = false;
            Get.back();
          } ,
          onTapTrueText: 'accept'.tr,
          onTapFalseText: 'denied'.tr,
          onTapTrue: () {
            Get.back();
            _contactData();
          } ,
          title: 'contact_permission'.tr,

        ),
        barrierDismissible: false,
      ).then((value) => _contactIsLoading = false);

    }else{

      await _contactData();
    }
    update();
  }

  Future<void> _contactData() async {
    List<Contact> contacts = [];
    permissionStatus = await Permission.contacts.request();
    authRepo.sharedPreferences.setString(AppConstants.contactPermission, permissionStatus!.name);
    if(permissionStatus == PermissionStatus.granted || GetPlatform.isIOS) {
      contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: false);
    }
    azItemList = [];
    for(int i= 0; i < contacts.length; i++){
      if(contacts[i].phones.isNotEmpty && contacts[i].displayName.isNotEmpty) {

        azItemList.add(AzItem(contact: contacts[i], tag: contacts[i].displayName[0].toUpperCase()));

      }
    }

    filterdContacts = azItemList;
    SuspensionUtil.setShowSuspensionStatus(azItemList);
    SuspensionUtil.setShowSuspensionStatus(filterdContacts);
    _contactIsLoading = false;
    update();

  }

  void searchContact({required String searchTerm}) {
    if (searchTerm.isNotEmpty) {
      filterdContacts = azItemList.where((element) {
        if (element.contact!.phones.isNotEmpty) {
          if(element.contact!.displayName.toLowerCase().contains(searchTerm)
              || element.contact!.phones.first.number.replaceAll('-', '').toLowerCase().contains(searchTerm)){
            return true;
          }else{
            return false;
          }
          
        }else{
          return false;
        }
      }).toList();
  
    }else{
      filterdContacts = azItemList;
    }
    update();
  }



  Future<Response> sendMoney({required ContactModel contactModel, required double amount, String? purpose, String? pinCode})async{
    _isLoading = true;
    _isNextBottomSheet = false;
    update();
   Response response = await transactionRepo.sendMoneyApi(phoneNumber: contactModel.phoneNumber, amount: amount, purpose: purpose, pin: pinCode);
   if(response.statusCode == 200){
     _isLoading = false;
     _isNextBottomSheet = true;

     _sendMoneySuggestList.removeWhere((element) => element.phoneNumber == contactModel.phoneNumber);
     _sendMoneySuggestList.add(contactModel) ;
     transactionRepo.addToSuggestList(_sendMoneySuggestList,type: 'send_money');
     speak('send_money_successful'.tr );

     update();
   }else{
     _isLoading = false;
     ApiChecker.checkApi(response);
   }
   update();
   return response;
  }

  Future<Response> requestMoney({required ContactModel contactModel, required double amount})async{
    _isLoading = true;
    _isNextBottomSheet = false;
    update();
    Response response = await transactionRepo.requestMoneyApi(phoneNumber: contactModel.phoneNumber, amount: amount);
    if(response.statusCode == 200){
      _isLoading = false;
      _isNextBottomSheet = true;

      _requestMoneySuggestList.removeWhere((element) => element.phoneNumber == contactModel.phoneNumber);
      _requestMoneySuggestList.add(contactModel) ;
      transactionRepo.addToSuggestList(_requestMoneySuggestList,type: 'request_money');

      speak('request_send_successful'.tr);

      update();
    }else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }
  Future<Response> cashOutMoney({required ContactModel contactModel, required double amount, String? pinCode})async{
    _isLoading = true;
    _isNextBottomSheet = false;
    update();
    Response response = await transactionRepo.cashOutApi(phoneNumber: contactModel.phoneNumber, amount: amount,pin: pinCode);
    if(response.statusCode == 200){
      _isLoading = false;
      _isNextBottomSheet = true;

      if(_isFutureSave == true){
        _cashOutSuggestList.removeWhere((element) => element.phoneNumber == contactModel.phoneNumber);
        _cashOutSuggestList.add(contactModel) ;
        transactionRepo.addToSuggestList(_cashOutSuggestList,type: 'cash_out');
      }
      speak('cash_out_successful'.tr);

      update();
    }else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }
  FlutterTts flutterTts = FlutterTts();
  Future<bool> getText2Speak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool myBool = prefs.getBool(AppConstants.text2speach) ?? true;
    return myBool;
  }
  Future<void> speak(String text) async {
    if(await getText2Speak()) {
      await flutterTts.setLanguage(
          "en-US"); // Replace with your desired language code
      await flutterTts.setPitch(0.8); // Adjust pitch if needed
      await flutterTts.speak(text);
    }
  }
  Future<Response?> checkCustomerNumber({required String phoneNumber})async{
    Response? response0;
    if(phoneNumber == Get.find<ProfileController>().userInfo!.phone) {
      //todo set message
      showCustomSnackBar('Please_enter_a_different_customer_number'.tr);

      speak('Please_enter_a_different_customer_number'.tr);

    }else {
      _isButtonClick = true;
      update();
      Response response = await transactionRepo.checkCustomerNumber(phoneNumber: phoneNumber);
      if(response.statusCode == 200){
        _isButtonClick = false;
      }else{
        _isButtonClick = false;
        ApiChecker.checkApi(response);
      }
      update();
      response0 =  response;
    }
    return response0;

  }

  Future<Response> checkAgentNumber({required String phoneNumber})async{
    _isButtonClick = true;
    update();
    Response response = await transactionRepo.checkAgentNumber(phoneNumber: phoneNumber);
    if(response.statusCode == 200){
      _isButtonClick = false;
    }else{
      _isButtonClick = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }


  void includeChargeStateChange(bool state){
    _includeCharge = state;
    update();
  }




  itemSelect({required int index}){
    _selectItem = index;
    _selectedPurpose = purposeList![index];

    update();
  }

  ContactModel? _contact;
  ContactModel? get contact => _contact;
  void setContactModel(ContactModel contactModel){
    _contact = contactModel;
  }

  void  contactOnTap(int index, String? transactionType){
    String phoneNumber = filterdContacts[index].contact!.phones.first.number.trim();
    if(phoneNumber.contains('-')){
      phoneNumber = phoneNumber.replaceAll('-', '');
    }
    if(!phoneNumber.contains('+')){
      //todo need check country code
      phoneNumber = (Get.find<AuthController>().getUserData()!.countryCode!+phoneNumber.substring(1).trim());
    }
    if(phoneNumber.contains(' ')){
      phoneNumber = phoneNumber.replaceAll(' ', '');
    }
    if(transactionType == "cash_out"){
      Get.find<TransactionMoneyController>().checkAgentNumber(phoneNumber: phoneNumber).then((value) {
        if(value.isOk){
          String? agentName = value.body['data']['name'];
          String? agentImage = value.body['data']['image'];

          Get.to(()=> TransactionMoneyBalanceInput(transactionType: transactionType,contactModel: ContactModel(phoneNumber: phoneNumber,name: agentName,avatarImage: agentImage)));
        }
      });
    }else{
      Get.find<TransactionMoneyController>().checkCustomerNumber(phoneNumber: phoneNumber).then((value) {
        if(value!.isOk){
          String? customerName = value.body['data']['name'];
          String? customerImage = value.body['data']['image'];
          Get.to(()=> TransactionMoneyBalanceInput(transactionType: transactionType,contactModel: ContactModel(phoneNumber: phoneNumber,name: customerName,avatarImage: customerImage)));
        }
      });
    }
  }

  void suggestOnTap(int index, String? transactionType){
    if(transactionType == 'send_money'){
      setContactModel(ContactModel(
          phoneNumber: _sendMoneySuggestList[index].phoneNumber,
          avatarImage: _sendMoneySuggestList[index].avatarImage,
          name: _sendMoneySuggestList[index].name
      ));
    }
    else if(transactionType == 'request_money'){
      setContactModel(ContactModel(
          phoneNumber: _requestMoneySuggestList[index].phoneNumber,
          avatarImage: _requestMoneySuggestList[index].avatarImage,
          name: _requestMoneySuggestList[index].name
      ));
    }
    else if(transactionType == 'cash_out'){
      setContactModel(ContactModel(
          phoneNumber: _cashOutSuggestList[index].phoneNumber,
          avatarImage: _cashOutSuggestList[index].avatarImage,
          name: _cashOutSuggestList[index].name
      ));
    }

    Get.to(()=>TransactionMoneyBalanceInput(transactionType: transactionType,contactModel: _contact));

    }

  void balanceConfirmationOnTap({double? amount, String? transactionType, String? purpose, ContactModel? contactModel}) {
    Get.to(()=> TransactionMoneyConfirmation(
        inputBalance: amount, transactionType: transactionType, purpose: purpose,contactModel: contactModel));
  }



  void getSuggestList({required String? type})async{
    _cashOutSuggestList = [];
    _sendMoneySuggestList = [];
    _requestMoneySuggestList = [];
    try{
      if(type == AppConstants.sendMoney) {
        _sendMoneySuggestList.addAll(transactionRepo.getRecentList(type: type)!);
      }else if(type == AppConstants.cashOut) {
        _cashOutSuggestList.addAll(transactionRepo.getRecentList(type: type)!);
      }else{
        _requestMoneySuggestList.addAll(transactionRepo.getRecentList(type: type)!);
      }

    }catch(error){
      _cashOutSuggestList = [];
      _sendMoneySuggestList = [];
      _requestMoneySuggestList = [];
    }

  }

  void changeTrueFalse(){
    _isNextBottomSheet = false;
  }

  Future<bool> pinVerify({required String pin})async{
    bool isVerify = false;
    _isLoading = true;
     update();
    final Response response =  await authRepo.pinVerifyApi(pin: pin);
    if(response.statusCode == 200){
      isVerify = true;
      _isLoading = false;
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return isVerify;
  }


  Future<bool?> getBackScreen()async{
    Get.offAndToNamed(RouteHelper.navbar, arguments: false);
    return null;
  }

  Future<void> getWithdrawMethods({bool isReload = false}) async{
    if(_withdrawModel == null || isReload) {
      Response response = await transactionRepo.getWithdrawMethods();

      if(response.body['response_code'] == 'default_200' && response.body['content'] != null) {
        _withdrawModel = WithdrawModel.fromJson(response.body);
      }else{
        _withdrawModel = WithdrawModel(withdrawalMethods: [],);
        ApiChecker.checkApi(response);
      }

    }


    update();
  }

  Future<void> withDrawRequest({Map<String, String?>? placeBody})async{
    _isLoading = true;

    Response response = await transactionRepo.withdrawRequest(placeBody: placeBody);

    if(response.statusCode == 200 && response.body['response_code'] == 'default_store_200'){

      Get.offAllNamed(RouteHelper.getNavBarRoute());
      showCustomSnackBar('request_send_successful'.tr, isError: false);
    }else{

      showCustomSnackBar(response.body['message'] ?? 'error', isError: true);
    }
    _isLoading = false;
    update();

  }


}