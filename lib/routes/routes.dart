import 'package:get/get.dart';
import 'package:myapp/featues/home/screens/add_status.dart';
import 'package:myapp/featues/home/screens/home_page.dart';
import 'package:myapp/featues/auth/screens/login.dart';
import 'package:myapp/featues/auth/screens/register.dart';
import 'package:myapp/routes/routes_names.dart';

class Routes{
    static getApp()=>[
        GetPage(name: RoutesNames.login, page:()=>Login()),
        GetPage(name: RoutesNames.register, page:()=>Register()),
        GetPage(name: RoutesNames.home, page:()=>HomePage()),
        GetPage(name: RoutesNames.addStatus, page:()=>AddStatusScreen())
    ];
}