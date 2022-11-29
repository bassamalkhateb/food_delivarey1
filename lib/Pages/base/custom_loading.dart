import 'package:flutter/material.dart';
import 'package:food/controllers/auth_controller.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:get/get.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(' I`m printing loading state'+Get.find<AuthController>().isloading.toString());
    return Center(
      child: Container(
        height: Dimensions.Height20*5,
        width: Dimensions.Width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20*5/2),
          color: AppColors.mainColor,

        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
