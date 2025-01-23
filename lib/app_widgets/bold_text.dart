
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';


class BoldText extends StatefulWidget {
  const BoldText({
    super.key,
    required this.Text,
    this.TextALign,
    this.maxLines,
    this.color,
    this.fontSize, this.height,
  });
  final String Text;
  final int? maxLines;
  final TextAlign? TextALign;
  final Color? color;
  final double? fontSize;
  final double? height;

  @override
  State<BoldText> createState() => _BoldTextState();
}

class _BoldTextState extends State<BoldText> {
  @override
  Widget build(BuildContext context) {
    return Text(

      widget.Text,
      style: TextStyle(
        height: widget.height,overflow: TextOverflow.ellipsis,
        fontSize: widget.fontSize??15,
        color: widget.color??AppColors.whiteColor,
        fontFamily: "bold",
      ),
      textAlign: widget.TextALign,
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,


    );
  }
}
