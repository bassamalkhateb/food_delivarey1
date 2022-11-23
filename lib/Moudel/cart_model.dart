import 'package:food/Moudel/product_model.dart';

class CartMoudel {
  int? id;
  String? name;
  int? price;
  String? img;
  bool ? isExits;
  String? time;
  int ? quantity;
  ProductsMoudel? product;

  CartMoudel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.time,
        this.isExits,
        this.product
        });

CartMoudel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    isExits = json['isExits'];
    quantity = json['quantity'];
    time = json['time'];
    product= ProductsMoudel.fromJson(json['product']);


}
Map<String,dynamic> toJson(){
  return{
    'id':this.id,
    'name':this.name,
    'price':this.price,
    'img':this.img,
    'quantity':this.quantity,
    'isExits':this.isExits,
    'time':this.time,
    'product': this.product!.toJson(),

  };
}

}