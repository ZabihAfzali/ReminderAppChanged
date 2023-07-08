import 'package:flutter/material.dart';
class DotsIndicator extends StatelessWidget {
  final bool isActive;
  final Color color;
  const DotsIndicator({Key? key,
    this.isActive=false,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange,
      ),
    );
  }
}
