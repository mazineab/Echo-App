import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Constants/colors.dart';
import 'package:myapp/common/drawer/custom_drawer.dart';
import 'package:myapp/common/widgets/image_widget.dart';
import 'package:myapp/featues/home/controller/add_status_controller.dart';
import '../../../common/drawer/custom_drawer_controller.dart';

class AddStatusScreen extends StatelessWidget {
  AddStatusScreen({super.key});

  final controller = Get.find<AddStatusController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:false,
      onPopInvoked: (didPop) {
        Get.find<CustomDrawerController>().setSelectedHome();
        controller.updateMode.value=false;
      },
      child: Scaffold(
        drawer:CustomDrawer(),
        backgroundColor:MyColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: MyColors.appBarColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text("Create status",style: TextStyle(color: Colors.white),),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
                children: [const SizedBox(width: 10,),
              ImageWidget(userName: controller.fullname.value,imageUrl: controller.profileUrl.value),
                  const SizedBox(width: 10),
                  Text(controller.fullname.value,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
              ]
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                  controller: controller.statusController,
                  minLines: 6,
                  maxLines: null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Write you status and share with the world!",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  )),
            ),
            GestureDetector(
              onTap: () {
                controller.showDialogOfTags();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      size: 25,
                      Icons.add,
                      color: Colors.lightBlue,
                    ),SizedBox(width: 3),
                    Padding(
                      padding: EdgeInsets.only(top:2),
                      child: Text(
                        "Montion tags",
                        style: TextStyle(fontSize: 18,color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.listSelectedTags.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.listSelectedTags.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: controller.tagWidget(
                                  tag: controller.listSelectedTags[index]),
                            );
                          }),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              width: double.infinity,
              height: 50,
              child: Obx(
                () => FilledButton(
                    onPressed: () async {
                      if(!controller.updateMode.value){
                        await controller.submitStatus();
                      }else{
                        await controller.updateStatus(controller.idOfStatus.value);
                      }

                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isload.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(controller.buttonText.value)),
              ),
            )
          ],
        )),
      ),
    );
  }
}
