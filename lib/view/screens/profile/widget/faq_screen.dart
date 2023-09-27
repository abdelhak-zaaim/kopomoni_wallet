import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/faq_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/screens/profile/widget/shimmer/faq_shimmer.dart';

class FaqScreen extends StatefulWidget {
  final String title;
  const FaqScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();

}

class _FaqScreenState extends State<FaqScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    Get.find<FaqController>().getFaqList();
    return Scaffold(
      appBar: CustomAppbar(title: widget.title),
      body: GetBuilder<FaqController>(builder: (faqController) {
        return faqController.isLoading ? const FaqShimmer() :
             ListView.builder(
            itemCount: faqController.helpTopics!.length,
            itemBuilder: (ctx, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpansionTile(
                    iconColor: Theme.of(context).primaryColor,
                    title: Text(faqController.helpTopics![index].question!,
                        style: rubikRegular.copyWith(
                            color: ColorResources.getTextColor())),
                    leading: Icon(Icons.collections_bookmark_outlined,
                        color: ColorResources.getTextColor()),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(faqController.helpTopics![index].answer!,
                            style: rubikLight,
                            textAlign: TextAlign.justify),
                      )
                    ],
                  ),
                ],
              );
            });
      }),
    );
  }
}
