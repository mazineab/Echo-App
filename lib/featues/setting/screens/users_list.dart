import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Constants/colors.dart';
import 'package:myapp/common/widgets/custom_list_tile.dart';
import 'package:myapp/featues/setting/controller/users_list_controller.dart';

class UsersList extends StatelessWidget {
  UsersList({super.key});

  UsersListController controller=Get.put(UsersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 40.0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('USERS',style: TextStyle(color: Colors.white),),
            ),
            backgroundColor: MyColors.appBarColor,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          GetBuilder<UsersListController>(
              builder: (_){
                if(controller.isLoad.value){
                  return SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            backgroundColor: MyColors.colorbl,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final user = controller.listUsers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomListTile(title: user.getFullName(), subtitle: user.email, userId: user.id,profileUrl: user.imageUrl,),
                      );
                    },
                    childCount: controller.listUsers.length,
                  ),
                );
          })
        ],
      ),
    );
  }
}
