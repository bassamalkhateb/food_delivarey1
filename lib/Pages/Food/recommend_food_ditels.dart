import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/Widgets/App_Icon.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/controllers/popular_prodcut_controller.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:get/get.dart';

import '../../Widgets/exandbal_text.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class RecommendFoodditals extends StatelessWidget {
  final int pageId;
  final String page ;

  RecommendFoodditals({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.getInitial());
                      },
                      child: AppIcon(icon: Icons.clear)),
                  //AppIcon(icon: Icons.shopping_cart_outlined),
                  GetBuilder<PopularProductController>(builder: ((controller) {
                    return Stack(
                      children: [
                        GestureDetector(onTap: (){
                          if(controller.totaItems>=1)
                          Get.toNamed(RoutesHelper.getCartFood());
                        },child: AppIcon(icon: Icons.shopping_cart_outlined)),
                        Get.find<PopularProductController>().totaItems >= 1
                            ? Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: 20,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.transparent,
                          ),
                        )
                            : Container(),
                        Get.find<PopularProductController>().totaItems >= 1
                            ? Positioned(
                          right: 5,
                          top: 3,
                          child: BigText(
                            text:Get.find<PopularProductController>().totaItems.toString()  ,
                            size: 14,
                            color: Colors.white,

                          ),
                        )
                            : Container()
                      ],
                    );
                  }))
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                    child: BigText(
                      size: Dimensions.font26,
                      text: product.name!,
                    ),
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                ),
              ),
              backgroundColor: AppColors.yellowColor,
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL + "/uploads/" + product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: ExandbaleText(text: product.description!),
                    margin: EdgeInsets.only(
                        right: Dimensions.Width20, left: Dimensions.Width20),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      right: Dimensions.Width20 * 2.5,
                      left: Dimensions.Width20 * 2.5,
                      top: Dimensions.Height10,
                      bottom: Dimensions.Height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                            iconSize: Dimensions.icon15,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            icon: Icons.remove),
                      ),
                      BigText(
                        text:
                            '\$ ${product.price!}  X ${controller.cartItems.toString()} ',
                        color: AppColors.mainBlackColor,
                        size: Dimensions.font26,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                            iconSize: Dimensions.icon15,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            icon: Icons.add),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.Height20,
                              bottom: Dimensions.Height20,
                              left: Dimensions.Width20,
                              right: Dimensions.Width20),
                          child: BigText(
                            text: '\$ ${product.price!} | Add to Card',
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
