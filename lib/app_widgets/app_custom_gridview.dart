import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final int? itemCount;
  final int? crossAxisCount;
  final double?childAspectRatio;
  final double? mainAxisSpacing;
  final double?crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
   Widget? Function(BuildContext, int) itemBuilder;


   CustomGridView({
    Key? key,
    this.itemCount,
    this.childAspectRatio,
    this.padding,
    required this.itemBuilder,
    this.physics,this.crossAxisCount, this.mainAxisSpacing, this.crossAxisSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        
        childAspectRatio: childAspectRatio??4/4.9,crossAxisCount: crossAxisCount??2,
        mainAxisSpacing: mainAxisSpacing??1,
        crossAxisSpacing: crossAxisSpacing??10,

      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      padding: EdgeInsets.all(0),
      physics: physics,
      shrinkWrap: true,


    );
  }
}
