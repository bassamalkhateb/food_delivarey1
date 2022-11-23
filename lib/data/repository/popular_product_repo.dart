//import 'package:food/Pages/data/Api/api_client.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Api/api_client.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList()  {
    return  apiClient.getData(AppConstants.POPULAR_URL);
  }
}
