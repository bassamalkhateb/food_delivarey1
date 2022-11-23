import 'package:food/data/Api/api_client.dart';
import 'package:food/data/repository/popular_product_repo.dart';
import 'package:food/controllers/popular_prodcut_controller.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/cart_repo.dart';
import '../data/repository/recommended_repo.dart';
import '../controllers/cart_controller.dart';
import '../controllers/recommended_product_controller.dart';
Future<void>init()async{
   final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

   Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));

   Get.lazyPut(() =>  PopularProductRepo(apiClient: Get.find()) );
   Get.lazyPut(() =>  RecommendedProductRepo(apiClient: Get.find()) );
   Get.lazyPut(() =>  CartRepo(sharedPreferences:Get.find()));


   Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
   Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
   Get.lazyPut(() => CartController(cartRepo: Get.find()),) ;


   }