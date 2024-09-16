import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/custom_status_widget.dart';
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
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            ListTile(
              leading: const ImageWidget(),
              title: Text("Hello ${controller.fullName}"),
              subtitle: const Text("Welcom Back"),
              trailing: IconButton(
                onPressed: () {
                  controller.logout();
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Recent Status Updates:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
            Expanded(
              child: ListView.builder(
                  itemCount: controller.listStatus.length,
                  itemBuilder: (context, index) {
                    Status status = controller.listStatus[index];
                    MyUser.User user = controller.listUsers[0];
                    for (var e in controller.listUsers) {
                      if (e.id == status.userId) {
                        user = e;
                      } else {
                        continue;
                      }
                    }
                    return CustomStatusWidget(
                      user: user,
                      status: status,
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}
