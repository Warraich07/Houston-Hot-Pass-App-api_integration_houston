import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class ShimmerSingleWidget extends StatelessWidget {
   ShimmerSingleWidget({super.key,required this.shimmerWidth});
double? shimmerWidth;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: shimmerWidth,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Container(
              height: 15,
              width: 60,
              color: Colors.white,
            ),
            SizedBox(height: 5),
            Container(
              height: 15,
              width: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
