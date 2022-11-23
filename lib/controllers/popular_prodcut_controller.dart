import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food/Moudel/cart_model.dart';
import 'package:food/Moudel/product_model.dart';
import 'package:food/data/repository/popular_product_repo.dart';
import 'package:food/controllers/cart_controller.dart';
import 'package:food/utiles/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart ;
  bool _isloaded = false;
  bool get isloaded=>_isloaded;

int _quantity=0;
int get quantity=>_quantity;

int _cartItems =0;
int get cartItems=>_cartItems+_quantity;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isloaded=true;
       update();
    } else {}
  }
  void setQuantity(bool isIncrement){
   if(isIncrement){
     _quantity=checkQuantity(_quantity+1);
   }else{
     _quantity=checkQuantity(_quantity-1);
   }
   update();
  }
  int  checkQuantity(int quantity)
  {
    if((_cartItems+quantity)<0){
      Get.snackbar(' Items count', 'You Can`t reduce more !',backgroundColor: AppColors.mainColor,colorText:Colors.white);
      if(_cartItems>0){
        _quantity= - _cartItems;
        return _quantity;

      }
      return 0;
    }else if((_cartItems+quantity)>20){
      Get.snackbar('Items count', 'You Can`t Add more !',backgroundColor: AppColors.mainColor,colorText:Colors.white);
      return 20;
    }else{
      return quantity;

    }

  }
  void initProduct( ProductsMoudel product,CartController cart){
    _quantity=0;
    _cartItems=0;
    _cart=cart;
    var exist = false;
    exist= _cart.existInCart(product);
    if(exist){
      _cartItems=_cart.getQuantity(product);

    }
  }
  void addItem(ProductsMoudel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _cartItems = _cart.getQuantity(product);
    update();
  }
  int get totaItems{
    return _cart.totalItems;
  }
  List<CartMoudel> get getItems{
    return _cart.getItems;
  }

}
