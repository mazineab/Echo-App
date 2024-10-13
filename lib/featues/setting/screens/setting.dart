import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Constants/colors.dart';
import 'package:myapp/common/widgets/image_widget.dart';

import '../../../common/drawer/custom_drawer.dart';
import '../../../common/drawer/custom_drawer_controller.dart';
import '../controller/setting_controller.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<CustomDrawerController>().setSelectedHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProfileWidget(),
              buildTitle("Account Setting"),
              buildListTile("Personal Information", Icons.person_outline,onTap: controller.goPersonalInfo),
              buildListTile("Password changing", Icons.security_outlined),
              buildListTile("Notifications Preferences", Icons.notifications_outlined),
              buildTitle("Community Setting"),
              buildListTile("Comment List", Icons.comment_outlined),
              buildListTile("Post List", Icons.list_outlined),
              buildTitle("Others"),
              buildListTile("Help", Icons.help_outline),
              buildListTile("FAQ", Icons.help_outline),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          ImageWidget(
                      imageUrl: controller.user.value.imageUrl,
                      userName: controller.user.value.getFullName(),
                    ),
          Expanded(
              child: Column(
            children: [
              ListTile(
                title: Text("${controller.user.value.getFullName()}",style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(controller.user.value.email),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(title,
          style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          )),
    );
  }

  Widget buildListTile(String value,IconData iconPrefix,{VoidCallback? onTap}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        onTap: onTap,
        leading: Icon(iconPrefix),
        title: Text(value,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        trailing: Icon(Icons.chevron_right_sharp,color: MyColors.colorbl,),
      ),
    );
  }
}
