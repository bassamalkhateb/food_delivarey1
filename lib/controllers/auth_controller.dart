import 'package:food/Moudel/ssing_up_model.dart';
import 'package:food/data/repository/auth_repo.dart';
import 'package:food/Moudel/response_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo
  });

  bool _isloading = false;

  bool get isloading => _isloading;

  Future<ResponseModel> regestration(SingUpModel singUpModel) async {
    _isloading = true;
    update();
    Response response = await authRepo.registratoin(singUpModel);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);

      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel>  login(String phone, String password) async {

    _isloading = true;
    update();
    Response response = await authRepo.login(phone,password);
    late ResponseModel responseModel;

    if (response.statusCode == 200|| response.statusCode==201) {
      authRepo.saveUserToken(response.body['token']);
      print(response.body['token'].toString());
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      print(response.statusCode);
      print(response.body);
    }
    _isloading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String phone, String password)  {
   authRepo.saveUserNumberAndPassword(phone, password);
  }
  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }
  bool ClearSharedData(){
    return authRepo.clearSharedData();
  }
}