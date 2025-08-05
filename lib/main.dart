
import 'package:togarak/core/exports.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiProvider(
        providers: providers,
        child: MaterialApp.router(
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
        ),
      ),
    );
  }
}
