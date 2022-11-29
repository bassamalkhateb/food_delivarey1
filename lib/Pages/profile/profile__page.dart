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
        centerTitle: true,
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
            //profile Icon
            AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize:Dimensions.Height45+Dimensions.Height30,
              size: Dimensions.Height15*10,
            ),
            SizedBox(
              height: Dimensions.Height15*2,
            ),
           Expanded(
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   //name
                   ProfileWidget(
                     bigText: BigText(text: "Bassam",),
                     appIcon: AppIcon(
                       icon: Icons.person,
                       backgroundColor: AppColors.mainColor,
                       iconColor: Colors.white,
                       iconSize:Dimensions.Height10*5/2,
                       size: Dimensions.Height10*5,
                     ),),
                   SizedBox(
                     height: Dimensions.Height15*2,
                   ),
                   //phone
                   ProfileWidget(
                     bigText: BigText(text: "0940-250-875",),
                     appIcon: AppIcon(
                       icon: Icons.phone,
                       backgroundColor: AppColors.yellowColor,
                       iconColor: Colors.white,
                       iconSize:Dimensions.Height10*5/2,
                       size: Dimensions.Height10*5,
                     ),),
                   SizedBox(
                     height: Dimensions.Height15*2,
                   ),
                   //email
                   ProfileWidget(
                     bigText: BigText(text: "salahwaled368@gmail.com",),
                     appIcon: AppIcon(
                       icon: Icons.email_outlined,
                       backgroundColor: AppColors.paraColor,
                       iconColor: Colors.white,
                       iconSize:Dimensions.Height10*5/2,
                       size: Dimensions.Height10*5,
                     ),),
                   SizedBox(
                     height: Dimensions.Height15*2,
                   ),
                   //address
                   ProfileWidget(
                     bigText: BigText(text: "Damascuse",),
                     appIcon: AppIcon(
                       icon: Icons.location_on,
                       backgroundColor: Colors.blueGrey,
                       iconColor: Colors.white,
                       iconSize:Dimensions.Height10*5/2,
                       size: Dimensions.Height10*5,
                     ),),
                   SizedBox(
                     height: Dimensions.Height15*2,
                   ),
                   //message
                   ProfileWidget(
                     bigText: BigText(text: "Hi evreone visited my profile",),
                     appIcon: AppIcon(
                       icon: Icons.message_outlined,
                       backgroundColor: Colors.redAccent,
                       iconColor: Colors.white,
                       iconSize:Dimensions.Height10*5/2,
                       size: Dimensions.Height10*5,
                     ),),
                   SizedBox(
                     height: Dimensions.Height15*2,
                   ),
                 ],
               ),
             ),
           )

          ],
        ),
      ),
    );
  }
}
