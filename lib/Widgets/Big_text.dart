import 'package:flutter/material.dart';
import 'package:food/utiles/dimensioms.dart';

class BigText extends StatelessWidget {
     final String text ;
     Color ? color ;
     double size ;
     TextOverflow overflow ;
     BigText({Key? key, required this.text,
       this.color= const Color(0xff332b2b),
       this.overflow=TextOverflow.ellipsis,
       this.size=0
     }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size==0?Dimensions.font20:size,

      ),

    );
  }
}
