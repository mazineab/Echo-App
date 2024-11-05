import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Constants/colors.dart';
import 'package:myapp/common/dialogs/my_dialog.dart';
import 'package:myapp/common/drawer/custom_drawer.dart';
import 'package:myapp/common/widgets/custom_status_widget.dart';
import 'package:myapp/featues/home/controller/add_status_controller.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';
import 'package:myapp/featues/home/screens/profile.dart';
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
          MyDialog().dialogExist();
        }
      },
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor:MyColors.appBarColor,
        ),
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () {
            Get.put(AddStatusController());
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
            if (controller.isLoading.value && controller.fullName.value.isNotEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: ImageWidget(imageUrl: controller.imageUrl.value,userName: controller.fullName.value),
                  title: Text("Hello ${controller.fullName}",style: TextStyle(color: Colors.white)),
                  subtitle: const Text("Welcom Back",style: TextStyle(color: Colors.grey),),
                  onTap: () {
                    Get.to(Profile(isMyProfile: true, userId: controller.myId.value));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text("Recent Status:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white))),
                SizedBox(height: 10),
                Expanded(child: StreamBuilder(
                    stream:controller.getStatuss(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No statuses yet! Start by sharing one!",style: TextStyle(color: Colors.white),));
                      }
                      List<Status> listStatus=snapshot.data!;
                      return ListView.builder(
                          itemCount: listStatus.length,
                          itemBuilder: (context,index){
                            Status status = listStatus[index];
                            return CustomStatusWidget(
                              profileUrl: status.profileUrl ?? '',
                              fullName: status.fullUserName!,
                              status: status,
                            );
                      });
                    }
                ))
              ],
            );
          }),
        ),
      ),
    );
  }
}
