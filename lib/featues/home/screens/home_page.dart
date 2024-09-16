import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';
import 'package:myapp/routes/routes_names.dart';

import '../../../common/widgets/image_widget.dart';
import '../../../data/models/status.dart';
import '../../../data/models/user.dart' as MyUser;

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
      body: Obx(() {
        if (controller.isLoading.value) {
          // Show loading indicator while data is being fetched
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: controller.listStatus.length,
            itemBuilder: (context, index) {
              Status status = controller.listStatus[index];
              MyUser.User user = controller.listUsers[0];
              // MyUser.User user=controller.listUsers.where((e)=>e.id==status.userId).first;
              for (var e in controller.listUsers) {
                if (e.id == status.userId) {
                  user = e;
                } else {
                  continue;
                }
              }
              return ListTile(
                leading: const ImageWidget(),
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: Text(controller.listStatus[index].content),
              );
            });
      }),
    );
  }
}
