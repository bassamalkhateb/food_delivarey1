import 'package:flutter/material.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/utiles/dimensioms.dart';

import 'App_Icon.dart';

class ProfileWidget extends StatelessWidget {
  AppIcon appIcon ;
  BigText bigText;
  ProfileWidget({Key? key, required this.bigText,required this.appIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(


      padding: EdgeInsets.only(left: Dimensions.Width20,top: Dimensions.Width10 ,bottom: Dimensions.Width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.Width20,),

          bigText,
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,5),
            color: Colors.grey.withOpacity(0.2),
          )
        ]
      ),
    );
  }
}
