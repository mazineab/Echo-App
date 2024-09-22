import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/dialogs/myDialog.dart';
import 'package:myapp/common/drawer/custom_drawer.dart';
import 'package:myapp/common/widgets/custom_status_widget.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';
import 'package:myapp/routes/routes_names.dart';

import '../../../common/widgets/image_widget.dart';
import '../../../data/models/status.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Mydialog().dialogExist();
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        drawer: CustomDrawer(),
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
        body: RefreshIndicator(
          onRefresh: () => controller.getStatus(isRefresh: true),
          child: Obx(() {
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
                  leading: ImageWidget(
                    userName: '${controller.fullName}',
                  ),
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
                    child: const Text("Recent Status:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                Expanded(
                  child: controller.isEmptyList.value
                      ? const Center(child: Text("No status yet"))
                      : ListView.builder(
                          itemCount: controller.listStatus.length,
                          itemBuilder: (context, index) {
                            Status status = controller.listStatus[index];
                            return CustomStatusWidget(
                              fullName: status.fullUserName!,
                              status: status,
                            );
                          }),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
