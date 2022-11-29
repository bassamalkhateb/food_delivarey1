import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food/Pages/auth/sing_up_page.dart';
import 'package:food/Pages/base/custom_loading.dart';
import 'package:food/Pages/base/show_custom_masseg.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/Widgets/app_text_filed.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:get/get.dart';

import '../../Moudel/ssing_up_model.dart';
import '../../controllers/auth_controller.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController){


      String email = emailController.text.trim();
      String password = passwordController.text.trim();
       if(email.isEmpty){
        showCustomSnackBar('Type in your Email ', title: 'Email');

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar('Type in a valid email address', title: 'Valid Email Address');

      }else if(password.isEmpty){
        showCustomSnackBar('Type in your Password ', title: 'Password');

      }else if(password.length<8){
        showCustomSnackBar('Password can not be less than 8 characters ', title: 'Password');

      }else{

        authController.login(email,password).then((status){
          print(email);
          if( status.isSuccess){
            Get.toNamed(RoutesHelper.getInitial());
            print("Success login");
          }else{
            showCustomSnackBar(status.message);
            // print("Success login");
          }
        });
      }

    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
       return !authController.isloading?SingleChildScrollView(
         physics: BouncingScrollPhysics(),
         child: Column(
           children: [
             SizedBox(
               height: Dimensions.screenHeight * 0.06,
             ),
             Container(
               height: Dimensions.screenHeight * 0.25,
               child: Center(
                 child: CircleAvatar(
                   radius: 80,
                   backgroundColor: Colors.white,
                   backgroundImage: AssetImage("assets/splash.png"),
                 ),
               ),
             ),
             Container(
               margin: EdgeInsets.only(left: Dimensions.Width20),
               width: double.maxFinite,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Hello',
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2),
                   ),
                   SizedBox(height: Dimensions.Height10/6,),
                   Text(
                     'sing into your account',
                     style: TextStyle(
                         fontSize: Dimensions.font20 ,
                         color: Colors.grey[500]),
                   )
                 ],
               ),
             ),
             SizedBox(height: Dimensions.Height20,),
             AppTextFiled(
                 textController: emailController,
                 hintText: 'Email',
                 icon: Icons.email),
             SizedBox(
               height: Dimensions.Height15,
             ),
             AppTextFiled(
               textController: passwordController,
               hintText: 'Password',
               icon: Icons.password,
               isObscure: true,),
             SizedBox(
               height: Dimensions.Height15+Dimensions.Height10,
             ),
             Row(

               //mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Expanded(child: Container()),
                 RichText(
                     text: TextSpan(
                         text: 'Sing in to your account ',
                         style: TextStyle(
                             color: Colors.grey[500],
                             fontSize: Dimensions.font20))),
                 SizedBox(width: Dimensions.Width20,)
               ],
             ),
             SizedBox(
               height: Dimensions.screenHeight * 0.05,
             ),
             GestureDetector(
               onTap: (){
                 _login(authController);
               },
               child: Container(
                 width: Dimensions.screenWidth / 2,
                 height: Dimensions.screenHeight / 13,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(Dimensions.radius30),
                     color: AppColors.mainColor),
                 child: Center(
                   child: BigText(
                     text: 'Sing in',
                     size: Dimensions.font20 + Dimensions.font20 / 2,
                     color: Colors.white,
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: Dimensions.Height45+Dimensions.Height45,
             ),
             RichText(
               text: TextSpan(
                   text: 'Don`t have an account? ',
                   style: TextStyle(
                       color: Colors.grey[500], fontSize: Dimensions.font20),
                   children: [
                     TextSpan(
                       recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SingUpPage(),transition: Transition.fadeIn),
                       text: 'Create',
                       style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: Colors.black, fontSize: Dimensions.font20+3),
                     ),
                   ]),
             ),
           ],
         ),
       ):CustomLoading();
      })
    );
  }
}
