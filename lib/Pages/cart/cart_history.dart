// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food/Moudel/cart_model.dart';
import 'package:food/Pages/base/no_data_page.dart';
import 'package:food/Widgets/App_Icon.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/Widgets/small_text.dart';
import 'package:food/controllers/cart_controller.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPreOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPreOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPreOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPreOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsOrderToList() {
      return cartItemsPreOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimesToList() {
      return cartItemsPreOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPreOrder = cartItemsOrderToList();
    var listCounter = 0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: 100,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: ((controller) {
            return controller.getItems.length > 0
                ? Expanded(
                    child: Container(
                        height: 500,
                        margin: EdgeInsets.only(
                            top: Dimensions.Height20,
                            left: Dimensions.Width20,
                            right: Dimensions.Width20),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < itemsPreOrder.length; i++)
                                Container(
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (() {
                                        DateTime pareseDate = DateFormat(
                                                'yyyy-MM-dd HH:mm:ss')
                                            .parse(
                                                getCartHistoryList[listCounter]
                                                    .time!);
                                        var inputDate = DateTime.parse(
                                            pareseDate.toString());
                                        var outputFormat =
                                            DateFormat('MM/dd/yyyy hh:mm a');
                                        var outputDate =
                                            outputFormat.format(inputDate);
                                        return BigText(text: outputDate);
                                      }()),
                                      SizedBox(
                                        height: Dimensions.Height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  itemsPreOrder[i], (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        height: 80,
                                                        width: 80,
                                                        margin: EdgeInsets.only(
                                                            right: Dimensions
                                                                    .Width10 /
                                                                5),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            Dimensions.radius15 /
                                                                                2),
                                                                image:
                                                                    DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image:
                                                                            NetworkImage(
                                                                          AppConstants.BASE_URL +
                                                                              "/uploads/" +
                                                                              getCartHistoryList[listCounter - 1].img!,
                                                                        ))),
                                                      )
                                                    : Container();
                                              })),
                                          Container(
                                            height: 80,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: 'Total',
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text: itemsPreOrder[i]
                                                          .toString() +
                                                      " Items ",
                                                  color:
                                                      AppColors.mainBlackColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimesToList();
                                                    Map<int, CartMoudel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[
                                                                    j]
                                                                .id!,
                                                            () => CartMoudel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RoutesHelper
                                                        .getCartFood());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions
                                                                    .Width10,
                                                            vertical: Dimensions
                                                                    .Height10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor),
                                                    ),
                                                    child: SmallText(
                                                      text: "one More",
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.Height20),
                                )
                            ],
                          ),
                        )),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                        child: NoDataPage(
                            text: 'You didn`t buy anything so far !')));
          }))
        ],
      ),
    );
  }
}
