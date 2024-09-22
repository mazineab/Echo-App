import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/featues/home/home_binding.dart';
import 'package:myapp/routes/routes.dart';
import 'package:myapp/routes/routes_names.dart';
import 'common/drawer/custom_drawer_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.put(SharedPredManager()).init();
  Get.put(CustomDrawerController());
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDo3LadhwhejXoDlUxY7Rt-bSE2AV_a9aI",
          appId: '1:591003882523:android:4834660a493be1c60594be',
          messagingSenderId: '591003882523',
          projectId: 'fir-appactions'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: HomeBinding(),
      getPages: Routes.getApp(),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? RoutesNames.login
          : RoutesNames.home,
      // initialRoute: Routesnames.register,
    );
  }
}
