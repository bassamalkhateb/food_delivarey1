import 'package:food/controllers/auth_controller.dart';
import 'package:food/data/Api/api_client.dart';
import 'package:food/data/repository/auth_repo.dart';
import 'package:food/data/repository/popular_product_repo.dart';
import 'package:food/controllers/popular_prodcut_controller.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../controllers/user_controller.dart';
import '../repository/cart_repo.dart';
import '../repository/location_repo.dart';
import '../repository/recommended_repo.dart';
import '../repository/user_repo.dart';


Future<void>init()async{
   final sharedPreferences = await SharedPreferences.getInstance();

  //SharedPreferences
  Get.lazyPut(() => sharedPreferences);

  //BaseURL
   Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences:Get.find()));

   //Repo
   Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
   Get.lazyPut(() =>  UserRepo(apiClient: Get.find()) );
   Get.lazyPut(() =>  PopularProductRepo(apiClient: Get.find()));
   Get.lazyPut(() =>  RecommendedProductRepo(apiClient: Get.find()) );
   Get.lazyPut(() =>  CartRepo(sharedPreferences:Get.find()));
   Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));


  //Controller
   Get.lazyPut(() => AuthController(authRepo: Get.find()));
   Get.lazyPut(() => UserController(userRepo: Get.find(),));
   Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
   Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
   Get.lazyPut(() => CartController(cartRepo: Get.find()),) ;
   Get.lazyPut(() => LocationController(locationRepo: Get.find()));

}