import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,  // Number of grid items per row
            crossAxisSpacing: 10, // Spacing between grid items
            mainAxisSpacing: 10,  // Spacing between grid items
            childAspectRatio: 1,  // Aspect ratio of each grid item
          ),
          itemCount: 6,  // Number of shimmer items
          itemBuilder: (context, index) {
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
                      height: 80,
                      width: 80,
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
          },
        ),
      ),
    );
  }
}
