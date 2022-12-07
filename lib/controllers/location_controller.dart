import 'dart:convert';

import 'package:food/data/repository/location_repo.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Moudel/address_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;

  bool get loading => _loading;
  late Position _position;

  Position get position => _position;
  late Position _pickPosition;

  Position get pickPosition => _pickPosition;
  Placemark _placemark = Placemark();

  Placemark get placemark => _placemark;
  Placemark _pickPlacemark = Placemark();

  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddresslist;

  List<String> _addressTypeList = ['home', 'office', 'others'];
  List<String> get addressTypeList=>_addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex=>_addressTypeIndex;

  late GoogleMapController _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.longitude,
              latitude: position.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.longitude,
              latitude: position.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressfromGeocode(
              LatLng(position.latitude, position.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = 'Unknown Location Found';
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
    } else {
      print('Error getting the google api');
    }
    return _address;
  }

  late Map<String, dynamic> _getAddress;

  Map get getAddress => _getAddress;

   AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }
  void setAddressTypeIndex(int index){
     _addressTypeIndex =index;
     update();
  }
}
