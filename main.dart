import 'package:flutter/material.dart';
import 'package:my_code_structure/app.dart';
import 'package:my_code_structure/core/design_system/routes.dart';
import 'package:my_code_structure/core/network/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInjection.init();
  runApp(App(appRouter: AppRouter()));
}
