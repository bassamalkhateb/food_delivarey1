import 'package:food/Moudel/ssing_up_model.dart';
import 'package:food/data/Api/api_client.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences,});

  Future<Response> registratoin(SingUpModel singUpModel) async {
    return await apiClient.postData(
        AppConstants.REGESTRATION_URL, singUpModel.toJson());
  }
  bool userLoggedIn(){
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }
  Future<String>getUserToken(String token) async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URL, {'email': email, 'password': password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, email);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);

    } catch(e){

      throw e ;
    }

  }

}