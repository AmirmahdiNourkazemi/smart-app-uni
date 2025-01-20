import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliverAppBarShimmer extends StatelessWidget {
  const SliverAppBarShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.grey[300],
      flexibleSpace: FlexibleSpaceBar(
        background: Shimmer.fromColors(
          direction: ShimmerDirection.rtl,
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey[400],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 20,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 100,
                          height: 20,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
