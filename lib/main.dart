
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'app/routes/app_pages.dart';
void main() async{
  void printFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  printFcmToken();
  tz.initializeTimeZones();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // final currentTheme = ThemesController.getCurrentTheme();
    final MediaQueryData data = MediaQuery.of(context);

    return MediaQuery(
      data: data.copyWith(
        textScaler: const TextScaler.linear(1), // Maintain consistent text scaling
      ),
      child: ScreenUtilInit(
        designSize: const Size(360, 690), // Standard design size for responsiveness
        splitScreenMode: true, // Better multi-window support
        minTextAdapt: true, // Adapt text for smaller screens
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "ToDoApp",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        },
      ),
    );
  }
}