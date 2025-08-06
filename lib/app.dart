import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_code_structure/core/design_system/app_theme.dart';
import 'package:my_code_structure/core/design_system/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;
  const App({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'My Code Structure',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/login',
        onGenerateRoute: appRouter.generateRoute,
        navigatorObservers: [NavigatorObserver()],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
