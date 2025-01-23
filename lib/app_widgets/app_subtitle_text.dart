
import 'package:flutter/material.dart';

class AppSubtitleText extends StatefulWidget {
  const AppSubtitleText({
    super.key,
    required this.Text,
    this.TextALign,
    this.maxLines,
    this.fontSize,
    this.color, this.height, this.textOverflow, this.fontFamily, this.fontWeight,
  });
  final String Text;
  final String? fontFamily;
  final int? maxLines;
  final TextAlign? TextALign;
  final double? fontSize;
  final double? height;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  State<AppSubtitleText> createState() => _AppSubtitleTextState();
}

class _AppSubtitleTextState extends State<AppSubtitleText> {
  @override
  Widget build(BuildContext context) {
    return Text(

      widget.Text,
      style: TextStyle(height:widget.height, fontWeight:widget.fontWeight ,
        fontSize: widget.fontSize??15, fontFamily: widget.fontFamily??"medium", color: widget.color??Colors.black.withOpacity(0.5),),
      textAlign: widget.TextALign,overflow: TextOverflow.ellipsis,maxLines: widget.maxLines??3,




    );
  }
}
