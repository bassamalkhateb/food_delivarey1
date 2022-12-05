import 'package:flutter/material.dart';
import 'package:food/Widgets/Big_text.dart';
import 'package:food/Widgets/app_text_filed.dart';
import 'package:food/controllers/auth_controller.dart';
import 'package:food/controllers/location_controller.dart';
import 'package:food/controllers/user_controller.dart';
import 'package:food/utiles/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utiles/dimensioms.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
  CameraPosition(target: LatLng(45.51563, 122.677433), zoom: 17);
  late LatLng _initialPosition = LatLng(45.51563, 122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get
        .find<UserController>()
        .userModel == null) {
      Get.find<UserController>().getUserInFo();
    }
    if (Get
        .find<LocationController>()
        .addressList
        .isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
            double.parse(Get
                .find<LocationController>()
                .getAddress['latitude']),
            double.parse(Get
                .find<LocationController>()
                .getAddress['longitude']),
          ));
      _initialPosition = LatLng(
        double.parse(Get
            .find<LocationController>()
            .getAddress['latitude']),
        double.parse(Get
            .find<LocationController>()
            .getAddress['longitude']),
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
          if (Get
              .find<LocationController>()
              .addressList
              .isNotEmpty) {
            _addressController.text = Get
                .find<LocationController>()
                .getUserAddress()
                .address;
          }
        }


        return GetBuilder<LocationController>(builder: (locationController) {
          _addressController.text =
          '${locationController.placemark.name ?? ''}'
              '${locationController.placemark.locality ?? ''}'
              '${locationController.placemark.postalCode ?? ''}'
              '${locationController.placemark.country ?? ''}';
          print('address in my viwe is ' + _addressController.text);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                      initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
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
              SizedBox(height: Dimensions.Height20+Dimensions.Height20,
                child: ListView.builder(
                    itemCount: locationController.addressTypeList.length,
                    itemBuilder: (context , index){
                return InkWell(
                  onTap: (){
                    locationController.setAddressTypeIndex(index);
                  },
                  child: Container(

                  ),
                );
              }),),
              
              SizedBox(height: Dimensions.Height20,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.Width20),
                child: BigText(text: 'Delivery Address'),
              ),
              SizedBox(height: Dimensions.Height10,),
              AppTextFiled(textController: _addressController,
                  hintText: 'Your address',
                  icon: Icons.map),
              SizedBox(height: Dimensions.Height20,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.Width20),
                child: BigText(text: 'Content Name'),
              ),
              SizedBox(height: Dimensions.Height10,),
              AppTextFiled(textController: _contactPersonName,
                  hintText: 'Your Name',
                  icon: Icons.person),
              SizedBox(height: Dimensions.Height20,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.Width20),
                child: BigText(text: 'Number Phone'),
              ),
              SizedBox(height: Dimensions.Height10,),
              AppTextFiled(textController: _contactPersonNumber,
                  hintText: 'Your Phone',
                  icon: Icons.phone)


            ],
          );
        },);
      }),
    );
  }
}