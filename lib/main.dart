import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:togarak/core/dependency/providers.dart';
import 'package:togarak/core/navigation/router.dart';

import 'core/utils/app_colors.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {

  runApp(
    MultiBlocProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.routes,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColors.back1Color,
            textTheme: GoogleFonts.manropeTextTheme(),
            // fallback background
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryBlueColor,
              brightness: Brightness.light,
            ),
          ),
        );
      },
    );
  }
}
