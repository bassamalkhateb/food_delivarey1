import 'package:flutter/material.dart';
import 'package:food/Moudel/address_model.dart';
import 'package:food/Pages/address/pick_address_map.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/Widgets/app_text_filed.dart';
import 'package:food/controllers/auth_controller.dart';
import 'package:food/controllers/location_controller.dart';
import 'package:food/controllers/user_controller.dart';
import 'package:food/routes/routeshelper.dart';
import 'package:food/utiles/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Widgets/App_Icon.dart';
import '../../utiles/dimensioms.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInFo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if(Get.find<LocationController>().getUserAddressFormLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Address Page'),
          backgroundColor: AppColors.mainColor,
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel?.name}';
            _contactPersonNumber.text = '${userController.userModel?.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }

          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.postalCode ?? ''}'
                  '${locationController.placemark.country ?? ''}';
              if(_addressController.text.isEmpty){
                _addressController.text = "Syria Damasucse" ;
              }else{
                _addressController.text = _addressController.text ;
              }
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 2,
                          color: AppColors.mainColor,
                        )),
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: _initialPosition, zoom: 17),
                          onTap: (latLng){
                            Get.toNamed(RoutesHelper.getPickAddress(),
                            arguments: PickAddressMap(fromSignup: false,
                              fromAddress: true,
                              googleMapController: locationController.mapController,

                            ));
                          },
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          onCameraIdle: () {
                            locationController.updatePosition(
                                _cameraPosition, true);
                          },
                          onCameraMove: ((position) =>
                              _cameraPosition = position),
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMapController(controller);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.Width20, top: Dimensions.Height20),
                    child: SizedBox(
                      height: Dimensions.Height20 + Dimensions.Height20,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: locationController.addressTypeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                locationController.setAddressTypeIndex(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.Width20,
                                    vertical: Dimensions.Height10),
                                margin:
                                    EdgeInsets.only(right: Dimensions.Width10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20 / 4),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ]),
                                child: Icon(
                                    index == 0
                                        ? Icons.home_filled
                                        : index == 1
                                            ? Icons.work
                                            : Icons.location_on,
                                    color:
                                        locationController.addressTypeIndex ==
                                                index
                                            ? AppColors.mainColor
                                            : Theme.of(context).disabledColor),
                              ),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.Height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.Width20),
                    child: BigText(text: 'Delivery Address'),
                  ),
                  SizedBox(
                    height: Dimensions.Height10,
                  ),
                  AppTextFiled(
                      textController: _addressController,
                      hintText: 'Your address',
                      icon: Icons.map),
                  SizedBox(
                    height: Dimensions.Height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.Width20),
                    child: BigText(text: 'Content Name'),
                  ),
                  SizedBox(
                    height: Dimensions.Height10,
                  ),
                  AppTextFiled(
                      textController: _contactPersonName,
                      hintText: 'Your Name',
                      icon: Icons.person),
                  SizedBox(
                    height: Dimensions.Height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.Width20),
                    child: BigText(text: 'Number Phone'),
                  ),
                  SizedBox(
                    height: Dimensions.Height10,
                  ),
                  AppTextFiled(
                      textController: _contactPersonNumber,
                      hintText: 'Your Phone',
                      icon: Icons.phone)
                ],
              ));
            },
          );
        }),
        bottomNavigationBar: GetBuilder<LocationController>(
          builder: (locationController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimensions.Height20 * 8,
                  padding: EdgeInsets.only(
                      top: Dimensions.Height30,
                      bottom: Dimensions.Height30,
                      left: Dimensions.Width20,
                      right: Dimensions.Width20),
                  decoration: BoxDecoration(
                      color: AppColors.bottonBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AddressModel _addressModel = AddressModel(
                              addressType: locationController.addressTypeList[
                                  locationController.addressTypeIndex],
                            contactPersonName: _contactPersonName.text,
                            contactPersonNumber: _contactPersonNumber.text,
                            address: _addressController.text,
                            latitude: locationController.position.latitude.toString(),
                            longitude: locationController.position.longitude.toString()
                          );
                          locationController.addAddress(_addressModel).then((response){
                            if(response.isSuccess){
                              Get.toNamed(RoutesHelper.getInitial());
                              Get.snackbar('Address', 'Added Successfully');
                            }else{
                              Get.snackbar('Address', 'Couldn`t save address');
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.Height20,
                              bottom: Dimensions.Height20,
                              left: Dimensions.Width20,
                              right: Dimensions.Width20),
                          child: BigText(
                            text: 'Save Address',
                            color: Colors.white,
                            size: 26,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
