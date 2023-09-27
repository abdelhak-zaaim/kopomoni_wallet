import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/data/model/response/requested_money_model.dart';
import 'package:six_cash/data/model/withdraw_histroy_model.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/no_data_screen.dart';
import 'package:six_cash/view/screens/requested_money/requested_money_list_screen.dart';
import 'package:six_cash/view/screens/requested_money/widget/requested_money_card.dart';

class RequestedMoneyScreen extends StatefulWidget {
  final ScrollController? scrollController;
  final bool? isHome;
  final RequestType? requestType;
  const RequestedMoneyScreen({Key? key, this.scrollController, this.isHome, this.requestType,}) : super(key: key);

  @override
  State<RequestedMoneyScreen> createState() => _RequestedMoneyScreenState();
}

class _RequestedMoneyScreenState extends State<RequestedMoneyScreen> {
  int offset = 1;


  @override
  void initState() {
    super.initState();

    widget.scrollController?.addListener(() {
      if(widget.requestType != RequestType.withdraw
          && widget.scrollController!.position.maxScrollExtent == widget.scrollController!.position.pixels
          && (widget.requestType == RequestType.sendRequest
              ? Get.find<RequestedMoneyController>().ownRequestList.length
              :  Get.find<RequestedMoneyController>().requestedMoneyList.length) != 0
          && !Get.find<RequestedMoneyController>().isLoading) {
        int? pageSize;
        pageSize = Get.find<RequestedMoneyController>().pageSize;

        if(offset < pageSize!) {
          offset++;
          Get.find<RequestedMoneyController>().showBottomLoader();
          if(widget.requestType == RequestType.sendRequest) {
            Get.find<RequestedMoneyController>().getOwnRequestedMoneyList(true);
          }else {
            Get.find<RequestedMoneyController>().getRequestedMoneyList(true);
          }

        }
      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<RequestedMoneyController>(builder: (requestMoneyController){
      List<RequestedMoney> reqList;
      late List<WithdrawHistory> withdrawHistoryList;
      reqList = widget.requestType == RequestType.sendRequest
          ? requestMoneyController.ownRequestList : requestMoneyController.requestedMoneyList;

      if (Get.find<RequestedMoneyController>().requestTypeIndex == 0) {
        if(widget.requestType == RequestType.withdraw) {
          withdrawHistoryList = requestMoneyController.pendingWithdraw;
        }else{
          reqList = widget.requestType == RequestType.sendRequest
              ? requestMoneyController.ownPendingRequestedMoneyList : requestMoneyController.pendingRequestedMoneyList;
        }

      } else if (Get.find<RequestedMoneyController>().requestTypeIndex == 1) {
        if(widget.requestType == RequestType.withdraw) {
          withdrawHistoryList = requestMoneyController.acceptedWithdraw;
        }else{
          reqList = widget.requestType == RequestType.sendRequest
              ? requestMoneyController.ownAcceptedRequestedMoneyList : requestMoneyController.acceptedRequestedMoneyList;
        }


      }  else if (Get.find<RequestedMoneyController>().requestTypeIndex == 2) {
        if(widget.requestType == RequestType.withdraw) {
          withdrawHistoryList = requestMoneyController.deniedWithdraw;
        }else{
          reqList = widget.requestType == RequestType.sendRequest
              ? requestMoneyController.ownDeniedRequestedMoneyList :  requestMoneyController.deniedRequestedMoneyList;
        }


      }else{
        if(widget.requestType == RequestType.withdraw) {
          withdrawHistoryList = requestMoneyController.allWithdraw;
        }else{
          reqList = widget.requestType == RequestType.sendRequest
              ? requestMoneyController.ownRequestList :  requestMoneyController.requestedMoneyList;
        }

      }
      return requestMoneyController.isLoading ?  RequestedMoneyShimmer(isHome: widget.isHome) : Column(children: [

        // RequestedMoneyShimmer(isHome: widget.isHome)

        !requestMoneyController.isLoading ? (widget.requestType == RequestType.withdraw
            ? withdrawHistoryList.isNotEmpty : reqList.isNotEmpty
        ) ? Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: ListView.builder(
              physics:  const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.isHome! ? 1 : widget.requestType == RequestType.withdraw
                  ? withdrawHistoryList.length : reqList.length,

              itemBuilder: (ctx,index){
                List<FieldItem>? itemList = [];
                if(widget.requestType == RequestType.withdraw) {
                  withdrawHistoryList[index].withdrawalMethodFields!.forEach((key, value) {
                    itemList.add(FieldItem(key, value));
                  });
                }

                return RequestedMoneyCard(
                  requestedMoney: widget.requestType != RequestType.withdraw ? reqList[index] : null,
                  isHome: widget.isHome,
                  requestType: widget.requestType,
                  withdrawHistory:  widget.requestType == RequestType.withdraw ? withdrawHistoryList[index] : null,
                  itemList: itemList,
                );
              }),
        ): const NoDataFoundScreen() : RequestedMoneyShimmer(isHome: widget.isHome),


      ]);
    });
  }
}

class RequestedMoneyShimmer extends StatelessWidget {
  final bool? isHome;
  const RequestedMoneyShimmer({Key? key, this.isHome}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:  const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: isHome!? 1 : 10,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          color: Theme.of(context).hintColor.withOpacity(0.15),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).shadowColor,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: Colors.white),
              subtitle: Container(height: 10, width: 50, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}