import 'package:flutter/material.dart';
import 'package:food/Pages/base/custom_loading.dart';
import 'package:food/controllers/location_controller.dart';
import 'package:food/utiles/colors.dart';
import 'package:food/utiles/dimensioms.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;

  final bool fromAddress;

  final GoogleMapController? googleMapController;

  PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;

  late GoogleMapController _mapController;

  late CameraPosition _cameraPosition;

  @override
  void initState() {
    //TODO : implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initalPosition = LatLng(45.51563, -122.677433);
      _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initalPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
              child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initalPosition,
                    zoom: 17,
                  ),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/customer_location.png",
                            height: 50,
                            width: 50,
                          )
                        : CustomLoading()),
                Positioned(
                    top: Dimensions.Height45,
                    right: Dimensions.Width20,
                    left: Dimensions.Width20,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.Width10),
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20 / 2)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 25,
                            color: AppColors.yellowColor,
                          ),
                          Expanded(
                            child: Text(
                              '${locationController.pickPlacemark.name ?? ''}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font16
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )),
        ),
      );
    });
  }
}
