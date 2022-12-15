class AddressModel{
  late int? _id ;
  late String _addressType ;
  late String?_contactPersonName ;
  late String?_contactPersonNumber;
  late String _address ;
  late String _latitude;
  late String _longitude;
   AddressModel({
    id ,
     required addressType ,
     contactPersonName,
     contactPersonNumber,
     latitude,
     longitude,
     address,
   }){
     _id=id;
     _address=address;
     _addressType=addressType;
     _contactPersonName=contactPersonName;
     _contactPersonNumber=contactPersonNumber;
     _latitude=latitude;
     _longitude=longitude;
   }
   String get address =>_address ;
  String get addressType =>_addressType ;
  //int ? get id =>_id ;
  String get latitude =>_latitude ;
  String get longitude =>_longitude ;
  String? get ontactPersonName=>_contactPersonName ;
  String? get ontactPersonNumber=>_contactPersonNumber ;
 AddressModel.fromJson(Map<String,dynamic>json){
   _id=json['id'];
   _contactPersonName=json['contact_person_name']??"";
   _contactPersonNumber=json['contact_person_number']??"";
   _addressType=json['address_type']??"";
   _latitude=json['latitude'];
   _longitude=json['longitude'];

 }
 Map<String, dynamic>toJson(){
   final Map<String,dynamic> data = Map<String,dynamic>();
   data['id']= this._id;
   data['addressType']= this._addressType;
   data['address']=this._address;
   data['latitude']= this._latitude;
   data['longitude']= this._longitude;
   data['contact_person_number']= this._contactPersonNumber;
   data['contact_person_name']= this._contactPersonName;
   return data;
 }


}