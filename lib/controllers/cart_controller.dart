import 'package:flutter/material.dart';
import 'package:food/Moudel/cart_model.dart';
import 'package:food/Moudel/product_model.dart';
//import 'package:food/Pages/data/repository/cart_repo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../data/repository/cart_repo.dart';
import '../utiles/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartMoudel> _items = {};

  Map<int, CartMoudel> get items => _items;
  List<CartMoudel>storageItems=[];

  void addItem(ProductsMoudel product, int quantity) {
    var totalQuantity=0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CartMoudel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          time: DateTime.now().toString(),
          isExits: true,
          product: product,
        );
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartMoudel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            time: DateTime.now().toString(),
            isExits: true,
            product: product
          );
        });
      } else {
        Get.snackbar('Items count', 'You should at least Add in the cart !',
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

 bool  existInCart(ProductsMoudel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

   int getQuantity(ProductsMoudel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity =0;
    _items.forEach((key, value) {
      value.quantity;
      totalQuantity+=value.quantity!;
    });
    return totalQuantity;
  }
  List<CartMoudel> get getItems{
     return _items.entries.map((e) {
       return e.value;
     }).toList();

  }
  int get totalAmount{
    var total=0;
        _items.forEach((key, value) {
          total += value.quantity!*value.price!;
        });

    return total ;
  }
  List<CartMoudel> getCartData(){
    setCart=cartRepo.getCartList();
     return storageItems;
  }
  set setCart(List<CartMoudel> items){
    storageItems=items;
    for(int i=0; i<storageItems.length;  i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }
  void addToHistory(){
    cartRepo.addToCartHistory();
    clear();
  }
  void clear(){
    _items={};
    update();

  }
  List<CartMoudel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }
  set setItems (Map<int, CartMoudel>setItems){
    _items={};
    _items=setItems;
    update();

  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }
}
