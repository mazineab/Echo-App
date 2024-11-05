import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Constants/colors.dart';
import 'package:myapp/common/widgets/image_widget.dart';
import 'package:myapp/featues/setting/controller/setting_controller.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({super.key});

  final controller = Get.find<SettingController>();

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
            backgroundColor: MyColors.appBarColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Personal Information',style: TextStyle(color: Colors.white),),
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        const SizedBox(height: 5),
                        editImage(controller.chooseFromGallery),
                      ],
                    );
                  }),
                  const SizedBox(height: 5),
                  buildFieldInformation("First Name", controller.user.value.firstName,controller.textControllerName),
                  const SizedBox(height: 15),
                  buildFieldInformation("Last Name", controller.user.value.lastName,controller.textControllerLastName),
                  const SizedBox(height: 15),
                  buildFieldInformation("Email", controller.user.value.email,controller.textControllerEmail),
                  const SizedBox(height: 15),
                  buildFieldInformation("Phone Number", controller.user.value.phoneNumber,controller.textControllerPhone),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    width: double.infinity,
                      child: const Text("Gender",textAlign: TextAlign.start,style: TextStyle(color: Colors.white),)
                  ),const SizedBox(height: 5),
                  Obx(
                        () => buildGenderRadios(controller.group.value, (String value) {
                          if(value!=controller.group.value){
                            controller.isChange.value=true;
                          }
                      controller.group.value = value;
                    }),
                  ),
                  const SizedBox(height: 20),

                  Obx((){
                    if(controller.isChange.value){
                      return buildButton();
                    }return const SizedBox();
                  }),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 80),
      child: ElevatedButton(
          onPressed: ()async{
            await controller.saveChanges();
          },
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          ),
            backgroundColor: WidgetStatePropertyAll(MyColors.colorbl),
        ),
          child: const Text("Save Changes",style: TextStyle(color: Colors.white),),
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

  Widget buildFieldInformation(String label, String value,TextEditingController textController) {
     // Create TextController once
    textController.text=value;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,style: TextStyle(color: Colors.white),),
            const SizedBox(height: 5),
            Container(
              height: 45,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(
                    169, 243, 240, 240)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: textController,  // Use the created controller
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: value,
                ),
                onChanged: (val){
                  if(value!=textController.text){
                    controller.isChange.value=true;
                  }else{
                    controller.isChange.value=false;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenderRadios(String groupValue, Function(String) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(91, 158, 158, 158)),
                    color: groupValue == "Male"
                        ? Colors.lightBlueAccent.withOpacity(0.5)
                        : null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: RadioListTile(
                    activeColor: Colors.white,
                    title: const Text("Male",style: TextStyle(color: Colors.white)),
                    value: "Male",
                    groupValue: groupValue,
                    onChanged: (value) => onChanged(value??''),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(91, 158, 158, 158)),
                    borderRadius: BorderRadius.circular(5),
                    color: groupValue == "Female"
                        ? const Color.fromARGB(255, 255, 0, 170).withOpacity(0.5)
                        : null,
                  ),
                  child: RadioListTile(
                    activeColor: Colors.white,
                    title: const Text("Female",style: TextStyle(color: Colors.white)),
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
