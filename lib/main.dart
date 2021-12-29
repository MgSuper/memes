import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllers/auth_controller.dart';
import 'package:memes/screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInitialization.then((value) async {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // unknownRoute: GetPage(name: '/notfound', page: () => UnknownScreen()),
      home: SplashScreen(),
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/detail',
          page: () => DetailScreen(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileScreen(),
        ),
      ],
      // routingCallback: (routing) {
      //   if (routing!.current == '/detail') {
      //     openAds();
      //   }
      // },
    );
  }

  openAds() {
    Get.snackbar('Ads', 'Ads Will Open');
  }
}
