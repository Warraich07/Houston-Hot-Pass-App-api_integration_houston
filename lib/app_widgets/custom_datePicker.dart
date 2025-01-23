import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

class DatePicker extends StatefulWidget {
  DateTime? selectedDate = DateTime.now();
  DateTime startDateTime = DateTime.now();

  final String text;

  DatePicker({super.key, required this.text, required this.selectedDate});

  @override
  State<DatePicker> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<DatePicker> {
  // DateTime startDateTime= DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startDateTime = widget.selectedDate!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 90.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        border: Border.all(color: AppColors.whiteColor),borderRadius: BorderRadius.circular(4)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedDate == null
                      ? widget.text
                      : DateFormat.yMMMd().format(widget.selectedDate!),
                  style: TextStyle(
                    fontSize: 17,
                      fontFamily: "Inter-light",
                      color: widget.selectedDate == null
                          ? Colors.grey
                          :  Colors.white.withOpacity(0.50)
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
