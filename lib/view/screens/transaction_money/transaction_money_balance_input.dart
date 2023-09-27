import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/controller/add_money_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/purpose_models.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/data/model/withdraw_model.dart';
import 'package:six_cash/helper/email_checker.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_loader.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/add_money/widget/digital_payment_view.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_confirmation.dart';
import 'package:six_cash/view/screens/transaction_money/widget/input_box_view.dart';
import 'package:six_cash/view/screens/transaction_money/widget/purpose_widget.dart';
import '../../../data/model/money_paper.dart';
import '../../../util/app_constants.dart';
import '../more/widget/money_paper_widget.dart';
import 'widget/field_item_view.dart';
import 'widget/for_person_widget.dart';
import 'widget/next_button.dart';

class TransactionMoneyBalanceInput extends StatefulWidget {
  final String? transactionType;
  final ContactModel? contactModel;
  final String? countryCode;

   const TransactionMoneyBalanceInput({Key? key, this.transactionType ,this.contactModel, this.countryCode}) : super(key: key);
  @override
  State<TransactionMoneyBalanceInput> createState() => _TransactionMoneyBalanceInputState();
}

class _TransactionMoneyBalanceInputState extends State<TransactionMoneyBalanceInput> {
  final TextEditingController _inputAmountController = TextEditingController();
  String? _selectedMethodId;
  List<MethodField>? _fieldList;
  List<MethodField>? _gridFieldList;


  Map<String?, TextEditingController> _textControllers =  {};
  Map<String?, TextEditingController> _gridTextController =  {};
  final FocusNode _inputAmountFocusNode = FocusNode();

  void setFocus() {
    _inputAmountFocusNode.requestFocus();
    Get.back();
  }
   List<MoneyPaperModel> paperList =[MoneyPaperModel(image: "assets/image/sll10000.jpg", amount: 10000),MoneyPaperModel(image: "assets/image/sll5000.jpg", amount: 5000),MoneyPaperModel(image: "assets/image/sll2000.jpg", amount: 2000),MoneyPaperModel(image: "assets/image/sll20.png", amount: 20),MoneyPaperModel(image: "assets/image/sll5.jpg", amount: 5),MoneyPaperModel(image: "assets/image/sll1.jpg", amount: 1),];
  @override
  void initState() {

    super.initState();



    if(widget.transactionType == TransactionType.withdrawRequest) {
      Get.find<TransactionMoneyController>().getWithdrawMethods();
    }
    Get.find<AddMoneyController>().setPaymentMethod(null, isUpdate: false);
  }
 
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final SplashController splashController = Get.find<SplashController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: CustomAppbar(title: widget.transactionType!.tr),

          body: GetBuilder<TransactionMoneyController>(
              builder: (transactionMoneyController) {
                if(widget.transactionType == TransactionType.withdrawRequest &&
                    transactionMoneyController.withdrawModel == null) {
                  return CustomLoader(color: Theme.of(context).primaryColor);
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(widget.transactionType != TransactionType.addMoney &&
                          widget.transactionType != TransactionType.withdrawRequest)
                        ForPersonWidget(contactModel: widget.contactModel),


                      if(widget.transactionType == TransactionType.withdrawRequest)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeDefault,
                            horizontal: Dimensions.paddingSizeSmall,
                          ),
                          child: Column(children: [
                            Container(
                              height: context.height * 0.05,
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4)),
                              ),

                              child: DropdownButton<String>(
                                menuMaxHeight: Get.height * 0.5,
                                hint: Text(
                                  'please_select_a_method'.tr,
                                  style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                ),
                                value: _selectedMethodId,
                                items: transactionMoneyController.withdrawModel!.withdrawalMethods.map((withdraw) =>
                                    DropdownMenuItem<String>(
                                      value: withdraw.id.toString(),
                                      child: Text(
                                        withdraw.methodName ?? 'no method',
                                        style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    )
                                ).toList(),

                                onChanged: (id) {
                                  _selectedMethodId = id;
                                  _gridFieldList = [];
                                  _fieldList = [];

                                  transactionMoneyController.withdrawModel!.withdrawalMethods.firstWhere((method) =>
                                  method.id.toString() == id).methodFields.forEach((method) {
                                    _gridFieldList!.addIf(method.inputName!.contains('cvv') || method.inputType == 'date', method);
                                  });


                                  transactionMoneyController.withdrawModel!.withdrawalMethods.firstWhere((method) =>
                                  method.id.toString() == id).methodFields.forEach((method) {
                                    _fieldList!.addIf(!method.inputName!.contains('cvv') && method.inputType != 'date', method);
                                  });

                                  _textControllers = _textControllers =  {};
                                  _gridTextController = _gridTextController =  {};

                                  for (var method in _fieldList!) {
                                    _textControllers[method.inputName] = TextEditingController();
                                  }
                                  for (var method in _gridFieldList!) {
                                    _gridTextController[method.inputName] = TextEditingController();
                                  }

                                  transactionMoneyController.update();
                                },

                                isExpanded: true,
                                underline: const SizedBox(),
                              ),
                            ),

                            const SizedBox(height: Dimensions.paddingSizeDefault),

                            if(_fieldList != null && _fieldList!.isNotEmpty) ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _fieldList!.length,
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeExtraSmall, horizontal: 10,
                              ),

                              itemBuilder: (context, index) => FieldItemView(
                                methodField:_fieldList![index],
                                textControllers: _textControllers,
                              ),
                            ),

