import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/featues/auth/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeApp"),
        centerTitle: true,
      ),
      body: Container(),
    );
    // return Scaffold(
    //   appBar: AppBar(title: const Text("Home")),
    //   body: Obx(()=>ListView.builder(
    //         itemCount: controller.listUsers.length,
    //         itemBuilder: (context, index) {
    //           return ListTile(
    //             leading: const Icon(Icons.person),
    //             title: Text(controller.listUsers[index].name),
    //             subtitle: Text(controller.listUsers[index].email),
    //             onTap: () {},
    //           );
    //         }),
    //   ),
    // );
  }
}
