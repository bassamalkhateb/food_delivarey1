import 'package:flutter/material.dart';
import 'package:food/Pages/base/custom_loading.dart';
import 'package:food/Widgets/App_Icon.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/Widgets/profile_widget.dart';
import 'package:food/controllers/auth_controller.dart';
import 'package:food/controllers/cart_controller.dart';
import 'package:food/controllers/location_controller.dart';
import 'package:food/controllers/user_controller.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInFo();
    }
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
        body: GetBuilder<UserController>(builder: (userControoler) {
          return _userLoggedIn ? (userControoler.isloading ? Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.Height20),
            child: Column(
              children: [
                //profile Icon
                AppIcon(
                  icon: Icons.person,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.Height45 + Dimensions.Height30,
                  size: Dimensions.Height15 * 10,
                ),
                SizedBox(
                  height: Dimensions.Height15 * 2,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //name
                        ProfileWidget(
                          bigText: BigText(text: userControoler.userModel!.name,),
                          appIcon: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.Height10 * 5 / 2,
                            size: Dimensions.Height10 * 5,
                          ),),
                        SizedBox(
                          height: Dimensions.Height15 * 2,
                        ),
                        //phone
                        ProfileWidget(
                          bigText: BigText(text: userControoler.userModel!.phone,),
                          appIcon: AppIcon(
                            icon: Icons.phone,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.Height10 * 5 / 2,
                            size: Dimensions.Height10 * 5,
                          ),),
                        SizedBox(
                          height: Dimensions.Height15 * 2,
                        ),
                        //email
                        ProfileWidget(
                          bigText: BigText(text: userControoler.userModel!.email,),
                          appIcon: AppIcon(
                            icon: Icons.email_outlined,
                            backgroundColor: AppColors.paraColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.Height10 * 5 / 2,
                            size: Dimensions.Height10 * 5,
                          ),),
                        SizedBox(
                          height: Dimensions.Height15 * 2,
                        ),
                        //address
                        GetBuilder<LocationController>(builder: (controller){
                          if(_userLoggedIn&&controller.addressList.isEmpty){
                            return GestureDetector(
                              onTap: (){
                                Get.offNamed(RoutesHelper.getAddressPage());
                              },
                              child: ProfileWidget(
                              bigText: BigText(text:'Fill Address' ,),
                              appIcon: AppIcon(
                                icon: Icons.location_on,
                                backgroundColor: Colors.blueGrey,
                                iconColor: Colors.white,
                                iconSize: Dimensions.Height10 * 5 / 2,
                                size: Dimensions.Height10 * 5,
                              ),));
                          }else{
                            return GestureDetector(
                                onTap: (){
                                  Get.offNamed(RoutesHelper.getAddressPage());
                                },
                                child: ProfileWidget(
                                  bigText: BigText(text:'Your address' ,),
                                  appIcon: AppIcon(
                                    icon: Icons.location_on,
                                    backgroundColor: Colors.blueGrey,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.Height10 * 5 / 2,
                                    size: Dimensions.Height10 * 5,
                                  ),));
                          }

                        }),
                        SizedBox(
                          height: Dimensions.Height15 * 2,
                        ),
                        //message
                        ProfileWidget(
                          bigText: BigText(text: "Message",),
                          appIcon: AppIcon(
                            icon: Icons.message_outlined,
                            backgroundColor: Colors.brown,
                            iconColor: Colors.white,
                            iconSize: Dimensions.Height10 * 5 / 2,
                            size: Dimensions.Height10 * 5,
                          ),),
                        SizedBox(
                          height: Dimensions.Height15 * 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              Get.find<AuthController>().ClearSharedData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.find<LocationController>().clearAddressList();
                              Get.offNamed(RoutesHelper.getSingInPage());
                            } else {
                              Get.offNamed(RoutesHelper.getSingInPage());
                            }
                          },
                          child: ProfileWidget(
                            bigText: BigText(text: "Logout",),
                            appIcon: AppIcon(
                              icon: Icons.logout,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.Height10 * 5 / 2,
                              size: Dimensions.Height10 * 5,
                            ),),
                        ),
                        SizedBox(
                          height: Dimensions.Height15 * 2,
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ) : CustomLoading()) : Container(
            child: Center(child: Text('You must Login'),),);
        })
    );
  }
}
