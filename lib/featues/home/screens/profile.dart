import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Constants/colors.dart';
import 'package:myapp/common/widgets/custom_status_widget.dart';
import 'package:myapp/common/widgets/image_widget.dart';
import 'package:myapp/featues/home/controller/profile_controller.dart';
import '../../../common/drawer/custom_drawer.dart';
import '../../../common/drawer/custom_drawer_controller.dart';
import '../../../data/models/enums.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  bool isMyProfile;
  String? userId;
  Profile({super.key, this.isMyProfile = true, this.userId});
  // late final ProfileController controller;
  @override
  Widget build(BuildContext context) {
    userId ??= Get.arguments;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.find<CustomDrawerController>().setSelectedHome();
      },
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: MyColors.appBarColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
              GestureDetector(
                onTap: (){
                  if(controller.user.value.imageUrl!=null){
                    controller.showImageDialog(controller.user.value.imageUrl!);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10),
                  child:ImageWidget(width: 100,height: 100,imageUrl:controller.user.value.imageUrl??'',userName: controller.user.value.getFullName(),),
                ),
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
                              color: Colors.white,
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Obx((){
                            if(controller.statusCount.value!=-1 && controller.statusCount.value!=0){
                              return Text("${controller.statusCount.value} posts",style: TextStyle(color: Colors.white));
                            }
                            return const SizedBox();
                          })
                        ]),
                    Text(
                      controller.user.value.email,
                      style: const TextStyle(
                          color: Colors.white70),
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
                    255, 29, 170, 247),
                labelColor: const Color.fromARGB(200, 33, 149,
                    243),
                unselectedLabelColor:Colors.white70
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    listViewStatus(controller),
                    SingleChildScrollView(child: buildAbout(controller)),
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
              ? Text(isMyProfile?"You don't have any statuses in this app yet.":"No statuses found for this user. Check back later!",style: TextStyle(color: Colors.white),)
              : Expanded(
                  child: ListView.builder(
                      itemCount: controller.listStatus.length,
                      itemBuilder: (context, index) {
                        return CustomStatusWidget(
                            profileUrl: controller.listStatus[index].profileUrl??'',
                            fullName:controller.listStatus[index].fullUserName ?? '',
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
        buildInformation("First Name", controller.user.value.firstName),
        buildInformation("Last Name", controller.user.value.lastName),
        buildInformation("Email", controller.user.value.email),
        buildInformation("Sexe",
            controller.user.value.sexe == Sexe.male ? "Male" : "Female"),
        buildInformation("Bio", controller.user.value.bio ?? ''),
        buildInformation("Phone Number", controller.user.value.phoneNumber),
      ],
    );
  }

  Widget buildInformation(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[900], // Dark background color
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2), // Slight shadow for depth
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White color for the title
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey, // Lighter color for the content
            ),
          ),
        ],
      ),
    );
  }


}
