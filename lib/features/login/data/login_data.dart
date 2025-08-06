import 'package:dartz/dartz.dart';
import 'package:my_code_structure/core/network/apis/api_services.dart';
import 'package:my_code_structure/features/login/domain/login_model.dart';

class LoginData {
  final ApiServices apiServices;

  LoginData(this.apiServices);

  Future<Either<NetworkError, LoginModel>> login(
    String email,
    String password,
  ) async {
    var response = await apiServices.postFormData(
      '/login',
      formData: {'email': email, 'password': password},
    );
    return response.fold(
      (l) => Left(NetworkError(l.message, l.statusCode)),
      (r) => Right(LoginModel.fromJson(r.data)),
    );
  }
}