                            if(_gridFieldList != null && _gridFieldList!.isNotEmpty)

                              GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeExtraSmall, horizontal: 10,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: _gridFieldList!.length,

                                itemBuilder: (context, index) => FieldItemView(
                                  methodField: _gridFieldList![index],
                                  textControllers: _gridTextController,
                                ),
                              ),

                          ],),
                        ),

                      InputBoxView(
                        speakAmount:_speakAmount,
                        inputAmountController: _inputAmountController,
                        focusNode: _inputAmountFocusNode,
                        transactionType: widget.transactionType,
                      ),

                      GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1),
                        ),
                        itemCount: 6,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => MoneyPaperWidget(
                          selectedPaperMoney :_selectedPaperMoney,

                          index: index, item: paperList[index],
                        ),
                      ),


                      if(widget.transactionType == TransactionType.cashOut)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge,
                            vertical:Dimensions.paddingSizeDefault,
                          ),
                          child: Row( children: [
                            Text(
                              'save_future_cash_out'.tr,
                              style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                            ),
                            const Spacer(),

                            Padding(
                              padding: EdgeInsets.zero,
                              child: CupertinoSwitch(
                                value: transactionMoneyController.isFutureSave,
                                onChanged: transactionMoneyController.cupertinoSwitchOnChange,
                              ),
                            ),

                          ],),
                        ),


                      widget.transactionType == TransactionType.sendMoney
                          ? transactionMoneyController.purposeList == null
                          ? CustomLoader(color: Theme.of(context).primaryColor)
                          :  transactionMoneyController.purposeList!.isEmpty
                          ? const SizedBox()
                          : MediaQuery.of(context).viewInsets.bottom > 10
                          ?
                      Container(
                        color: Colors.white.withOpacity(0.92),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge,
                          vertical: Dimensions.paddingSizeSmall,
                        ),
                        child: Row(children: [
                          transactionMoneyController.purposeList!.isEmpty ?
                          Center(child: CircularProgressIndicator(
                            color: Theme.of(context).textTheme.titleLarge!.color,
                          )) : const SizedBox(),

                          const SizedBox(width: Dimensions.paddingSizeSmall),

                          Text('change_purpose'.tr, style: rubikRegular.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ))
                        ],),

                      ): const PurposeWidget() : const SizedBox(),

                      if(widget.transactionType == TransactionType.addMoney)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                          child: DigitalPaymentView(),
                        ),

                    ],
                  ),
                );
              }
          ),

          floatingActionButton: GetBuilder<TransactionMoneyController>(
              builder: (transactionMoneyController) {
                return  FloatingActionButton(

                  onPressed:() {
                    double amount;
                    if(_inputAmountController.text.isEmpty){
                      showCustomSnackBar('please_input_amount'.tr,isError: true);
                    }else{
                      String balance =  _inputAmountController.text;
                      if(balance.contains('${splashController.configModel!.currencySymbol}')) {
                        balance = balance.replaceAll('${splashController.configModel!.currencySymbol}', '');
                      }
                      if(balance.contains(',')){
                        balance = balance.replaceAll(',', '');
                      }
                      if(balance.contains(' ')){
                        balance = balance.replaceAll(' ', '');
                      }
                      amount = double.parse(balance);
                      if(amount <= 0) {
                        showCustomSnackBar('transaction_amount_must_be'.tr,isError: true);
                      }else {
                        bool inSufficientBalance = false;
                        bool isPaymentSelect = Get.find<AddMoneyController>().paymentMethod != null;

                        final bool isCheck = widget.transactionType != TransactionType.requestMoney
                            && widget.transactionType != TransactionType.addMoney;

                        if(isCheck && widget.transactionType == TransactionType.sendMoney) {
                          inSufficientBalance = PriceConverter.balanceWithCharge(amount, splashController.configModel!.sendMoneyChargeFlat, false) > profileController.userInfo!.balance!;
                        }else if(isCheck && widget.transactionType == TransactionType.cashOut) {
                          inSufficientBalance = PriceConverter.balanceWithCharge(amount, splashController.configModel!.cashOutChargePercent, true) > profileController.userInfo!.balance!;
                        }else if(isCheck && widget.transactionType == TransactionType.withdrawRequest) {
                          inSufficientBalance = PriceConverter.balanceWithCharge(amount, splashController.configModel!.withdrawChargePercent, true) > profileController.userInfo!.balance!;
                        }else if(isCheck){
                          inSufficientBalance = amount > profileController.userInfo!.balance!;
                        }


                        if(inSufficientBalance) {
                          showCustomSnackBar('insufficient_balance'.tr, isError: true);
                        }else if(widget.transactionType == TransactionType.addMoney && !isPaymentSelect){
                          showCustomSnackBar('please_select_a_payment'.tr, isError: true);
                        } else {
                         _confirmationRoute(amount);
                        }
                      }

                    }
                  },
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                  child: GetBuilder<AddMoneyController>(builder: (addMoneyController) {
                    return addMoneyController.isLoading ||
                        transactionMoneyController.isLoading
                        ? const CircularProgressIndicator()
                        : const NextButton(isSubmittable: true);
                  }),
                );
              }
          )

      ),
    );
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
  Future<void> speakNumber(int number) async {
    if(await getText2Speak()) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);

      await flutterTts.speak(number.toString());
    }
  }

  void _speakAmount(){
    int amount;
    if(_inputAmountController.text.isEmpty){
      speakNumber(0);
    }else{
      String balance =  _inputAmountController.text;
      if(balance.contains('SLL')) {
        balance = balance.replaceAll('SLL', '');
      }
      amount= double.parse(balance).round();
      speakNumber(amount);

    }


  }


