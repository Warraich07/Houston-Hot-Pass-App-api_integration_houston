import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PaymentButton extends StatefulWidget {
  const PaymentButton(
      {super.key,
      required this.buttonIcon,
      required this.buttonTitle,
      this.onTap,
      this.showAccountNumber,
      this.accountNumber, this.decoration, this.showRemoveText});
  final String buttonIcon;
  final String buttonTitle;
  final String? accountNumber;
  final Decoration? decoration;
  final bool? showAccountNumber;
  final bool? showRemoveText;
  final Function()? onTap;

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration:widget.decoration??BoxDecoration(color: AppColors.peachColor),
      width: 90.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            SizedBox(width: 25),
            Image.asset(widget.buttonIcon, scale: 3.5),
            SizedBox(width: 20),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoldText(Text: widget.buttonTitle, color: Colors.black),
                  widget.showAccountNumber == true
                      ? Text("•••• 1234",
                          style: TextStyle(
                              fontFamily: "regular",
                              color: Colors.black.withOpacity(0.7)),maxLines: 1,)
                      : SizedBox.shrink(),
                ],
              ),
            ),

            Spacer(),
            widget.showRemoveText==true?
            ZoomTapAnimation(
                child: Text("remove",style: TextStyle(fontFamily: 'montserrat-semibold',color: Colors.red,fontSize: 14),)):SizedBox.shrink(),
            SizedBox(width: 15,)
          ],
        ),
      ),
    );
  }
}
