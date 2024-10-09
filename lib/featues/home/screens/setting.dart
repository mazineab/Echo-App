import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';
import 'package:myapp/common/widgets/image_widget.dart';
import 'package:myapp/featues/home/controller/setting_controller.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(  // Corrected PopScope to WillPopScope
      onWillPop: () async {
        Get.find<CustomDrawerController>().setSelectedHome();
        return false;  // Prevent back navigation
      },
      child: Scaffold(
        appBar: AppBar(),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                GetBuilder<SettingController>(builder: (_) {
                  return Column(
                    children: [
                      Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  height: 100,
                  width: 100,
                  child: ImageWidget(
                      imageUrl: controller.user.value.imageUrl,
                      userName: controller.user.value.getFullName()),
                ),
                      editImage(controller.chooseFromGallery),
                    ],
                  );
                }),
                const SizedBox(height: 10),
                buildFieldInformation("First Name", controller.user.value.firstName),
                const SizedBox(height: 15),
                buildFieldInformation("Last Name", controller.user.value.lastName),
                const SizedBox(height: 15),
                buildFieldInformation("Email", controller.user.value.email),
                const SizedBox(height: 15),
                buildFieldInformation("Phone Number", controller.user.value.phoneNumber),
                const SizedBox(height: 10),
                Obx(
                  () => buildGenderRadios(controller.group.value, (String value) {
                    controller.group.value = value;
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editImage(Function onTap) {
    return GestureDetector(
      onTap: () async {
        await onTap();
        controller.update();  // Force update after editing the image
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.withOpacity(0.8),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Text(
          "Edit image",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildFieldInformation(String label, String value) {
    final TextEditingController textController = TextEditingController(text: value);  // Create TextController once
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 5),
          Container(
            height: 45,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(91, 158, 158, 158)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: textController,  // Use the created controller
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGenderRadios(String groupValue, Function(String) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Gender"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(91, 158, 158, 158)),
                    color: groupValue == "Male"
                        ? Colors.lightBlueAccent.withOpacity(0.4)
                        : null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: RadioListTile(
                    activeColor: Colors.white,
                    title: const Text("Male"),
                    value: "Male",
                    groupValue: groupValue,
                    onChanged: (value) => onChanged(value??''),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(91, 158, 158, 158)),
                    borderRadius: BorderRadius.circular(5),
                    color: groupValue == "Female"
                        ? const Color.fromARGB(255, 255, 0, 170).withOpacity(0.2)
                        : null,
                  ),
                  child: RadioListTile(
                    activeColor: Colors.white,
                    title: const Text("Female"),
                    value: "Female",
                    groupValue: groupValue,
                    onChanged: (value) => onChanged(value??''),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
