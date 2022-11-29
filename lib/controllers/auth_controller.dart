import 'package:food/Moudel/ssing_up_model.dart';
import 'package:food/data/repository/auth_repo.dart';
import 'package:food/data/repository/response_model.dart';
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      print(response.body['token'].toString());
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel>  login(String email, String password) async {
    _isloading = true;
   update();
    Response response = await authRepo.login(email,password);
    late ResponseModel responseModel;
   print(response.body);

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

  void saveUserNumberAndPassword(String email, String password)  {
   authRepo.saveUserNumberAndPassword(email, password);
  }
  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }
}