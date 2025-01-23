import 'package:disclosure/disclosure.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';

class CustomExpandableTile extends StatefulWidget {
  const CustomExpandableTile({super.key, required this.questionTitle,this.answer});
  final String questionTitle;
  final String? answer;

  @override
  State<CustomExpandableTile> createState() => _CustomExpandableTileState();
}

class _CustomExpandableTileState extends State<CustomExpandableTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 8),
      child: Container(
        decoration: customShadowedDecoration(buttonColor: AppColors.whiteColor),
        width: 90.w,
        child: Disclosure(

          wrapper: (state, child) {
            return Card.filled(
              elevation: 0,
              color: Colors.white,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(

                side: BorderSide(color: AppColors.primaryColor, width: 90.w),
              ),
              child: child,
            );
          },
          header: SizedBox(
            height: 53,
            child: DisclosureButton(
              child: ListTile(
                title: Text(
                  widget.questionTitle,
                  style: TextStyle(
                      fontFamily: "medium", fontSize: 14, height: 1.1),
                ),
                trailing: DisclosureIcon(),
              ),
            ),
          ),
          divider: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Divider(height: 0,color: AppColors.primaryColor,),
          ),
          child: DisclosureView(
            maxHeight: 150,
            padding: EdgeInsets.all(20.0),
            child: Text(
              widget.answer??"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.",
              style: TextStyle(fontFamily: "medium", fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
