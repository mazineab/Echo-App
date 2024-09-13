import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeApp"),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: const Icon(Icons.logout))
        ],
        // centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.showAlertAddStatus();
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Text("HII"),
      ),
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
