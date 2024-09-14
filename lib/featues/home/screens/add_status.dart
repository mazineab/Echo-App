import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myapp/featues/home/controller/add_status_controller.dart';

class AddStatusScreen extends StatelessWidget {
  AddStatusScreen({super.key});

  final controller = Get.put(AddStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create status"),
      ),
      body: SizedBox(
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
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
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
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Icon(Icons.add), Text("Montion tags")],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          FilledButton(onPressed: () {}, child: Text("Add"))
        ],
      )),
    );
  }
}
