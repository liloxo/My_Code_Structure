import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_code_structure/core/network/di/injection.dart';
import 'package:my_code_structure/features/login/logic/login_cubit.dart';
import 'package:my_code_structure/features/login/ui/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<LoginCubit>(
                create: (BuildContext context) => sl<LoginCubit>(),
                child: const LoginScreen(),
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
