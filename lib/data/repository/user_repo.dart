import 'package:food/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Api/api_client.dart';

class UserRepo extends GetxService {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
 Future<Response>getUserInFo()async{
   return await apiClient.getData(AppConstants.USER_INFO_URL);

 }
}