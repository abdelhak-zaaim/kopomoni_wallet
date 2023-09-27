import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
class EditCustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hint;
  final String? levelText;
  const EditCustomTextField({Key? key,this.controller,this.textInputType,this.hint,this.levelText}) : super(key: key);

  @override
  State<EditCustomTextField> createState() => _EditCustomTextFieldState();
}

class _EditCustomTextFieldState extends State<EditCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
          child: Text(widget.levelText!,
          style: rubikMedium.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
          ),),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeSmall,
        ),
        TextField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          textCapitalization: TextCapitalization.words,
          cursorColor: Theme.of(context).primaryColor,
          style: rubikRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            // letterSpacing: 1.0,
          ),
          decoration: InputDecoration(

            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
              borderSide: BorderSide(
                color: Theme.of(context).textTheme.titleLarge!.color!,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
              borderSide: BorderSide(
                color: ColorResources.textFieldBorderColor,
                width: 1,
              ),
            ),
            hintText: widget.hint,
            hintStyle: rubikRegular.copyWith(
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
