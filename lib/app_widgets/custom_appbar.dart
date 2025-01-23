import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomAppBarr extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarr({
    super.key,
    this.title,
    this.action, this.backGroundColor,
  });
  final String? title;
  final Widget? action;
  final Color?backGroundColor;


  @override
  State<CustomAppBarr> createState() => _CustomAppBarrState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _CustomAppBarrState extends State<CustomAppBarr> {
  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: widget.backGroundColor??Colors.white,scrolledUnderElevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child:  Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              Icons.arrow_back,color: Colors.black,
              size: 30,


            )),
      ),
      actions: [widget.action ?? const SizedBox.shrink(


      )],
      titleSpacing: 2,

      title: Text(widget.title.toString(),
        style: const TextStyle(color: Colors.black,
          fontSize: 20,
          fontFamily: "bold",

        ),
      ),

    );

  }
}
