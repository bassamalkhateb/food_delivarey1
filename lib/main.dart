import 'package:flutter/material.dart';
import 'package:food/controllers/cart_controller.dart';
import 'package:food/controllers/popular_prodcut_controller.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'data/helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food Delivery',
            initialRoute: RoutesHelper.getSplashFood(),
            getPages: RoutesHelper.routes,
          );
        });
      },
    );
  }
}
