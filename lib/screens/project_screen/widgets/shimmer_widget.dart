import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProjectDashboardShimmer extends StatelessWidget {
  const ProjectDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            2,
            (index) => Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              height: 550,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      width: 400,
                      height: 220,
                    ),
                    Container(
                      height: 20,
                      width: double.infinity,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    ...List.generate(
                      4,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 15,
                              color: Colors.grey,
                            ),
                            Container(
                              width: 120,
                              height: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      color: Colors.grey,
                      margin: const EdgeInsets.only(top: 10),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
