import 'package:food/data/Api/api_client.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList(){
    return  apiClient.getData(AppConstants.RECOMMEND_PRODEUCT_URL);
  }

}