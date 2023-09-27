import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/model/response/config_model.dart';
import 'package:six_cash/data/model/response/user_info.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/no_data_screen.dart';


class TransactionLimitScreen extends StatefulWidget {
  final List<TransactionTableModel> transactionTableModelList;
  const TransactionLimitScreen({Key? key, required this.transactionTableModelList}) : super(key: key);

  @override
  State<TransactionLimitScreen> createState() => _TransactionLimitScreenState();
}

class _TransactionLimitScreenState extends State<TransactionLimitScreen> with TickerProviderStateMixin{

  TabController? tabController;
  final List<String> tabItem = ['daily_limit', 'monthly_limit'];

  @override
  void initState() {
    tabController = TabController(length: tabItem.length, vsync: this);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final String languageText = AppConstants.languages[Get.find<LocalizationController>().selectedIndex].languageName!;

    return DefaultTabController(
      length: tabItem.length,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 90,
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: CustomInkWell(
              onTap: ()=> Get.back(),
              radius: Dimensions.radiusSizeSmall,
              child: Container(
                height: 40, width: 40,
                // padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.7), width: 0.5),
                  borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                ),
                child: const Center(
                  child: Icon(Icons.arrow_back_ios_new, size: Dimensions.paddingSizeSmall, color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).canvasColor,
              child: TabBar(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).primaryColor.withOpacity(0.5),
                controller: tabController,
                isScrollable: true,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeSmall,
                ),
                indicatorColor: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),


                tabs: tabItem.map((e) => Tab(text: e.tr, height: 20)).toList(),
              ),
            ),
          ),
          title: Text('transaction_limit'.tr),
          actions: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: InkWell(
                onTap: AppConstants.languages.length > 1 ? (){
                  Get.toNamed(RouteHelper.getChoseLanguageRoute());
                } : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraLarge),
                  ),
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  child: Text(languageText, style: rubikRegular.copyWith(color: Colors.black)),
                ),
              ),
            ),

          ],
        ),

        body: widget.transactionTableModelList.isNotEmpty ? Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: TabBarView(
              controller: tabController,
              children: [

                ListView.builder(
                  itemCount: widget.transactionTableModelList.length,
                  itemBuilder: (context, item) => Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: TransactionTableWidget(
                      tabIndex: 0,
                      tableModel: widget.transactionTableModelList[item],
                    ),
                  ),
                ),

                ListView.builder(
                  itemCount: widget.transactionTableModelList.length,
                  itemBuilder: (context, item) => Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: TransactionTableWidget(
                      tabIndex: 1,
                      tableModel: widget.transactionTableModelList[item],
                    ),
                  ),
                ),




              ]
          ),
        ) : const NoDataFoundScreen(),
      ),
    );
  }
}

class TransactionTableWidget extends StatelessWidget {
  final TransactionTableModel tableModel;
  final int tabIndex;

  const TransactionTableWidget({
    Key? key,
    required this.tableModel, required this.tabIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.1)),
        // boxShadow: [
        //   BoxShadow(blurRadius: 10, offset: Offset(0,0), color: Color(0xFF56C50D).withOpacity(0.05))
        // ],
        borderRadius: BorderRadius.circular(5),
      ),

      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Expanded(flex: 3, child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.1), width: 1)),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Image.asset(tableModel.image, width: Dimensions.paddingSizeExtraLarge),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                  Text(tableModel.title, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                ],
              ),

            )),

            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  TransactionItemView(
                    title: 'transaction'.tr,
                    timeCount: tabIndex == 0
                        ?  tableModel.transaction.dailyCount
                        : tableModel.transaction.monthlyCount,
                    subTitle: ' (${'max'.tr} ${tabIndex == 0
                        ? tableModel.customerLimit.transactionLimitPerDay
                        : tableModel.customerLimit.transactionLimitPerMonth} ${'times'.tr})',
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  TransactionItemView(
                    title: 'total_transaction'.tr,
                    amount: tabIndex == 0
                        ? tableModel.transaction.dailyAmount
                        : tableModel.transaction.monthlyAmount,
                    subTitle: ' (${'max'.tr} ${PriceConverter.convertPrice(tabIndex == 0
                        ? tableModel.customerLimit.totalTransactionAmountPerDay
                        : tableModel.customerLimit.totalTransactionAmountPerMonth)})',

                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  if(tabIndex == 0) TransactionItemView(
                    title: 'max_amount_per_transaction'.tr,
                    amount: tabIndex == 0
                        ? tableModel.customerLimit.maxAmountPerTransaction
                        : tableModel.customerLimit.maxAmountPerTransaction,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionItemView extends StatelessWidget {
  final String title;
  final int? timeCount;
  final double? amount;
  final String? subTitle;
  const TransactionItemView({
    Key? key, required this.title, this.timeCount, this.amount, this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Container(
        width: context.width,
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraSmall)
        ),
        child: Column(children: [
          Text(title, style: rubikRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7))),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                if(timeCount != null) TextSpan(
                  style: rubikMedium.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  text: '$timeCount',
                ),

                if(timeCount != null) TextSpan(
                  style: rubikRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.7),
                  ),
                  text: ' ${'times'.tr} ',
                ),

                if(amount != null) TextSpan(
                  style: rubikMedium.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  text: PriceConverter.convertPrice(amount!),
                ),

                if(subTitle != null) TextSpan(
                  style: rubikRegular.copyWith(color: timeCount != null ? Colors.greenAccent : Colors.amber),
                  text: subTitle,
                ),

              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class TransactionTableModel{
  final String title;
  final String image;
  final CustomerLimit customerLimit;
  final Transaction transaction;

  TransactionTableModel(this.title, this.image, this.customerLimit, this.transaction);

}