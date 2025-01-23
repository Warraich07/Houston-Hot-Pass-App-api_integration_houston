import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';

class CustomScreenTitle extends StatefulWidget {
   CustomScreenTitle({super.key, required this.screenTitle,this.showLeading,this.onTap});
  final String screenTitle;
  final bool? showLeading;
  void Function()? onTap;
  @override
  State<CustomScreenTitle> createState() => _CustomScreenTitleState();
}

class _CustomScreenTitleState extends State<CustomScreenTitle> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0,bottom: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [

           widget.showLeading==false?Container(): GestureDetector(
              onTap: widget.onTap??() {
    Get.back();
    },
              child:  Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Icon(
                    Icons.arrow_back,color: Colors.white,
                    size: 25,


                  )),
            ),
        SizedBox(width: 10),

        BoldText(Text: widget.screenTitle,fontSize: 20,color: Colors.white),

          ],
        ),
      ),
    );
  }
}
