import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer.dart';
import 'package:myapp/featues/home/controller/add_status_controller.dart';
import '../../../common/drawer/custom_drawer_controller.dart';

class AddStatusScreen extends StatelessWidget {
  AddStatusScreen({super.key});

  final controller = Get.put(AddStatusController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:false,
      onPopInvoked: (didPop) {
        Get.find<CustomDrawerController>().setSelectedHome();
      },
      child: Scaffold(
        drawer:CustomDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Create status"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/profile.jpeg"),
                        fit: BoxFit.fill)),
              ),
              title: Text(controller.fullname.value),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                  controller: controller.statusController,
                  minLines: 6,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Write you status and share with the world!",
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
                    ),
                    Text(
                      "Montion tags",
                      style: TextStyle(fontSize: 18),
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
                      await controller.submitStatus();
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
                        : const Text("Write status")),
              ),
            )
          ],
        )),
      ),
    );
  }
}
