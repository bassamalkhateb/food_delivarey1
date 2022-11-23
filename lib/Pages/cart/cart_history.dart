// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:food/Widgets/App_Icon.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/controllers/cart_controller.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:get/get.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
    Map<String, int> cartItemsPreOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPreOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPreOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPreOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderTimesToList() {
      return cartItemsPreOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPreOrder = cartOrderTimesToList();
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
          Expanded(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: '03/02/1999'),
                              SizedBox(
                                height: Dimensions.Height10,
                              ),
                              Row(
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPreOrder[i],
                                          (index) {
                                        if (listCounter <
                                            getCartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return Container(
                                          height: 80,
                                          width: 80,
                                          margin: EdgeInsets.only(right: Dimensions.Width10/5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstants.BASE_URL +"/uploads/" +getCartHistoryList[listCounter - 1].img!,
                                                  ))),
                                        );
                                      }))
                                ],
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: Dimensions.Height20),
                        )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
