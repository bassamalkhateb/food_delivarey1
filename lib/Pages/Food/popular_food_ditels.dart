import 'package:flutter/material.dart';
import 'package:food/Pages/home/home_bage_food.dart';
import 'package:food/Widgets/App_Icon.dart';
import 'package:food/Widgets/App_column.dart';
import 'package:food/controllers/cart_controller.dart';
import 'package:food/controllers/popular_prodcut_controller.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:get/get.dart';

import '../../Widgets/Big_text.dart';
import '../../Widgets/exandbal_text.dart';
import '../../Widgets/icon_text_widget.dart';
import '../../Widgets/small_text.dart';
import '../../utiles/colors.dart';
import '../../utiles/dimensioms.dart';

class PopularFoodDitels extends StatelessWidget {
  final int pageId;
  final String page;

  const PopularFoodDitels({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImageSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.BASE_URL + "/uploads/" + product.img!),
                  ),
                ),
              ),
            ),
            Positioned(
              top: Dimensions.Height45,
              left: Dimensions.Width20,
              right: Dimensions.Width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if(page=='cartpage') {
                          Get.toNamed(RoutesHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: ((controller) {
                    return Stack(
                      children: [
                        GestureDetector(onTap: (){
                          if(controller.totaItems>=1)
                          Get.toNamed(RoutesHelper.getCartFood());
                        },
                            child: AppIcon(icon: Icons.shopping_cart_outlined)),
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
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImageSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.Width20,
                    right: Dimensions.Width20,
                    top: Dimensions.Height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumns(
                      text: product.name!,
                    ),
                    SizedBox(
                      height: Dimensions.Height20,
                    ),
                    BigText(text: 'Introduce'),
                    SizedBox(
                      height: Dimensions.Height20,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExandbaleText(
                      text: product.description!,
                    ))),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
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
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.singColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.Width10 / 2,
                        ),
                        BigText(text: popularProduct.cartItems.toString()),
                        SizedBox(
                          width: Dimensions.Width10 / 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.singColor,
                          ),
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
                        popularProduct.addItem(product);
                      },
                      child: BigText(
                        text: '\$ ${product.price!} | Add to Card',
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
        ));
  }
}
