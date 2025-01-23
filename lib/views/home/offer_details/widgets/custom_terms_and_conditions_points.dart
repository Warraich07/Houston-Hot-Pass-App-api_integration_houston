import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class CustomTermsAndConditionsPoints extends StatefulWidget {
  const CustomTermsAndConditionsPoints({super.key, required this.text});
  final String text;
  @override
  State<CustomTermsAndConditionsPoints> createState() => _CustomTermsAndConditionsPointsState();
}

class _CustomTermsAndConditionsPointsState extends State<CustomTermsAndConditionsPoints> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0,left: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
           margin: EdgeInsets.only(top: 8),
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(45))),
          SizedBox(width: 15,),

          Expanded(
            child: HtmlWidget(
              widget.text,
              textStyle: const TextStyle(
                fontSize: 15, fontFamily: 'regular',  color: Colors.black,),
              // overflow: TextOverflow.ellipsis,maxLines: 3,
            ),
          ),
        ],
      ),
    );

  }
}
