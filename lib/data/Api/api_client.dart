import 'package:food/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences ;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);

    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders = {
      'Countent-type': 'application/json; charset = UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  void updateHeader(String token){
    _mainHeaders = {
      'Countent-type': 'application/json; charset = UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>?headers}) async {
    try {
      Response response = await get(uri, headers:headers?? _mainHeaders );
      //print(response.body);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response>postData(String uri, dynamic body) async {
    //print(body.toString());
    try {
      Response response = await post(uri, body,headers: _mainHeaders);
     // print(response.toString());
      print(response);

      return response;
    } catch (e) {

      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}
