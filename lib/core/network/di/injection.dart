import 'package:get_it/get_it.dart';
import 'package:my_code_structure/core/network/apis/api_services.dart';
import 'package:my_code_structure/features/login/data/login_data.dart';
import 'package:my_code_structure/features/login/logic/login_cubit.dart';

final GetIt sl = GetIt.instance;

class AppInjection {
  static Future<void> init() async {
    // Dio && ApiService
    sl.registerLazySingleton<ApiServices>(
      () =>
          ApiServices(baseUrl: 'https://api.example.com', initialAuthToken: ''),
    );

    //login
    sl.registerLazySingleton<LoginData>(() => LoginData(sl()));
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  }
}
