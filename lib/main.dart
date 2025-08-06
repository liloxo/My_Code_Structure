import 'package:flutter/material.dart';
import 'package:my_code_structure/app.dart';
import 'package:my_code_structure/core/design_system/routes.dart';
import 'package:my_code_structure/core/network/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppInjection.init();
  runApp(App(appRouter: AppRouter()));
}
