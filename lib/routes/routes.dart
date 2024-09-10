import 'package:get/get.dart';
import 'package:myapp/featues/auth/screens/login.dart';
import 'package:myapp/featues/auth/screens/register.dart';
import 'package:myapp/routes/routes_names.dart';

class Routes{
    static getApp()=>[
        GetPage(name: Routesnames.login, page:()=>Login()),
        GetPage(name: Routesnames.register, page:()=>Register())
    ];
}