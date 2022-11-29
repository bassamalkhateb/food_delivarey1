import 'package:food/Pages/Food/popular_food_ditels.dart';
import 'package:food/Pages/Food/recommend_food_ditels.dart';
import 'package:food/Pages/auth/sing_in_page.dart';
import 'package:food/Pages/cart/cart_page.dart';
import 'package:food/Pages/home/home_bage_food.dart';
import 'package:food/Pages/home/home_page_sec.dart';
import 'package:food/Pages/splash_page/splash_page.dart';
import 'package:get/get.dart';



class RoutesHelper{
  static const String splashFood ="/splash-food";
  static const String initial ="/";
  static const String popularFood ="/popular-food";
  static const String cartFood ="/cart-food";
  static const String recommendedFood ="/recommended-food";
  static const String singIn ="/sing-in";

  static String getSingInPage()=>'$singIn';

  static String getInitial()=>'$initial';
  static String getSplashFood()=>'$splashFood';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartFood()=>'$cartFood';


  static List<GetPage> routes =[
    GetPage(name: singIn, page: () {

      return SingInPage();
    },transition: Transition.fadeIn),
    GetPage(name: initial, page: () {

     return HomePageSec();
    },transition: Transition.fadeIn),
    GetPage(name: splashFood, page: () {

      return SplashPage();
    },transition: Transition.fadeIn),
    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];

      return PopularFoodDitels(pageId: int.parse(pageId!),page:page!);
    },transition: Transition.fadeIn),
    GetPage(name: recommendedFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendFoodditals(pageId:int.parse(pageId!) ,page:page!);
    },transition: Transition.fadeIn),
    GetPage(name: cartFood, page: (){
      return CartPage();
    },transition: Transition.fadeIn),



  ];
}