void _selectedPaperMoney(int amount){
  int oldamount;
  if(_inputAmountController.text.isEmpty){
    _inputAmountController.text=amount.toString()+'SLL';
    speakNumber(amount);
  }else{
    String balance =  _inputAmountController.text;
    if(balance.contains('SLL')) {
      balance = balance.replaceAll('SLL', '');
    }
    oldamount = double.parse(balance).round();
    speakNumber((oldamount+amount));
    _inputAmountController.text=(oldamount+amount).toString()+'SLL';
  }


}
  void _confirmationRoute(double amount) {
    final transactionMoneyController = Get.find<TransactionMoneyController>();
    if(widget.transactionType == TransactionType.addMoney){
      Get.find<AddMoneyController>().addMoney(amount);
    }
    else if(widget.transactionType == TransactionType.withdrawRequest) {
      String? message;
      WithdrawalMethod? withdrawMethod = transactionMoneyController.withdrawModel!.withdrawalMethods.
      firstWhereOrNull((method) => _selectedMethodId == method.id.toString());


      List<MethodField> list = [];
      String? validationKey;

      if(withdrawMethod != null) {
        for (var method in withdrawMethod.methodFields) {
          if(method.inputType == 'email') {
            validationKey  = method.inputName;
          }
          if(method.inputType == 'date') {
            validationKey  = method.inputName;
          }

        }
      }else{
        message = 'please_select_a_method'.tr;
      }


      _textControllers.forEach((key, textController) {
        list.add(MethodField(
          inputName: key, inputType: null,
          inputValue: textController.text,
          placeHolder: null,
        ));

        if((validationKey == key) && EmailChecker.isNotValid(textController.text)) {
          message = 'please_provide_valid_email'.tr;
        }else if((validationKey == key) && textController.text.contains('-')) {
          message = 'please_provide_valid_date'.tr;
        }

        if(textController.text.isEmpty && message == null) {
          message = 'please fill ${key!.replaceAll('_', ' ')} field';
        }
      });

      _gridTextController.forEach((key, textController) {
        list.add(MethodField(
          inputName: key, inputType: null,
          inputValue: textController.text,
          placeHolder: null,
        ));

        if((validationKey == key) && textController.text.contains('-')) {
          message = 'please_provide_valid_date'.tr;
        }
      });

      if(message != null) {
        showCustomSnackBar(message);
        message = null;

      }
      else{


        Get.to(() => TransactionMoneyConfirmation(
          inputBalance: amount,
          transactionType: TransactionType.withdrawRequest,
          contactModel: null,
          withdrawMethod: WithdrawalMethod(
            methodFields: list,
            methodName: withdrawMethod!.methodName,
            id: withdrawMethod.id,
          ),
          callBack: setFocus,
        ));
      }

    }

    else{
      Get.to(()=> TransactionMoneyConfirmation(
        inputBalance: amount,
        transactionType:widget.transactionType,
        purpose:  widget.transactionType == TransactionType.sendMoney ?
        transactionMoneyController.purposeList != null && transactionMoneyController.purposeList!.isNotEmpty
            ? transactionMoneyController.purposeList![transactionMoneyController.selectedItem].title
            : Purpose().title
            : TransactionType.requestMoney.tr,

        contactModel: widget.contactModel,
        callBack: setFocus,

      ));
    }


  }
}




