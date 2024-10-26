import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Constants/colors.dart';
import 'package:myapp/common/widgets/custom_status_widget.dart';
import '../controller/status_comment_controller.dart';

class StatusList extends StatelessWidget {
  StatusList({super.key});

  final StatusCommentController controller = Get.put(StatusCommentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 40.0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Your Status'),
            ),
          ),
          Obx(() {
            if (controller.isLoad.value) {
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
            }else if(!controller.isLoad.value && controller.listStatus.isEmpty){
              return const SliverFillRemaining(
                child: Center(
                  child: Text("You don't have any statuses in this app yet.")
                ),
              );
            }
            else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final status = controller.listStatus[index];
                    return CustomStatusWidget(
                      profileUrl: status.profileUrl ?? '',
                      fullName: status.fullUserName ?? '',
                      status: status,
                    );
                  },
                  childCount: controller.listStatus.length,
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
