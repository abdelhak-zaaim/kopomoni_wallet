import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/forget_password_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/appbar_stack_view.dart';
import 'package:six_cash/view/screens/forget_password/widget/pin_field_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ResetPasswordScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? otp;
  const ResetPasswordScreen({Key? key, this.phoneNumber, this.otp}) : super(key: key);

  @override
  State<ResetPasswordScreen>  createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Expanded(flex: 5, child: Container(color: Theme.of(context).primaryColor)),

            Expanded(flex: 5, child: Container(color: Theme.of(context).cardColor))
          ]),

          const Positioned(
            top: Dimensions.paddingSizeOverLarge,
            left: 0, right: 0,
            child: AppbarStackView(),
          ),

          Positioned(top: context.height * 0.18, left: 0, right: 0, bottom: 0, child: PinFieldView(
            newPassController: newPassController,
            confirmPassController: confirmPassController,
          )),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 10),
        child:   FloatingActionButton(
           onPressed: () {
             Get.find<ForgetPassController>().resetPassword(
               newPassController,confirmPassController,
               widget.phoneNumber,
               widget.otp,
             );

          },
          elevation: 0,
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          child: GetBuilder<AuthController>(builder: (controller)=> !controller.isLoading ? Center(child: Icon(Icons.arrow_forward,color: ColorResources.blackColor,size: 28,)) : SizedBox(height: 20.33,
              width: 20.33,child: CircularProgressIndicator(color: Theme.of(context).textTheme.titleLarge!.color)),),),
        ) ,

      );
  }
}
