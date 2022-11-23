import 'package:flutter/material.dart';
import 'package:food/controllers/cart_controller.dart';
import 'package:food/controllers/popular_prodcut_controller.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:get/get.dart';

import 'Pages/home/home_bage_food.dart';
import 'Pages/splash_page/splash_page.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
     return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          title: 'Food',
          //home: SplashPage(),
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesHelper.getSplashFood(),
          getPages: RoutesHelper.routes,
        );
      });
    },);
  }
}
