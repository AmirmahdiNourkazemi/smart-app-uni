import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
 final Widget child;
  const InfoContainer({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
decoration: BoxDecoration(

          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12))
          ,
          child: child

    );
  }
}