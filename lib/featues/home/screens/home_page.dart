import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';
import 'package:myapp/routes/routes_names.dart';

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
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Get.toNamed(RoutesNames.addStatus);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: const Text("HII"),
      ),
    );
  }
}
