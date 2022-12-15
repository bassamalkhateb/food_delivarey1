import 'package:food/Moudel/address_model.dart';
import 'package:food/utiles/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../Api/api_client.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response>getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URL}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
  }
  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDREESS_URL)??"";
  }
  Future<Response> addAddress (AddressModel addressModel) async {
    return await  apiClient.postData(AppConstants.ADD_ADDRESS_USER, addressModel.toJson());
  }
 Future<Response> getAllAddress()async{
    return  await  apiClient.getData(AppConstants.ADDRESS_LIST_URL);
  }
  Future <bool> saveUserAddress (String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDREESS_URL, address);
  }
}
