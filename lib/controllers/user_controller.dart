import 'package:food/Moudel/ssing_up_model.dart';
import 'package:food/Moudel/user_model.dart';
import 'package:food/data/repository/auth_repo.dart';
import 'package:food/Moudel/response_model.dart';
import 'package:food/data/repository/user_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });

  bool _isloading = false;
  late UserModel _userModel;
  UserModel get userModel =>_userModel;

  bool get isloading => _isloading;

  Future<ResponseModel> getUserInFo() async {

    Response response = await userRepo.getUserInFo();
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isloading = true;

      responseModel = ResponseModel(true,'successfully');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }
  // Future<ResponseModel>  login(String email, String password) async {
  //   print(authRepo.getUserToken().toString());
  //   _isloading = true;
  //   update();
  //   Response response = await authRepo.login(email,password);
  //   late ResponseModel responseModel;
  //   if (response.statusCode == 200|| response.statusCode==201) {
  //     authRepo.saveUserToken(response.body['token']);
  //     print(response.body['token'].toString());
  //     responseModel = ResponseModel(true, response.body['token']);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText!);
  //     print(response.statusCode);
  //     print(response.body);
  //   }
  //   _isloading = false;
  //   update();
  //   return responseModel;
  // }
  //
  // void saveUserNumberAndPassword(String phone, String password)  {
  //   authRepo.saveUserNumberAndPassword(phone, password);
  // }
  // bool userLoggedIn(){
  //   return authRepo.userLoggedIn();
  // }
  // bool ClearSharedData(){
  //   return authRepo.clearSharedData();
  // }
}