import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/custom_status_widget.dart';
import 'package:myapp/featues/home/controller/profile_controller.dart';
import '../../../common/drawer/custom_drawer.dart';
import '../../../common/drawer/custom_drawer_controller.dart';
import '../../../data/models/enums.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  bool isMyProfile;
  final String? userId;
  Profile({super.key, this.isMyProfile = true, this.userId});
  // late final ProfileController controller;
  @override
  Widget build(BuildContext context) {
    // if (isMyProfile) {
    //   controller = Get.put(ProfileController());
    //   print("HIII MY Profile");
    // } else {
    //   controller = Get.put(ProfileController());
    //   controller.userId.value = userId!;
    //   print("HIII IS NOT MY Profile");
    //   controller.onReady();
    // }
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.find<CustomDrawerController>().setSelectedHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: CustomDrawer(),
        body: GetBuilder<ProfileController>(
          init: ProfileController()..userId.value = userId ?? '',
          builder: (controller) =>
          controller.isLoading.value
           ? const Center(child: CircularProgressIndicator())
          :Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 10),
                child: CustomDrawer().buildHeader(isDrawer: false),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.user.value.getFullName(),
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const Text("14 posts")
                        ]),
                    Text(
                      controller.user.value.email,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 46, 46, 46)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      controller.user.value.bio ?? "",
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                controller: controller.tabController,
                tabs: const [Tab(text: "Posts"), Tab(text: "About")],
                indicatorColor: const Color.fromARGB(
                    255, 29, 170, 247), // Changes the color of the indicator
                labelColor: const Color.fromARGB(200, 33, 149,
                    243), // Changes the color of the selected label
                unselectedLabelColor: const Color.fromARGB(
                    255, 0, 0, 0), // Changes the color of unselected labels
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    listViewStatus(controller),
                    buildAbout(controller), // Content for second tab
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listViewStatus(ProfileController controller) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          controller.isEmptyList.value
              ? const Text("No status yet!")
              : Expanded(
                  child: ListView.builder(
                      itemCount: controller.listStatus.length,
                      itemBuilder: (context, index) {
                        return CustomStatusWidget(
                            fullName:
                                controller.listStatus[index].fullUserName ?? '',
                            status: controller.listStatus[index]);
                      }),
                ),
        ],
      );
    });
  }

  Widget buildAbout(ProfileController controller) {
    return Column(
      children: [
        const SizedBox(height: 10),
        buildRowInformation("First Name", controller.user.value.firstName),
        buildRowInformation("Last Name", controller.user.value.lastName),
        buildRowInformation("Email", controller.user.value.email),
        buildRowInformation("Sexe",
            controller.user.value.sexe == Sexe.male ? "Male" : "Female"),
        buildRowInformation("Bio", controller.user.value.bio ?? ''),
        buildRowInformation("Phne Number", controller.user.value.phoneNumber),
      ],
    );
  }

  Widget buildRowInformation(String title, String content) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            // flex: 2,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.right,
            ),
            // flex: 3,
          )
        ],
      ),
    );
  }
}
