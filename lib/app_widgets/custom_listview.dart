import 'package:flutter/material.dart';

class CustomListview extends StatelessWidget {
  const CustomListview({
    super.key,this.child, this.height,this.itemCount, required this.scrollDirection, this.physics, this.index, this.itemBuilder,
  });
  final Widget? child;
  final int? index;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final double?height;
  final int?itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(

      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          physics: physics,
          shrinkWrap: true,


          scrollDirection: scrollDirection,
            itemCount: itemCount,
            itemBuilder: itemBuilder??(context,index){
              return child;
            }),
      ),
    );

  }
}
