import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyAssets extends StatefulWidget {
  const EmptyAssets({super.key});

  @override
  State<EmptyAssets> createState() => _EmptyAssetsState();
}

class _EmptyAssetsState extends State<EmptyAssets> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.asset('assets/images/empty.json'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '.شما خریدی انجام نداده اید',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'IR',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
