import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food/Pages/home/home_page_sec.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:get/get.dart';


import 'package:get/get.dart';
import '../../controllers/popular_prodcut_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResource()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  void initState(){
    super.initState();
    _loadResource();
    controller = new AnimationController(vsync: this,duration: Duration(seconds: 5))..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      Duration(seconds:6),()=> Get.offNamed(RoutesHelper.getInitial())
    );

  }
  @override
  dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,child: Center(child: Image.asset("assets/splash6.jpg",width: 350,))),
          /*SizedBox(height:10,),*/
          Center(child: Image.asset("assets/splash5.png",width: 450,))
        ],
      ),
    );
  }
}
