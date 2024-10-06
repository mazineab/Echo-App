import 'package:get/get.dart';
import 'package:myapp/featues/home/home_binding.dart';
import 'package:myapp/featues/home/screens/add_status.dart';
import 'package:myapp/featues/home/screens/home_page.dart';
import 'package:myapp/featues/auth/screens/login.dart';
import 'package:myapp/featues/auth/screens/register.dart';
import 'package:myapp/featues/home/screens/profile.dart';
import 'package:myapp/featues/home/screens/setting.dart';
import 'package:myapp/routes/routes_names.dart';

class Routes{
    static getApp()=>[
        GetPage(name: RoutesNames.login, page:()=>Login()),
        GetPage(name: RoutesNames.register, page:()=>Register()),
        GetPage(name: RoutesNames.home, page:()=>HomePage(),binding: HomeBinding()),
        GetPage(name: RoutesNames.addStatus, page:()=>AddStatusScreen()),
        GetPage(name: RoutesNames.profile, page:()=>Profile()),
        GetPage(name: RoutesNames.setting, page:()=>const Setting()),
    ];
}