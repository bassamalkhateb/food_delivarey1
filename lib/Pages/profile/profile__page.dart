import 'package:flutter/material.dart';
import 'package:food/Widgets/App_Icon.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/Widgets/profile_widget.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "profile",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top : Dimensions.Height20),
        child: Column(
          children: [
            AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize:Dimensions.Height10,
              size: Dimensions.Height15*10,
            ),
            ProfileWidget(
              bigText: BigText(text: "Bassam",),
              appIcon: AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize:Dimensions.Height10*5/2,
              size: Dimensions.Height10*5,
            ),)
          ],
        ),
      ),
    );
  }
}
