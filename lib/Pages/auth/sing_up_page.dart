import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food/Moudel/ssing_up_model.dart';
import 'package:food/Pages/base/custom_loading.dart';
import 'package:food/Pages/base/show_custom_masseg.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/Widgets/app_text_filed.dart';
import 'package:food/controllers/auth_controller.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:get/get.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameemailController = TextEditingController();
    var phoneController = TextEditingController();
    var singUpImage=[
      'Facebook.jpg',
      'google.png',
      'twiter.jfif',


    ];
    void _registratoin(AuthController authController){

      String name = nameemailController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if(name.isEmpty){
       showCustomSnackBar('Type in your Name ', title: 'Name ');
      }else if(phone.isEmpty){
        showCustomSnackBar('Type in your Phone Number ', title: 'Phone Number');
      }else if(email.isEmpty){
        showCustomSnackBar('Type in your Email ', title: 'Email');

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar('Type in a valid email address', title: 'Valid Email Address');

      }else if(password.isEmpty){
        showCustomSnackBar('Type in your Password ', title: 'Password');

      }else if(password.length<8){
        showCustomSnackBar('Password can not be less than 8 characters ', title: 'Password');

      }else{
        SingUpModel singUpModel = SingUpModel(name: name, phone: phone, email: email, password: password);
         authController.regestration(singUpModel).then((status){
           if( status.isSuccess){
             print("Success regestration");
           }else{
             showCustomSnackBar(status.message);
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
              AppTextFiled(

                  textController: emailController,
                  hintText: 'Email',
                  icon: Icons.email,
              ),
              SizedBox(
                height: Dimensions.Height15,
              ),
              AppTextFiled(
                  textController: passwordController,
                  hintText: 'Password',
                  icon: Icons.password,
              isObscure: true,),
              SizedBox(
                height: Dimensions.Height15,
              ),
              AppTextFiled(
                  textController: nameemailController,
                  hintText: 'Name',
                  icon: Icons.person),
              SizedBox(
                height: Dimensions.Height15,
              ),
              AppTextFiled(
                  textController: phoneController,
                  hintText: 'Phone',
                  icon: Icons.phone),
              SizedBox(
                height: Dimensions.Height30,
              ),
              GestureDetector(
                onTap: (){
                  _registratoin(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor),
                  child: Center(
                    child: BigText(
                      text: 'Sing up',
                      size: Dimensions.font20 + Dimensions.font20 / 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.Height10,
              ),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                      text: 'Have an account already?',
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20))),
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                      text: 'Sing up using one of the following methods ',
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20))),
              Wrap(
                children:
                List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(

                      'assets/'+singUpImage[index],

                    ),

                  ),
                )),

              )
            ],
          ),
        ): const CustomLoading();
      })
    );

  }
}
