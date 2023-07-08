import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';
class OnBoardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnBoardingWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
          alignment: Alignment.center,
          allowDrawingOutsideViewBox: true,
          width: 350.0,
        ),
        const SizedBox(height: 20,) ,
        Text(
         title,
          style: kBoldTextStyle,
        ),
        const SizedBox(height: 10,),
        Text(
          description,
          style: kSimpleText,

        ),


      ],
    );
  }
}
