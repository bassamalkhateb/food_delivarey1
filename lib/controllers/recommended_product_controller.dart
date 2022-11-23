import 'dart:convert';

import 'package:food/Moudel/product_model.dart';
import 'package:food/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/repository/recommended_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isloaded = false;
  bool get isloaded=>_isloaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isloaded=true;
      update();
    } else {}
  }
}
