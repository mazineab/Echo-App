import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/dialogs/custom_snackbar.dart';
import 'package:myapp/data/repositories/status_repo.dart';
import 'package:myapp/featues/home/controller/profile_controller.dart';
import 'package:myapp/featues/setting/controller/status_comment_controller.dart';

class AskDialog{

  static void showDeleteConfirmationDialog(BuildContext context,String statusId,String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40),
                const SizedBox(height: 10),
                const Text(
                  "Are you sure?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Do you really want to delete this status? This process cannot be undone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: ()async {
                        try{
                          await Get.find<StatusRepo>().deleteStatus(statusId);
                          if (Get.isRegistered<ProfileController>()) {
                            Get.find<ProfileController>().getUserStatus(userId);
                            Get.find<ProfileController>().getCountOfStatus();
                          }
                          if (Get.isRegistered<StatusCommentController>()) {
                            Get.find<StatusCommentController>().fetchStatus();
                          }
                          Navigator.of(context).pop();
                        }catch(e){
                          CustomSnackbar.showErrorSnackbar(Get.context!,"SameThing went wrong");
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}