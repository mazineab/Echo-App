import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/routes/routes.dart';
import 'package:myapp/routes/routes_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Get.put(SharedPredManager()).init();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: dotenv.env['API_KEY']??'',
          appId: dotenv.env['APP_ID']??'',
          messagingSenderId: dotenv.env['messagingSenderId']??'',
          projectId: dotenv.env['projectId']??'',
      ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialBinding: HomeBinding(),
      getPages: Routes.getApp(),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? RoutesNames.login
          : RoutesNames.home,
      // initialRoute: Routesnames.register,
    );
  }
}
