import 'package:flutter/material.dart';
import 'package:food/Widgets/App_Icon.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/Widgets/small_text.dart';
import 'package:food/controllers/cart_controller.dart';
import 'package:food/controllers/popular_prodcut_controller.dart';
import 'package:food/controllers/recommended_product_controller.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:get/get.dart';

import '../../routes/routeshelper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.Height20 * 3,
              left: Dimensions.Width20,
              right: Dimensions.Width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesHelper.getInitial());
                    },
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        iconSize: Dimensions.icon24,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.Width20 * 5,
                  ),
                  AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    iconSize: Dimensions.icon24,
                    backgroundColor: AppColors.mainColor,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    iconSize: Dimensions.icon24,
                    backgroundColor: AppColors.mainColor,
                  ),
                ],
              )),
          Positioned(
              bottom: 0,
              left: Dimensions.Width20,
              right: Dimensions.Width20,
              top: Dimensions.Height20 * 5,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.Height15),
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (controller) {
                        var _cartList = controller.getItems;
                        return ListView.builder(
                            itemCount: controller.getItems.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: Dimensions.Height20 * 5,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                        if(popularIndex>=0){
                                           Get.toNamed(RoutesHelper.getPopularFood(popularIndex,'cartpage'));
                                        }else{
                                          var recommendedIndex =Get.find<RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(
                                              _cartList[index].product!);
                                          Get.toNamed(RoutesHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.Height20 * 5,
                                        height: Dimensions.Height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.Height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      "/uploads/" +
                                                      controller.getItems[index]
                                                          .img!),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.Width10,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: Dimensions.Height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: controller
                                                .getItems[index].name!,
                                            color: Colors.black45,
                                          ),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    "\$ ${controller.getItems[index]!.price}",
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.Height10,
                                                    bottom: Dimensions.Height10,
                                                    left: Dimensions.Width10,
                                                    right: Dimensions.Width10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItem(
                                                            controller
                                                                .getItems[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.singColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          Dimensions.Width10 /
                                                              2,
                                                    ),
                                                    BigText(
                                                        text: controller
                                                            .getItems[index]
                                                            .quantity
                                                            .toString()),
                                                    SizedBox(
                                                      width:
                                                          Dimensions.Width10 /
                                                              2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItem(controller.getItems[index].product!, 1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.singColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                    )),
              ))
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (controller) {
            return Container(
              height: Dimensions.bottomHieghtBar,
              padding: EdgeInsets.only(
                  top: Dimensions.Height30,
                  bottom: Dimensions.Height30,
                  left: Dimensions.Width20,
                  right: Dimensions.Width20),
              decoration: BoxDecoration(
                  color: AppColors.bottonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.Height20,
                        bottom: Dimensions.Height20,
                        left: Dimensions.Width20,
                        right: Dimensions.Width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [

                        SizedBox(
                          width: Dimensions.Width10 / 2,
                        ),
                        BigText(text: '\$  '+controller.totalAmount.toString()),
                        SizedBox(
                          width: Dimensions.Width10 / 2,
                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.Height20,
                        bottom: Dimensions.Height20,
                        left: Dimensions.Width20,
                        right: Dimensions.Width20),
                    child: GestureDetector(
                      onTap: () {
                        //controller.addItem(product);

                        controller.addToHistory();

                      },
                      child: BigText(
                        text: "Check Out",
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                  )
                ],
              ),
            );
          },
        )
    );


  }
}
