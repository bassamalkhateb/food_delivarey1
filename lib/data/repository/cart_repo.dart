import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Moudel/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];


  void addToCartList(List<CartMoudel> cartList) {
   // sharedPreferences.remove("cart-List");
   //  sharedPreferences.getStringList("cart-history-list");
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time= time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList("Cart-list", cart);
    //print(sharedPreferences.getStringList("Cart-list"));
  }
  List<CartMoudel> getCartList(){

    List<String> carts=[];
    if(sharedPreferences.containsKey("cart-List")){
      carts= sharedPreferences.getStringList("cart-List")!;
    }
      List<CartMoudel> cartList=[];
    carts.forEach((element)=>  CartMoudel.fromJson(jsonDecode(element)));
    return cartList;
  }
  List<CartMoudel> getCartHistoryList(){
    if(sharedPreferences.containsKey("cart-history-list")){
     // cartHistory=[];
      cartHistory=sharedPreferences.getStringList("cart-history-list")!;
    }
    List<CartMoudel>cartListHistory=[];
    cartHistory.forEach((element) =>cartListHistory.add(CartMoudel.fromJson(jsonDecode(element))));
    print(getCartHistoryList().length);
    return cartListHistory;
  }
  void addToCartHistory(){
    if(sharedPreferences.containsKey("cart-history-list")){
      cartHistory=sharedPreferences.getStringList("cart-history-list")!;
    }
    for(int i=0; i<cart.length;i++){
     cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList("cart-history-list", cartHistory);
    print('history is '+getCartHistoryList().length.toString());
    print(cartHistory);

  }
  void removeCart(){
    cart=[];
    sharedPreferences.remove("Cart-list");
  }


}
